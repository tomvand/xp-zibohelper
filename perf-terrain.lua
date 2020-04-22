local start_time = os.clock()
local do_once = false

function perf_terrain()
    if os.clock() > start_time and do_once == false then
        set("sim/private/controls/skyc/max_dsf_vis_ever", 60000)
        -- Vivid Tweaks (partial)
        -- https://forums.x-plane.org/index.php?/files/file/48315-vivid-sky/
        -- set("sim/private/controls/planet/hires_steps", 500) -- fix holes in low-res terrain mesh, removed in Vulkan?
        -- set("sim/private/controls/planet/hires_steps_extra", 500) -- fix holes in low-res terrain mesh, removed in Vulkan?

        do_once = true
    end
end

do_often("perf_terrain()")
