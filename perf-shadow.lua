local start_time = os.clock()
local do_once = false

function perf_shadow()
    if os.clock() > start_time and do_once == false then
        -- set("sim/private/controls/fbo/shadow_cam_size", 2048.00) -- removed in Vulkan?
        -- set("sim/private/controls/shadow/cockpit_near_proxy", 4) -- simplify cockpit shadow casting shape? Large fps gain (3~5 when set to 8)
        set("sim/private/controls/shadow/cockpit_near_adjust", 2, true) -- shadow resolution

        do_once = true
    end
end

do_often("perf_shadow()")
