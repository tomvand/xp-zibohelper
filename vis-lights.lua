local start_time = os.clock()
local do_once = false

function vis_lights()
    if os.clock() > start_time and do_once == false then
        set("sim/private/controls/lights/exponent_far", 0.5) -- brighter lights (scenery and ai traffic)

        do_once = true
    end
end

do_often("vis_lights()")
