if PLANE_ICAO == "B738" then
    dataref("dr_speedbrake", "laminar/B738/flt_ctrls/speedbrake_lever")

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
end