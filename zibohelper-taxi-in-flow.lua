if PLANE_ICAO == "B738" then
    dataref("dr_flap", "laminar/B738/flt_ctrls/flap_lever")
    dataref("dr_onground_any", "sim/flightmodel/failures/onground_any")
    dataref("dr_land_lights_left", "laminar/B738/switch/land_lights_left_pos", "writeable")
    dataref("dr_land_lights_right", "laminar/B738/switch/land_lights_right_pos", "writeable")
    dataref("dr_transponder_pos", "laminar/B738/knob/transponder_pos")
    dataref("dr_elv_trim", "sim/flightmodel/controls/elv_trim")
    dataref("dr_trim_pos", "laminar/B738/switch/capt_trim_pos")
    dataref("dr_lower_du", "laminar/B738/systems/lowerDU_page")
    dataref("dr_fd_cpt_pos", "laminar/B738/autopilot/pfd_fd_cmd")
    dataref("dr_fd_fo_pos", "laminar/B738/autopilot/pfd_fd_cmd_fo")
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
    dataref("dr_apu_door", "laminar/B738/electrical/apu_door")
    dataref("dr_apu_start_load", "laminar/B738/electric/apu_start_load")

    -- Taxi in flow
    -- Triggered when:
    --      On ground (sim/flightmodel/failures/onground_any)
    --      Landing lights ON
    --      Flap lever moved to UP (because the joystick axis needs to be moved up manually)
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
            and (dr_onground_any ~= 0)
            and (dr_land_lights_left ~= 0) then
                tif_next(1.0)
            end
            tif_previous_flap = dr_flap
        end
        -- Perform taxi in flow
        if (tif_step > 0) and (os.clock() > tif_time) then
            if tif_step == 1 then
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
            elseif tif_step == 2 then
                -- SYS display ("check" hydraulics)
                if dr_lower_du ~= 2 then
                    command_once("laminar/B738/LDU_control/push_button/MFD_SYS")
                end
                tif_next(2.5)
            elseif tif_step == 3 then
                -- ENG display on
                if dr_lower_du ~= 1 then
                    command_once("laminar/B738/LDU_control/push_button/MFD_ENG")
                end
                tif_next(1.0)
            elseif tif_step == 4 then
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
            elseif tif_step == 5 then
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
            elseif tif_step == 6 then
                -- MCP SPD 100
                if dr_mcp_spd > 100 then
                    command_once("sim/autopilot/airspeed_down")
                else
                    tif_next(1.2)
                end
            elseif tif_step == 7 then
                -- Probe heat OFF
                dr_probe_cpt = 0
                dr_probe_fo = 0
                tif_next(0.0)
            else
                tif_step = 0
                tif_time = 0.0
            end
        end
    end
    do_every_frame("tif_loop()")
    logMsg("ZiboHelper: ok.")
end