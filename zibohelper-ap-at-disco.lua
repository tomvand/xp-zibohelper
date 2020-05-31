if PLANE_ICAO == "B738" then
    -- Disconnect A/P and A/T with single button
    logMsg("ZiboHelper: setting up A/P A/T disco command...")
    function ap_at_disco_begin()
        command_once("laminar/B738/autopilot/left_at_dis_press")
    end
    function ap_at_disco_continue()
        -- do nothing
    end
    function ap_at_disco_end()
        command_once("laminar/B738/autopilot/capt_disco_press")
    end
    create_command("zibohelper/ap_at_disco",
                   "Disconnect A/P and A/T, push annunciators",
                   "ap_at_disco_begin()",
                   "ap_at_disco_continue()",
                   "ap_at_disco_end()")
    logMsg("ZiboHelper: ok.")
end