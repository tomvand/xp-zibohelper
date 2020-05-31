if PLANE_ICAO == "B738" then
    dataref("dr_flap", "laminar/B738/flt_ctrls/flap_lever")

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
end