local start_time = os.clock()

function vis_lights()
    if os.clock() > start_time then
        -- Tuned for TK Ligh Mod 2019
        -- https://forums.x-plane.org/index.php?/files/file/47394-tk-light-mod-2019/
        -- With X-Lights 1.0.1 **only 1000_lights_close.dds**
        --
        -- This script adapts light brightness (exponent) based on sun elevation for more gradual transition.
        
        -- Constant values
        set("sim/private/controls/lights/hdr_mix", 0.0) -- Light blob intensity, 0=bright, 1=invisible
        set("sim/private/controls/lights/dist_near", 200.0) -- Near side of exponent transition
        set("sim/private/controls/lights/dist_far", 10000.0) -- Far side of exponent transition

        -- Inputs
        local sun_pitch = get("sim/graphics/scenery/sun_pitch_degrees")
        local visibility = get("sim/graphics/view/visibility_effective_m")
        local frametime = get("sim/operation/misc/frame_rate_period")
        local exp_near_now = get("sim/private/controls/lights/exponent_near")
        local exp_far_now = get("sim/private/controls/lights/exponent_far")

        -- Day/night cycle
        local night_ratio = -(sun_pitch - 2.2) / (2.2 + 6.5) -- Transition from +2.2deg to -6.5deg
        if night_ratio < 0.0 then
            night_ratio = 0.0
        end
        if night_ratio > 1.0 then
            night_ratio = 1.0
        end
        local exp_near = (1.0 - night_ratio) * 0.38 + night_ratio * 0.42 -- day: 0.38 (default), night: 0.42
        local exp_far  = (1.0 - night_ratio) * 0.42 + night_ratio * 0.50 -- day: 0.42,           night: 0.50 (very bright)

        -- Fog/visibility
        -- local fog_ratio = 1.0 - (visibility - 2000) / (7000 - 2000) -- Transition from 7000m (0.0) to 2000m (1.0)
        -- if fog_ratio < 0.0 then
        --     fog_ratio = 0.0
        -- end
        -- if fog_ratio > 1.0 then
        --     fog_ratio = 1.0
        -- end
        -- exp_near = (1.0 - fog_ratio) * exp_near + fog_ratio * 0.50 -- Mix fog exponent 0.50 with current exp
        -- exp_far  = (1.0 - fog_ratio) * exp_far  + fog_ratio * 0.30 -- Mix fog exponent 0.30 with current exp

        -- Update datarefs
        if exp_near_now < exp_near then
            exp_near_now = exp_near_now + 0.01 * frametime
        elseif exp_near_now > exp_near then
            exp_near_now = exp_near_now - 0.01 * frametime
        end
        if exp_far_now < exp_far then
            exp_far_now = exp_far_now + 0.01 * frametime
        elseif exp_far_now > exp_far then
            exp_far_now = exp_far_now - 0.01 * frametime
        end
        set("sim/private/controls/lights/exponent_near", exp_near_now)
        set("sim/private/controls/lights/exponent_far", exp_far_now)
    end
end

do_every_frame("vis_lights()")
