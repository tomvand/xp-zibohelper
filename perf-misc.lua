local start_time = os.clock()
local do_once = false

function perf_misc()
    if os.clock() > start_time and do_once == false then
        -- more tweaks 2019-12-25
        -- https://steamcommunity.com/app/269950/discussions/0/1694922980047128548/
        set("sim/private/controls/cars/lod_min", 7500.00)

        do_once = true
    end
end

do_often("perf_misc()")
