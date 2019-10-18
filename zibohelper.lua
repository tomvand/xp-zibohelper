if PLANE_ICAO == "B738"then
    logMsg("ZiboHelper: detected PLANE_ICAO == B738")


    -- Datarefs used by multiple functions
    dataref("dr_flap", "sim/cockpit2/controls/flap_ratio")


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
    dataref("dr_fd_cpt", "laminar/B738/switches/autopilot/fd_ca", "writeable")
    dataref("dr_fd_fo", "laminar/B738/switches/autopilot/fd_fo", "writeable")
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
        command_once("laminar/B738/autopilot/capt_disco_press")
        command_once("laminar/B738/autopilot/left_at_dis_press")
    end
    create_command("zibohelper/ap_at_disco",
                   "Disconnect A/P and A/T",
                   "ap_at_disco()",
                   "",
                   "")
    logMsg("ZiboHelper: ok.")


    -- Speedbrake ARM toggle
    logMsg("ZiboHelper: setting up speedbrake ARM toggle command...")
    dataref("dr_speedbrake", "sim/cockpit2/controls/speedbrake_ratio", "writeable")
    function speedbrake_arm_toggle()
        if dr_speedbrake == 0.0 then
            command_once("sim/flight_controls/speed_brakes_up_all")
            command_once("sim/flight_controls/speed_brakes_down_one")
        else
            command_once("sim/flight_controls/speed_brakes_up_all")
        end
    end
    create_command("zibohelper/speedbrake_arm_toggle",
                   "Toggle speedbrake ARM",
                   "speedbrake_arm_toggle()",
                   "",
                   "")
    logMsg("ZiboHelper: ok.")


    -- Flap lever hysteresis
    logMsg("ZiboHelper: setting up flap axis hysteresis...")
    local FLAP_AXIS_INDEX = 1 -- hardcoded flap axis number
    local flap_hysteresis = 0.10 -- % flap position
    local dr_axis_assignments = dataref_table("sim/joystick/joystick_axis_assignments")
    local dr_axis_values = dataref_table("sim/joystick/joystick_axis_values")
    if dr_axis_assignments[FLAP_AXIS_INDEX] ~= 0 then
        logMsg("ZiboHelper: disabling axis " .. tostring(FLAP_AXIS_INDEX))
        set_axis_assignment(FLAP_AXIS_INDEX, "none", "normal")
    end
    function flap_hysteresis_loop()
        local flap_h_incr = (dr_flap * 8) + 0.5 + flap_hysteresis
        local flap_h_decr = (dr_flap * 8) - 0.5 - flap_hysteresis
        if dr_axis_values[FLAP_AXIS_INDEX] * 8 > flap_h_incr then
            command_once("sim/flight_controls/flaps_down")
        elseif dr_axis_values[FLAP_AXIS_INDEX] * 8 < flap_h_decr then
            command_once("sim/flight_controls/flaps_up")
        end
    end
    do_every_frame("flap_hysteresis_loop()")
    logMsg("ZiboHelper: ok.")

end