local start_time = os.clock()
local do_once = false

function vis_static_planes()
    if os.clock() > start_time and do_once == false then
        set("sim/private/controls/park/static_plane_density", 6) -- 6 more intensive
        -- set("sim/private/controls/park/static_plane_build_dis", 10000.00)

        do_once = true
    end
end

do_often("vis_static_planes()")
