local start_time = os.clock()
local do_once = false

function vis_atmo()
    if os.clock() > start_time and do_once == false then
        -- Tuning based on Vivid Sky textures and sky colors

        -- TrueHaze (static code only)
        -- https://forums.x-plane.org/index.php?/files/file/41411-fse/
        --atmosphere parameters
        set( "sim/private/controls/atmo/atmo_scale_raleigh",        19 )
        set( "sim/private/controls/atmo/inscatter_gain_mie",     1.0 )
        set( "sim/private/controls/atmo/inscatter_gain_raleigh",         1.0 )
        set( "sim/private/controls/atmo/scatter_raleigh_b",         20.0 )
        set( "sim/private/controls/atmo/scatter_raleigh_g",       10.00 )
        set( "sim/private/controls/atmo/scatter_raleigh_r",     2.5 )
        set( "sim/private/controls/hdr/sky_gain",     	3.5 )
        set( "sim/private/controls/hdr/white_point",     	3.5 )
        -- set( "sim/private/controls/fog/fog_be_gone",    1.6 )
        set( "sim/private/controls/terrain/fog_clip_pad",    1500.0 )
        set( "sim/private/controls/terrain/fog_clip_scale",    0.0 )
        --sun parameters
        set( "sim/private/controls/dome/sun_gain_1_hdr", 1.00)
        set( "sim/private/controls/dome/sun_gain_2_hdr", 1.90)
        set( "sim/private/controls/skyc/min_tone_angle", -100)
        set( "sim/private/controls/skyc/max_tone_angle", -100)
        --scenery draw distance
        -- set( "sim/private/controls/skyc/max_dsf_vis_ever", 110000)
        set( "sim/private/controls/skyc/dsf_fade_ratio", 0.5)
        set( "sim/private/controls/skyc/dsf_cutover_scale", 3)

        --SKY COLORS PARAMETERS
        --clean
        set( "sim/private/controls/skyc/ambient_ratio_clean", 0.30)
        set( "sim/private/controls/skyc/direct_ratio_clean", 0.3)
        set( "sim/private/controls/skyc/mie_scattering_clean", 0.600)
        set( "sim/private/controls/skyc/raleigh_scattering_clean", 0.3420)
        set( "sim/private/controls/skyc/shadow_level_clean", 1.00)
        set( "sim/private/controls/skyc/shadow_offset_clean", 1.00)
        set( "sim/private/controls/skyc/tone_ratio_clean", 0.8)
        --mount
        set( "sim/private/controls/skyc/ambient_ratio_mount", 0.30)
        set( "sim/private/controls/skyc/direct_ratio_mount", 1.000)
        set( "sim/private/controls/skyc/mie_scattering_mount", 0.200)
        set( "sim/private/controls/skyc/raleigh_scattering_mount", 0.29)
        set( "sim/private/controls/skyc/shadow_level_mount", 1.00)
        set( "sim/private/controls/skyc/shadow_offset_mount", 1.00)
        set( "sim/private/controls/skyc/tone_ratio_mount", 0.8)
        -- tone ratios
        set( "sim/private/controls/skyc/tone_ratio_foggy", 0.4)
        set( "sim/private/controls/skyc/tone_ratio_hazy",  0.3)
        set( "sim/private/controls/skyc/tone_ratio_snowy", 0.5)
        set( "sim/private/controls/skyc/tone_ratio_ocast", 0.2)
        set( "sim/private/controls/skyc/tone_ratio_strat", 1.5)
        set( "sim/private/controls/skyc/tone_ratio_hialt", 0)
        -- shadow levels
        -- set( "sim/private/controls/skyc/shadow_level_hazy", 0.6)
        -- set( "sim/private/controls/skyc/shadow_level_foggy", 0.33)
        -- set( "sim/private/controls/skyc/shadow_level_ocast", 0.2)



        do_once = true
    end
end

do_often("vis_atmo()")


dataref("dr_dewpoint", "sim/weather/dewpoi_sealevel_c")
dataref("dr_temp", "sim/weather/temperature_sealevel_c")
function adjust_minfog_by_RH()
    -- For X-Visibility
    -- Adjusts the minFog parameter based on the relative humidity
    local relative_humidity = 100 - 5 * (dr_temp - dr_dewpoint)
    if relative_humidity < 0 then
        relative_humidity = 0
    end
    if relative_humidity > 100 then
        relative_humidity = 100
    end
    xvis_minFog_value = (relative_humidity / 100) * (relative_humidity / 100) * 1.0  -- room for tweaking
end
do_often("adjust_minfog_by_RH()")