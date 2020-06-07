if PLANE_ICAO == "B738" then
    dataref("dr_ap_disco_lt", "laminar/B738/annunciator/ap_disconnect1")
    dataref("dr_at_disco_lt", "laminar/B738/annunciator/at_disconnect1")
    dataref("dr_at", "laminar/B738/autopilot/autothrottle_status")

    -- Disconnect A/T if A/P is disengaged
    function ap_at_disco_loop()
        if dr_ap_disco_lt > 0 and dr_at > 0 then
            command_once("laminar/B738/autopilot/left_at_dis_press")
        end
        if dr_at_disco_lt > 0 and dr_ap_disco_lt == 0 then
            command_once("laminar/B738/autopilot/left_at_dis_press") -- silence warning
        end
    end
    do_every_frame("ap_at_disco_loop()")
end