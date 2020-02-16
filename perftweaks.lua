local start_time = os.clock()
local do_once = false

--clouds
function clouds()
  if os.clock() > start_time and do_once == false then
    --------------------------------------------------------------------
    -- CLOUDS
    --------------------------------------------------------------------

    -- Vivid Sky
    -- https://forums.x-plane.org/index.php?/files/file/48315-vivid-sky/
    -- Sun
    set("sim/private/controls/dome/sun_gain_1_hdr", 0.85) -- sun glare strength
    set("sim/private/controls/dome/sun_gain_2_hdr", 2.35) -- sun brightness
    -- Clouds
    set("sim/private/controls/clouds/first_res_3d", 3) -- puffier clouds, reduces "bowl effect" in cloud layers
    set("sim/private/controls/clouds/plot_radius", 1.1) -- increased cloud volume
    set("sim/private/controls/clouds/overdraw_control", 0.75) -- helps to reduce cloud flicker
    set("sim/private/controls/clouds/ambient_gain", 1.12) -- less blinding in direct sun
    set("sim/private/controls/clouds/diffuse_gain", 0.9) -- darker at night/sunst
    set("sim/private/controls/clouds/spec_gain", 4.0) -- sun power through clouds
    set("sim/private/controls/clouds/light_curve_ratio", 0.95) -- cloud volume light top/dark base
    set("sim/private/controls/clouds/light_curve_power", 1.2) -- cloud volume light top/dark base
    set("sim/private/controls/clouds/check_z_hdr", 0.0) -- fix cloud terrain intersection
    -- Atmosphere
    set("sim/private/controls/atmo/atmo_scale_raleigh", 14)
    set("sim/private/controls/atmo/scatter_raleigh_r",2.00)
    set("sim/private/controls/atmo/scatter_raleigh_g", 7.00) 
    set("sim/private/controls/atmo/scatter_raleigh_b", 17.50) 
    set("sim/private/controls/atmo/inscatter_gain_raleigh", 1.75)
    set("sim/private/controls/skyc/tone_ratio_clean", 0.15)
    set("sim/private/controls/skyc/tone_ratio_hialt", 1.25) 
    set("sim/private/controls/skyc/tone_ratio_mount", 1.1) 
    -- Cloud Shadows
    set("sim/private/controls/clouds/shad_radius", 0.6) -- increased volume
    set("sim/private/controls/clouds/cloud_shadow_lighten_ratio", 0.94) -- darker shadow, max 1.0
    set("sim/private/controls/clouds/shad_alpha_dry", 0.6) -- darker shadow
    set("sim/private/controls/clouds/shad_alpha_wet", 1.0) -- darker shadow
    set("sim/private/controls/clouds/limit_far",  0.4) -- reduce shadow flicker, blockiness and increase detail 
    set("sim/private/controls/clouds/shadow_size", 2048.0)  -- reduce shadow flicker, possibly not used in 11.35

    -- xp11_clouds.lua
    -- https://forums.x-plane.org/index.php?/forums/topic/118971-clouds-killing-fps/
    -- https://forums.x-plane.org/index.php?/forums/topic/106529-ultra-weather-xp-v15-script/&page=2
    -- https://www.avsim.com/forums/topic/492132-x-plane-10-clouds-datarefs-questions/page/3/?tab=comments#comment-3459349
    -- https://forums.x-plane.org/index.php?/forums/topic/150598-xp11-default-clouds-look-amazing/ -- TODO
  	-- set( "sim/private/controls/clouds/first_res_3d", 3) -- set by vivid sky
  	set( "sim/private/controls/clouds/last_res_3d", 4) -- 5
  	-- set( "sim/private/controls/clouds/cloud_shadow_lighten_ratio", 0.0) -- was 0.85, 0 fixes flickering -- set by vivid sky
  	-- set( "sim/private/controls/clouds/plot_radius", 1.1) -- set by vivid sky
  	-- set( "sim/private/controls/clouds/overdraw_control", 1.00) -- set by vivid sky
  	-- set( "sim/private/controls/clouds/shadow_size", 2048) -- set by vivid sky
  	-- set( "sim/private/controls/clouds/shad_radius", 0.85) -- set by vivid sky
  	set( "sim/private/controls/skyc/white_out_in_clouds", 0)


    --------------------------------------------------------------------
    -- WATER
    --------------------------------------------------------------------

    -- -- water
    -- -- https://forums.x-plane.org/index.php?/files/file/51899-lua-script-for-water-enhancement/
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

    -- -- water
    -- -- FSEnhancer TrueWaves
    -- set( "sim/private/controls/water/fft_amp1", 20)
    -- set( "sim/private/controls/water/fft_amp2", 2.4)
    -- set( "sim/private/controls/water/fft_amp3", 14)
    -- set( "sim/private/controls/water/fft_amp4", 200)
    -- set( "sim/private/controls/water/fft_scale1", 10)
    -- set( "sim/private/controls/water/fft_scale2", 100)
    -- set( "sim/private/controls/water/fft_scale3", 0.5)
    -- set( "sim/private/controls/water/fft_scale4", 0.15)

    -- Vivid Water (simplified, only <= 6000m values)
    -- https://forums.x-plane.org/index.php?/files/file/48315-vivid-sky/
    set("sim/private/controls/water/fft_amp1", 2.5)
    set("sim/private/controls/water/fft_amp2", 1.5)
    set("sim/private/controls/water/fft_amp3", 16)
    set("sim/private/controls/water/fft_amp4", 150)
    set("sim/private/controls/water/fft_scale1", 4)
    set("sim/private/controls/water/fft_scale2", 60)
    set("sim/private/controls/water/fft_scale3", 6)
    set("sim/private/controls/water/fft_scale4", 2)
    set("sim/private/controls/water/noise_speed", 25)
    set("sim/private/controls/water/noise_bias_gen_x", 2)
    set("sim/private/controls/water/noise_bias_gen_y", 1)

    -- water (own settings)
    -- set( "sim/private/controls/water/fft_amp1", 20)
    -- set( "sim/private/controls/water/fft_amp2", 2.4)
    -- set( "sim/private/controls/water/fft_amp3", 14)
    -- set( "sim/private/controls/water/fft_amp4", 200)
    -- set( "sim/private/controls/water/fft_scale1", 11)
    -- set( "sim/private/controls/water/fft_scale2", 97)
    -- set( "sim/private/controls/water/fft_scale3", 0.5)
    -- set( "sim/private/controls/water/fft_scale4", 0.17)
    -- set("sim/private/controls/water/noise_speed", 18)
    -- set("sim/private/controls/water/noise_bias_gen_x", 2)
    -- set("sim/private/controls/water/noise_bias_gen_y", 1)


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

    -- Vivid Tweaks (partial)
    -- https://forums.x-plane.org/index.php?/files/file/48315-vivid-sky/
    set("sim/private/controls/planet/hires_steps", 500) -- fix holes in low-res terrain mesh
    set("sim/private/controls/planet/hires_steps_extra", 500) -- fix holes in low-res terrain mesh
    set("sim/private/controls/lights/exponent_far", 0.46) -- brighter lights

  	do_once=true
	end
end
do_often("clouds()")
