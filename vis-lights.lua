local start_time = os.clock()
local do_once = false

function vis_lights()
    if os.clock() > start_time and do_once == false then
        -- Tuned for TK Ligh Mod 2019
        -- https://forums.x-plane.org/index.php?/files/file/47394-tk-light-mod-2019/
        -- With X-Lights 1.0.1 **only 1000_lights_close.dds**
        set("sim/private/controls/lights/exponent_near", 0.52)
        set("sim/private/controls/lights/exponent_far", 0.50)

        do_once = true
    end
end

do_often("vis_lights()")
