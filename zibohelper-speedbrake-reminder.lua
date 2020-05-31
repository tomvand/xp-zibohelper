if PLANE_ICAO == "B738" then
    dataref("dr_speedbrake", "laminar/B738/flt_ctrls/speedbrake_lever")
    dataref("dr_throttle_all", "sim/cockpit2/engine/actuators/throttle_jet_rev_ratio_all")

    -- Speedbrake reminder
    logMsg("ZiboHelper: setting up speedbrake reminder...")
    function speedbrake_reminder_draw()
        if dr_speedbrake > 0.5 and dr_throttle_all > 0.0 then
            glColor4f(1.0, 0.0, 0.0, 1.0)
            draw_string_Helvetica_18(200, SCREEN_HIGHT / 2, "SPEEDBRAKE!")
        end
    end
    do_every_draw("speedbrake_reminder_draw()")
end