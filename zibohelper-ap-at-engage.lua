if PLANE_ICAO == "B738" then
    dataref("dr_cmd_a", "laminar/B738/buttons/autopilot/cmd_a")
    dataref("dr_cmd_b", "laminar/B738/buttons/autopilot/cmd_b")
    dataref("dr_at_arm_lt", "laminar/B738/autopilot/autothrottle_status")

    -- Engage CMD A, engage A/T on second press
    function ap_at_engage()
        if dr_cmd_a == 0 and dr_cmd_b == 0 then
            command_once("laminar/B738/autopilot/cmd_a_press")
        else
            command_once("laminar/B738/autopilot/autothrottle_arm_toggle")
        end
    end
    create_command("zibohelper/ap_at_engage",
                   "Press CMD A on first press, arm A/T on second",
                   "ap_at_engage()",
                   "",
                   "")
end