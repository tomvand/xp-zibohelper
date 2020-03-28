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
    -- set( "sim/private/controls/fog/fog_be_gone",    1.6 )
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


    -- https://forums.x-plane.org/index.php?/forums/topic/150598-xp11-default-clouds-look-amazing/&tab=comments#comment-1430099
    -- set( "sim/private/controls/clouds/first_res_3d", 3)
    -- set( "sim/private/controls/clouds/cloud_shadow_lighten_ratio", 0.9)
    -- set( "sim/private/controls/clouds/plot_radius", 0.8)
    -- set( "sim/private/controls/clouds/overdraw_control", 0.5)
    -- set( "sim/private/controls/clouds/shadow_size", 2048)
    -- set( "sim/private/controls/clouds/shad_radius", 0.8)
    -- set( "sim/private/controls/clouds/limit_far", 0.2)
    -- set( "sim/private/controls/clouds/spec_gain", 6.0)
    -- set( "sim/private/controls/cloud/sample_opacity", 0.25)
    -- set( "sim/private/controls/cloud/fade_far_end", 0.995)
    -- set( "sim/private/controls/skyc/white_out_in_clouds", 0.0)
    set( "sim/private/controls/clouds/count_ratio/0", 0.20)
    set( "sim/private/controls/clouds/count_ratio/1", 0.30)
    set( "sim/private/controls/clouds/count_ratio/2", 0.40)
    set( "sim/private/controls/clouds/count_ratio/3", 0.40)
    set( "sim/private/controls/clouds/count_ratio/4", 0.30)
    set( "sim/private/controls/clouds/count_ratio/5", 0.20) 


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
    set( "sim/private/controls/fog/fog_be_gone",    1.2 )


    --------------------------------------------------------------------
    -- WATER
    --------------------------------------------------------------------
    -- Allan RIVIERE 1.2
    -- set("sim/private/controls/water/fft_amp1", 40)
    -- set("sim/private/controls/water/fft_amp2", 1.5)
    -- set("sim/private/controls/water/fft_amp3", 20)
    -- set("sim/private/controls/water/fft_amp4", 150)
    -- set("sim/private/controls/water/fft_scale1", 30)
    -- set("sim/private/controls/water/fft_scale2", 40)
    -- set("sim/private/controls/water/fft_scale3", 8)
    -- set("sim/private/controls/water/fft_scale4", 2)
    -- set("sim/private/controls/water/noise_speed", 18)
    -- set("sim/private/controls/water/noise_bias_gen_x", 2)
    -- set("sim/private/controls/water/noise_bias_gen_y", 1)

    -- tomvand 2020-02-19
    -- notes:
    -- fft_amp#: wave intensity, higher is stronger
    -- fft_scale#: wave size, higher is smaller
    -- noise_speed: animation speed, lower is faster
    -- noise_bias_gen_x: animation speed factor?, higher is faster
    -- noise_bias_gen_y: animation speed factor?, higher is faster
    -- FFT 1 (no idea)
    set("sim/private/controls/water/fft_amp1", 40)
    set("sim/private/controls/water/fft_scale1", 30)
    -- FFT 2 (static small waves, strongly depends on wind)
    set("sim/private/controls/water/fft_amp2", 5)
    set("sim/private/controls/water/fft_scale2", 10)
    -- FFT 3 (slow, huge waves (looks like wind gusts))
    set("sim/private/controls/water/fft_amp3", 10)
    set("sim/private/controls/water/fft_scale3", 0.5)
    -- FFT 4 (fast, small waves)
    set("sim/private/controls/water/fft_amp4", 40)
    set("sim/private/controls/water/fft_scale4", 2)
    -- Animation speeds
    set("sim/private/controls/water/noise_speed", 14)
    set("sim/private/controls/water/noise_bias_gen_x", 1)
    set("sim/private/controls/water/noise_bias_gen_y", 1)


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

    -- set("sim/private/controls/shadow/cockpit_near_proxy", 4) -- simplify cockpit shadow casting shape? Large fps gain (3~5 when set to 8)
    set("sim/private/controls/shadow/cockpit_near_adjust", 2, true) -- shadow resolution

    -- Vivid Tweaks (partial)
    -- https://forums.x-plane.org/index.php?/files/file/48315-vivid-sky/
    set("sim/private/controls/planet/hires_steps", 500) -- fix holes in low-res terrain mesh
    set("sim/private/controls/planet/hires_steps_extra", 500) -- fix holes in low-res terrain mesh
    

  	do_once=true
	end
end
do_often("clouds()")


dataref("dr_cloud_tops0", "sim/weather/cloud_tops_msl_m[0]", "readonly")
local time_prev = 0
function toggle_fft_water()
    if not dr_cloud_tops0 then
      logMsg("perftweaks: waiting for cloud_base_msl_m to become available...")
      return
    end
    local time = os.clock()
    -- Disable fft water above first cloud level or FL100 and < 25fps
    if (ELEVATION > dr_cloud_tops0 or ELEVATION > 3333) and ((time - time_prev) > 0.04) then
      set("sim/private/controls/reno/draw_fft_water", 0)
    else
      set("sim/private/controls/reno/draw_fft_water", 1)
    end
    time_prev = time
end
do_sometimes("toggle_fft_water()")