if PLANE_ICAO == "B738" then
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