local start_time = os.clock()
local do_once = false

--clouds
function clouds()
  if os.clock() > start_time and do_once == false then
    --------------------------------------------------------------------
    -- CLOUDS
    --------------------------------------------------------------------
    -- Tuning based on Vivid Sky textures and sky colors

    -- Vivid Sky
    -- https://forums.x-plane.org/index.php?/files/file/48315-vivid-sky/
    -- -- Sun
    -- set("sim/private/controls/dome/sun_gain_1_hdr", 0.85) -- sun glare strength
    -- set("sim/private/controls/dome/sun_gain_2_hdr", 2.35) -- sun brightness
    -- -- Clouds
    -- set("sim/private/controls/clouds/first_res_3d", 3) -- puffier clouds, reduces "bowl effect" in cloud layers
    -- set("sim/private/controls/clouds/plot_radius", 1.1) -- increased cloud volume
    -- set("sim/private/controls/clouds/overdraw_control", 0.75) -- helps to reduce cloud flicker
    -- set("sim/private/controls/clouds/ambient_gain", 1.12) -- less blinding in direct sun
    -- set("sim/private/controls/clouds/diffuse_gain", 0.9) -- darker at night/sunst
    -- set("sim/private/controls/clouds/spec_gain", 4.0) -- sun power through clouds
    -- set("sim/private/controls/clouds/light_curve_ratio", 0.95) -- cloud volume light top/dark base
    -- set("sim/private/controls/clouds/light_curve_power", 1.2) -- cloud volume light top/dark base
    -- set("sim/private/controls/clouds/check_z_hdr", 0.0) -- fix cloud terrain intersection
    -- -- Atmosphere
    -- set("sim/private/controls/atmo/atmo_scale_raleigh", 14)
    -- set("sim/private/controls/atmo/scatter_raleigh_r",2.00)
    -- set("sim/private/controls/atmo/scatter_raleigh_g", 7.00) 
    -- set("sim/private/controls/atmo/scatter_raleigh_b", 17.50) 
    -- set("sim/private/controls/atmo/inscatter_gain_raleigh", 1.75)
    -- set("sim/private/controls/skyc/tone_ratio_clean", 0.15)
    -- set("sim/private/controls/skyc/tone_ratio_hialt", 1.25) 
    -- set("sim/private/controls/skyc/tone_ratio_mount", 1.1) 
    -- -- Cloud Shadows
    set("sim/private/controls/clouds/shad_radius", 0.6) -- increased volume
    set("sim/private/controls/clouds/cloud_shadow_lighten_ratio", 0.94) -- darker shadow, max 1.0
    set("sim/private/controls/clouds/shad_alpha_dry", 0.6) -- darker shadow
    set("sim/private/controls/clouds/shad_alpha_wet", 1.0) -- darker shadow
    set("sim/private/controls/clouds/limit_far",  0.4) -- reduce shadow flicker, blockiness and increase detail 
    set("sim/private/controls/clouds/shadow_size", 2048.0)  -- reduce shadow flicker, possibly not used in 11.35


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
    set( "sim/private/controls/fog/fog_be_gone",    1.6 )
    set( "sim/private/controls/terrain/fog_clip_pad",    1500.0 )
    set( "sim/private/controls/terrain/fog_clip_scale",    0.0 )
    --clouds lighting
    set( "sim/private/controls/clouds/ambient_gain",       1.05 )
    set( "sim/private/controls/clouds/diffuse_gain",       1.39 )
    set( "sim/private/controls/clouds/spec_gain",        2.0 )
    set( "sim/private/controls/clouds/light_curve_power",  1.2)
    set( "sim/private/controls/clouds/light_curve_ratio",  1.0)
    --clouds draw settings
    set( "sim/private/controls/clouds/first_res_3d", 3)
    -- set( "sim/private/controls/clouds/last_res_3d", 5) -- overridden by me for performance
    -- set( "sim/private/controls/clouds/limit_far",  1.0) -- set by Vivid Sky to fix flickering
    set( "sim/private/controls/clouds/soft_occlude",  1.0)
    set( "sim/private/controls/clouds/plot_radius",  1.2)
    --clouds density
    set( "sim/private/controls/cloud/fade_far_end",       1.925 )
    set( "sim/private/controls/cloud/fade_far_start",     0.100 )
    set( "sim/private/controls/cloud/fade_near_end",       0.00 )
    set( "sim/private/controls/cloud/fade_near_start",   -1.000 )
    -- set( "sim/private/controls/clouds/overdraw_control", 0.9) -- overridden by me for performance
    --clouds resolution (depends on FSEnhancer textures?)
    -- set( "sim/private/controls/cloud/offscreen_res_tight", 4.0)
    -- set( "sim/private/controls/cloud/offscreen_scale", 0.986563)
    -- set( "sim/private/controls/cloud/offscreen_tight", 1.0)
    -- set( "sim/private/controls/cloud/offscreen_tweak", 1.0)
    -- set( "sim/private/controls/clouds/image_size_x", 4096.0)
    -- set( "sim/private/controls/clouds/image_size_y", 4096.0)
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


    -- xp11_clouds.lua
    -- https://forums.x-plane.org/index.php?/forums/topic/118971-clouds-killing-fps/
    -- https://forums.x-plane.org/index.php?/forums/topic/106529-ultra-weather-xp-v15-script/&page=2
    -- https://www.avsim.com/forums/topic/492132-x-plane-10-clouds-datarefs-questions/page/3/?tab=comments#comment-3459349
    -- https://forums.x-plane.org/index.php?/forums/topic/150598-xp11-default-clouds-look-amazing/ -- TODO
  	-- set( "sim/private/controls/clouds/first_res_3d", 3) -- set by vivid sky
  	set( "sim/private/controls/clouds/last_res_3d", 4) -- 5
  	-- set( "sim/private/controls/clouds/cloud_shadow_lighten_ratio", 0.0) -- was 0.85, 0 fixes flickering -- set by vivid sky
  	-- set( "sim/private/controls/clouds/plot_radius", 1.1) -- set by vivid sky
  	set( "sim/private/controls/clouds/overdraw_control", 0.75) -- slight performance hit, but looks MUCH better
  	-- set( "sim/private/controls/clouds/shadow_size", 2048) -- set by vivid sky
  	-- set( "sim/private/controls/clouds/shad_radius", 0.85) -- set by vivid sky
  	set( "sim/private/controls/skyc/white_out_in_clouds", 0)


    --------------------------------------------------------------------
    -- WATER
    --------------------------------------------------------------------
    -- tomvand 2020-02-16
    -- notes:
    -- fft_amp#: wave intensity, higher is stronger
    -- fft_scale#: wave size, higher is smaller
    -- noise_speed: animation speed, lower is faster
    -- noise_bias_gen_x: animation speed factor, higher is faster. Not 100% sure. Controls FFT 3 and 4.
    -- noise_bias_gen_y: animation speed factor, higher is faster. Scales *and* additive with _x, most effect on FFT 4.
    -- FFT 1 (no idea)
    set("sim/private/controls/water/fft_amp1", 2.5)
    set("sim/private/controls/water/fft_scale1", 4)
    -- FFT 2 (flickering)
    set("sim/private/controls/water/fft_amp2", 20)
    set("sim/private/controls/water/fft_scale2", 19)
    set("sim/private/controls/water/noise_speed", 5)
    -- FFT 3 (slow, small waves)
    set("sim/private/controls/water/fft_amp3", 5)
    set("sim/private/controls/water/fft_scale3", 47)
    set("sim/private/controls/water/noise_bias_gen_x", 2)
    -- FFT 4 (large, fast waves)
    set("sim/private/controls/water/fft_amp4", 50)
    set("sim/private/controls/water/fft_scale4", 2)
    set("sim/private/controls/water/noise_bias_gen_y", 0.1)


    --------------------------------------------------------------------
    -- MISC
    --------------------------------------------------------------------

    -- more tweaks 2019-12-25
    -- https://steamcommunity.com/app/269950/discussions/0/1694922980047128548/
    set("sim/private/controls/cars/lod_min", 7500.00)
    set("sim/private/controls/fbo/shadow_cam_size", 2048.00)
    set("sim/private/controls/skyc/max_dsf_vis_ever", 60000)
    set("sim/private/controls/park/static_plane_build_dis", 10000.00)
    set("sim/private/controls/park/static_plane_density", 6) -- more intensive
    set("sim/private/controls/lights/exponent_far", 0.5) -- brighter lights (scenery and ai traffic)

    set("sim/private/controls/shadow/cockpit_near_proxy", 32) -- disable cockpit shadow for ~5 FPS gain in zibo 737
    set("sim/private/controls/shadow/cockpit_near_adjust", 32, true)

    -- Vivid Tweaks (partial)
    -- https://forums.x-plane.org/index.php?/files/file/48315-vivid-sky/
    set("sim/private/controls/planet/hires_steps", 500) -- fix holes in low-res terrain mesh
    set("sim/private/controls/planet/hires_steps_extra", 500) -- fix holes in low-res terrain mesh
    

  	do_once=true
	end
end
do_often("clouds()")


dataref("first_cloud_base","sim/weather/cloud_base_msl_m[0]", "readonly")
dataref("elevation","sim/flightmodel/position/elevation", "readonly")

function toggle_fft_water()
    -- Disable fft water above first cloud level or FL100
    if elevation > cloud_base_msl_m * 1.5 or elevation > 3000 then
      set("sim/private/controls/reno/draw_fft_water", 0)
    else
      set("sim/private/controls/reno/draw_fft_water", 1)
    end
end
do_often("toggle_fft_water()")