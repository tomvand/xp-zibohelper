if PLANE_ICAO == "B738" then
    logMsg("ZiboHelper: detected PLANE_ICAO == B738")


    -- Datarefs
    dataref("dr_flap", "laminar/B738/flt_ctrls/flap_lever")
    dataref("dr_fd_cpt", "laminar/B738/switches/autopilot/fd_ca", "writeable")
    dataref("dr_fd_fo", "laminar/B738/switches/autopilot/fd_fo", "writeable")
    dataref("dr_fd_cpt_pos", "laminar/B738/autopilot/flight_director_pos")
    dataref("dr_fd_fo_pos", "laminar/B738/autopilot/flight_director_fo_pos")
    dataref("dr_speedbrake", "laminar/B738/flt_ctrls/speedbrake_lever")
    dataref("dr_throttle_all", "sim/cockpit2/engine/actuators/throttle_ratio_all")
    dataref("dr_gear", "laminar/B738/switches/landing_gear")
    dataref("dr_groundspeed", "sim/flightmodel/position/groundspeed")
    dataref("dr_elv_trim", "sim/flightmodel/controls/elv_trim")
    dataref("dr_land_lights_left", "laminar/B738/switch/land_lights_left_pos", "writeable")
    dataref("dr_land_lights_right", "laminar/B738/switch/land_lights_right_pos", "writeable")
    dataref("dr_transponder_pos", "laminar/B738/knob/transponder_pos")
    dataref("dr_elv_trim", "sim/flightmodel/controls/elv_trim")
    dataref("dr_trim_pos", "laminar/B738/switch/capt_trim_pos")
    dataref("dr_lower_du", "laminar/B738/systems/lowerDU_page")
    dataref("dr_autobrake", "laminar/B738/autobrake/autobrake_pos")
    dataref("dr_mcp_alt", "laminar/B738/autopilot/mcp_alt_dial")
    dataref("dr_mcp_spd", "sim/cockpit2/autopilot/airspeed_dial_kts_mach")
    dataref("dr_starter1", "laminar/B738/engine/starter1_pos")
    dataref("dr_starter2", "laminar/B738/engine/starter2_pos")
    dataref("dr_temp_ambient", "sim/weather/temperature_ambient_c")
    dataref("dr_eng_ai1", "laminar/B738/ice/eng1_heat_pos")
    dataref("dr_eng_ai2", "laminar/B738/ice/eng2_heat_pos")
    dataref("dr_wing_ai", "laminar/B738/ice/wing_heat_pos")
    dataref("dr_probe_cpt", "laminar/B738/toggle_switch/capt_probes_pos", "writeable")
    dataref("dr_probe_fo", "laminar/B738/toggle_switch/fo_probes_pos", "writeable")
    -- dataref("dr_apu_switch", "laminar/B738/switches/apu_start") -- does not work
    dataref("dr_apu_door", "laminar/B738/electrical/apu_door")
    dataref("dr_apu_start_load", "laminar/B738/electric/apu_start_load")
    local dr_axis_assignments = dataref_table("sim/joystick/joystick_axis_assignments")
    local dr_axis_values = dataref_table("sim/joystick/joystick_axis_values")


    -- Flap lever display
    logMsg("ZiboHelper: setting up flap lever display...")
    local flap_last = 0.0
    local flap_show_until = 0
    local flap_str_table = {
        [0] = "UP",
        [1] = "1",
        [2] = "2",
        [3] = "5",
        [4] = "10",
        [5] = "15",
        [6] = "25",
        [7] = "30",
        [8] = "40"
    }
    function draw_flap()
        if dr_flap ~= flap_last then
            flap_last = dr_flap
            flap_show_until = os.clock() + 1.5
        end
        if os.clock() < flap_show_until then
            local flap_str = "?"
            local flap_index = math.floor(dr_flap * 8.0 + 0.5)
            if flap_str_table[flap_index] then
                flap_str = flap_str_table[flap_index]
            end
            huge_bubble(0, 0, "FLAPS", flap_str)
        end
    end
    do_every_draw("draw_flap()")
    logMsg("ZiboHelper: ok.")

    
    -- Toggle both FDs
    logMsg("ZiboHelper: setting up FD toggle command...")
    function fd_toggle()
        if dr_fd_cpt == 0 then
            dr_fd_cpt = 1
            dr_fd_fo = 1
        else
            dr_fd_fo = 0
            dr_fd_cpt = 0
        end
    end
    create_command("zibohelper/fd_toggle_both_cpt",
                   "Toggle both flight directors (CPT as MA)",
                   "fd_toggle()",
                   "",
                   "")
    logMsg("ZiboHelper: ok.")


    -- Disconnect A/P and A/T with single button
    logMsg("ZiboHelper: setting up A/P A/T disco command...")
    function ap_at_disco()
        -- Push lights first (so requires second push to silence)
        command_begin("laminar/B738/push_button/ap_light_pilot")
        command_once("laminar/B738/push_button/ap_light_pilot")
        command_end("laminar/B738/push_button/ap_light_pilot")
        command_begin("laminar/B738/push_button/at_light_pilot")
        command_once("laminar/B738/push_button/at_light_pilot")
        command_end("laminar/B738/push_button/at_light_pilot")
        -- Push disconnect buttons
        command_begin("laminar/B738/autopilot/capt_disco_press")
        command_once("laminar/B738/autopilot/capt_disco_press")
        command_end("laminar/B738/autopilot/capt_disco_press")
        command_begin("laminar/B738/autopilot/left_at_dis_press")
        command_once("laminar/B738/autopilot/left_at_dis_press")
        command_end("laminar/B738/autopilot/left_at_dis_press")
    end
    create_command("zibohelper/ap_at_disco",
                   "Disconnect A/P and A/T, push annunciators",
                   "ap_at_disco()",
                   "",
                   "")
    logMsg("ZiboHelper: ok.")


    -- Speedbrake ARM toggle
    logMsg("ZiboHelper: setting up speedbrake ARM toggle command...")
    local speedbrake_time = 0.0
    local SPEEDBRAKE_HOLD_TIME = 0.5 -- seconds for long press
    function speedbrake_arm_press()
        speedbrake_time = os.clock()
    end
    function speedbrake_arm_hold()
        if speedbrake_time and os.clock() > (speedbrake_time + SPEEDBRAKE_HOLD_TIME) then
            -- arm speedbrake
            command_once("sim/flight_controls/speed_brakes_up_all")
            command_once("sim/flight_controls/speed_brakes_down_one")
            speedbrake_time = 0.0
        end
    end
    function speedbrake_arm_release()
        if os.clock() <= (speedbrake_time + SPEEDBRAKE_HOLD_TIME) then
            -- deploy/retract speedbrake
            if dr_speedbrake == 0.0 then
                -- deploy speedbrake
                command_once("sim/flight_controls/speed_brakes_down_all")
            else
                -- retract speedbrake
                command_once("sim/flight_controls/speed_brakes_up_all")
            end
            speedbrake_time = 0.0
        end
    end
    create_command("zibohelper/speedbrake_arm_toggle",
            "Toggle speedbrake ARM",
            "speedbrake_arm_press()",
            "speedbrake_arm_hold()",
            "speedbrake_arm_release()")
    logMsg("ZiboHelper: ok.")


    -- Speedbrake reminder
    logMsg("ZiboHelper: setting up speedbrake reminder...")
    function speedbrake_reminder_draw()
        if dr_speedbrake > 0.5 and dr_throttle_all > 0.0 then
            glColor4f(1.0, 0.0, 0.0, 1.0)
            draw_string_Helvetica_18(200, SCREEN_HIGHT / 2, "SPEEDBRAKE!")
        end
    end
    do_every_draw("speedbrake_reminder_draw()")


    -- Flap lever hysteresis
    logMsg("ZiboHelper: setting up flap axis hysteresis...")
    local FLAP_AXIS_INDEX = 51 -- hardcoded flap axis number
    local flap_hysteresis = 0.10 -- % flap position
    function flap_hysteresis_loop()
        if dr_axis_values[FLAP_AXIS_INDEX] >= 0.0 then
            if dr_axis_assignments[FLAP_AXIS_INDEX] ~= 0 then
                logMsg("ZiboHelper: disabling axis " .. tostring(FLAP_AXIS_INDEX))
                set_axis_assignment(FLAP_AXIS_INDEX, "none", "normal")
            end
            local flap_h_incr = (dr_flap * 8) + 0.5 + flap_hysteresis
            local flap_h_decr = (dr_flap * 8) - 0.5 - flap_hysteresis
            if dr_axis_values[FLAP_AXIS_INDEX] * 8 > flap_h_incr then
                command_once("sim/flight_controls/flaps_down")
            elseif dr_axis_values[FLAP_AXIS_INDEX] * 8 < flap_h_decr then
                command_once("sim/flight_controls/flaps_up")
            end
        end
    end
    do_every_frame("flap_hysteresis_loop()")
    logMsg("ZiboHelper: ok.")


    -- Taxi in flow
    -- Triggered when:
    --      Flap lever moved to UP (because the joystick axis needs to be moved up manually)
    --      Gear is DOWN
    --      Ground speed < 60kt
    --      Landing lights ON
    -- Automatic actions: see script below
    -- Weather radar is left to the captain
    logMsg("ZiboHelper: setting up taxi in flow...")
    local tif_step = 0
    local tif_time = 0.0
    local tif_previous_flap = 0.0
    function tif_wait(dt)
        tif_time = os.clock() + dt
    end
    function tif_next(dt)
        tif_wait(dt)
        tif_step = tif_step + 1
    end
    function tif_loop()
        -- Check trigger
        if tif_step == 0 then
            if (dr_flap == 0.0 and tif_previous_flap ~= 0.0)
            and (dr_gear == 2)
            and (dr_groundspeed < 30.0)
            and (dr_land_lights_left ~= 0) then
                tif_next(1.0)
            end
            tif_previous_flap = dr_flap
        end
        -- Perform taxi in flow
        if (tif_step > 0) and (os.clock() > tif_time) then
            if tif_step == 1 then
                -- Speed brake UP (normally PF)
                command_once("sim/flight_controls/speed_brakes_up_all")
                tif_next(1.6)
            elseif tif_step == 2 then
                -- Landing lights OFF (Retracts, retract)            
                command_once("laminar/B738/switch/land_lights_ret_left_up")
                command_once("laminar/B738/switch/land_lights_ret_right_up")
                tif_next(0.1)
            elseif tif_step == 3 then
                -- Landing lights OFF (Retracts, off)
                command_once("laminar/B738/switch/land_lights_ret_left_up")
                command_once("laminar/B738/switch/land_lights_ret_right_up")
                tif_next(0.5)
            elseif tif_step == 4 then
                -- Landing lights OFF (all off)
                dr_land_lights_left = 0
                dr_land_lights_right = 0
                tif_next(1.0)
            elseif tif_step == 5 then
                -- Strobe OFF (Pos light off)
                command_once("laminar/B738/toggle_switch/position_light_down")
                tif_next(0.1)
            elseif tif_step == 6 then
                -- Strobe OFF (Pos light steady)
                command_once("laminar/B738/toggle_switch/position_light_down")
                tif_next(1.0)
            elseif tif_step == 7 then
                -- Wipers decrease one (left)
                command_once("laminar/B738/knob/left_wiper_dn")
                tif_next(0.5)
            elseif tif_step == 8 then
                -- Wipers decrease one (right)
                command_once("laminar/B738/knob/right_wiper_dn")
                tif_next(1.5)
            elseif tif_step == 9 then
                -- Transponder ALT OFF
                if dr_transponder_pos > 2 then
                    command_once("laminar/B738/knob/transponder_mode_dn")
                    tif_wait(0.1)
                elseif dr_transponder_pos < 2 then
                    command_once("laminar/B738/knob/transponder_mode_up")
                    tif_wait(0.1)
                else
                    tif_next(1.2)
                end
            elseif tif_step == 10 then
                -- Trim 4.0
                if dr_trim_pos > 0.1 and dr_trim_pos < 0.9 then
                    if dr_elv_trim < -0.51 then
                        command_begin("sim/flight_controls/pitch_trim_up")
                    elseif dr_elv_trim > -0.49 then
                        command_begin("sim/flight_controls/pitch_trim_down")
                    else
                        tif_next(1.0)
                    end
                elseif dr_trim_pos < 0.1 then
                    if dr_elv_trim > -0.51 then
                        command_end("sim/flight_controls/pitch_trim_up")
                    end
                else
                    if dr_elv_trim < -0.49 then
                        command_end("sim/flight_controls/pitch_trim_down")
                    end
                end
            elseif tif_step == 11 then
                -- SYS display ("check" hydraulics)
                if dr_lower_du ~= 2 then
                    command_once("laminar/B738/LDU_control/push_button/MFD_SYS")
                end
                tif_next(2.5)
            elseif tif_step == 12 then
                -- ENG display on
                if dr_lower_du ~= 1 then
                    command_once("laminar/B738/LDU_control/push_button/MFD_ENG")
                end
                tif_next(1.0)
            elseif tif_step == 13 then
                -- Autobrake OFF
                if dr_autobrake < 1 then
                    command_once("laminar/B738/knob/autobrake_up")
                    tif_wait(0.1)
                elseif dr_autobrake > 1 then
                    command_once("laminar/B738/knob/autobrake_dn")
                    tif_wait(0.1)
                else
                    tif_next(1.0)
                end
            elseif tif_step == 14 then
                -- Flight directors OFF
                if dr_fd_fo_pos ~= 0 then
                    command_once("laminar/B738/autopilot/flight_director_fo_toggle")
                    tif_wait(0.8)
                elseif dr_fd_cpt_pos ~= 0 then
                    command_once("laminar/B738/autopilot/flight_director_toggle")
                    tif_wait(0.8)
                else
                    tif_next(0.0)
                end
            elseif tif_step == 15 then
                -- MCP ALT #100
                hundreds = dr_mcp_alt % 1000
                if (hundreds < 100) or (hundreds > 500) then
                    command_once("sim/autopilot/altitude_up")
                    tif_wait(0.1)
                elseif hundreds > 100 then
                    command_once("sim/autopilot/altitude_down")
                    tif_wait(0.1)
                else
                    tif_next(0.6)
                end
            elseif tif_step == 16 then
                -- MCP SPD 100
                if dr_mcp_spd > 100 then
                    command_once("sim/autopilot/airspeed_down")
                else
                    tif_next(1.2)
                end
            elseif tif_step == 17 then
                -- Engine start switches OFF/AUTO
                if dr_starter2 > 1 then
                    command_once("laminar/B738/knob/eng2_start_left")
                    tif_wait(0.6)
                elseif dr_starter1 > 1 then
                    command_once("laminar/B738/knob/eng1_start_left")
                    tif_wait(0.2)
                else
                    tif_next(1.0)
                end
            elseif tif_step == 18 then
                -- Engine anti-ice OFF if OAT > 10*C
                if (dr_temp_ambient > 10.0) and (dr_eng_ai2 ~= 0) then
                    command_once("laminar/B738/toggle_switch/eng2_heat")
                    tif_wait(0.3)
                elseif (dr_temp_ambient > 10.0) and (dr_eng_ai1 ~= 0) then
                    command_once("laminar/B738/toggle_switch/eng1_heat")
                    tif_wait(0.3)
                elseif (dr_temp_ambient > 10.0) and (dr_wing_ai ~= 0) then
                    command_once("laminar/B738/toggle_switch/wing_heat")
                    tif_wait(0.3)
                else
                    tif_next(0.7)
                end
            elseif tif_step == 19 then
                -- Probe heat OFF
                dr_probe_cpt = 0
                dr_probe_fo = 0
                tif_next(60.0)
            elseif tif_step == 20 then
                -- Start APU if not running
                if dr_apu_door == 0 then
                    command_once("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
                    command_begin("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
                    tif_wait(3.0)
                elseif dr_apu_start_load > 0.0 then
                    command_end("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
                    tif_next(0.0)
                else
                    tif_next(0.0)
                end
            else
                tif_step = 0
                tif_time = 0.0
            end
        end
    end
    do_every_frame("tif_loop()")
    logMsg("ZiboHelper: ok.")

end