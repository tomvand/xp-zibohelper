if PLANE_ICAO == "B738" then
    dataref("dr_cmd_a", "laminar/B738/autopilot/cmd_a_status")
    dataref("dr_cmd_b", "laminar/B738/autopilot/cmd_b_status")
    dataref("dr_at", "laminar/B738/autopilot/autothrottle_status")

    -- Disconnect A/P and A/T with single button
    logMsg("ZiboHelper: setting up A/P A/T disco command...")
    function ap_at_disco()
        if dr_cmd_a > 0 or dr_cmd_b > 0 or dr_at > 0 then
            if dr_cmd_a > 0 or dr_cmd_b > 0 then
                command_once("laminar/B738/autopilot/capt_disco_press")
            end
            if dr_at > 0 then
                command_once("laminar/B738/autopilot/left_at_dis_press")
            end
        else
            command_once("laminar/B738/push_button/ap_light_pilot")
            command_once("laminar/B738/push_button/at_light_pilot")
        end
    end
    create_command("zibohelper/ap_at_disco",
                   "Disconnect A/P and A/T, push annunciators",
                   "ap_at_disco()",
                   "",
                   "")
    logMsg("ZiboHelper: ok.")
end