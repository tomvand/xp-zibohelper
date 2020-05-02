local start_time = os.clock()
local do_once = false

function perf_clouds()
    if os.clock() > start_time and do_once == false then
        -- TODO cannot use in combination with soft cloud art!

        set( "sim/private/controls/clouds/last_res_3d", 4) -- 5
        set( "sim/private/controls/clouds/overdraw_control", 1.0) -- 0.75

        do_once = true
    end
end

do_often("perf_clouds()")