if PLANE_ICAO == "B738" then
    local dr_axis_assignments = dataref_table("sim/joystick/joystick_axis_assignments")
    local dr_axis_values = dataref_table("sim/joystick/joystick_axis_values")

    -- Flap lever hysteresis
    logMsg("ZiboHelper: setting up flap axis hysteresis...")
    local FLAP_AXIS_INDEX = 1 -- hardcoded flap axis number
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
end