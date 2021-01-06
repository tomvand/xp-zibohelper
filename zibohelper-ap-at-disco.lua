if PLANE_ICAO == "B738" and false then
    -- dataref("dr_yoke_disco", "laminar/B738/capt/yoke_ap_disengage")
    -- dataref("cmd_a_status", "laminar/B738/autopilot/cmd_a_status")
    -- dataref("cmd_b_status", "laminar/B738/autopilot/cmd_b_status")
    next_press_silences_ap_annunciator = false
    yoke_disco_held = false

    -- Disconnect A/T if A/P is disengaged
    function ap_at_disco_loop()
        if get("laminar/B738/capt/yoke_ap_disengage") > 0.5 and not yoke_disco_held then
            -- Yoke disco button pushed
            if get("laminar/B738/autopilot/cmd_a_status") > 0.5 or get("laminar/B738/autopilot/cmd_b_status") > 0.5 then
                -- Disconnect autopilot
                -- (do nothing)
                next_press_silences_ap_annunciator = true
            elseif next_press_silences_ap_annunciator then
                -- Silence A/P annunciator
                -- (do nothing)
                next_press_silences_ap_annunciator = false
            else
                -- Press A/T disconnect
                command_once("laminar/B738/autopilot/left_at_dis_press")
            end
            yoke_disco_held = true
        elseif get("laminar/B738/capt/yoke_ap_disengage") < 0.5 then
            yoke_disco_held = false
        end
    end
    do_every_frame("ap_at_disco_loop()")
end