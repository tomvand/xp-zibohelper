local start_time = os.clock()
local do_once = false

--clouds
function clouds()
  if os.clock() > start_time and do_once == false then

    -- xp11_clouds.lua
    -- https://forums.x-plane.org/index.php?/forums/topic/118971-clouds-killing-fps/
    -- https://forums.x-plane.org/index.php?/forums/topic/106529-ultra-weather-xp-v15-script/&page=2
    -- https://www.avsim.com/forums/topic/492132-x-plane-10-clouds-datarefs-questions/page/3/?tab=comments#comment-3459349
  	set( "sim/private/controls/clouds/first_res_3d", 3)
  	set( "sim/private/controls/clouds/last_res_3d", 4) -- 5
  	set( "sim/private/controls/clouds/cloud_shadow_lighten_ratio", 0.0) -- was 0.85, 0 fixes flickering
  	set( "sim/private/controls/clouds/plot_radius", 1.1)
  	set( "sim/private/controls/clouds/overdraw_control", 1.00)
  	set( "sim/private/controls/clouds/shadow_size", 2048)
  	set( "sim/private/controls/clouds/shad_radius", 0.85)
  	set( "sim/private/controls/skyc/white_out_in_clouds", 0)

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

    -- water
    -- FSEnhancer TrueWaves
    set( "sim/private/controls/water/fft_amp1", 20)
    set( "sim/private/controls/water/fft_amp2", 2.4)
    set( "sim/private/controls/water/fft_amp3", 14)
    set( "sim/private/controls/water/fft_amp4", 200)
    set( "sim/private/controls/water/fft_scale1", 10)
    set( "sim/private/controls/water/fft_scale2", 100)
    set( "sim/private/controls/water/fft_scale3", 0.5)
    set( "sim/private/controls/water/fft_scale4", 0.15)

    -- more tweaks 2019-12-25
    -- https://steamcommunity.com/app/269950/discussions/0/1694922980047128548/
    set("sim/private/controls/cars/lod_min", 7500.00)
    set("sim/private/controls/fbo/shadow_cam_size", 2048.00)
    set("sim/private/controls/skyc/max_dsf_vis_ever", 60000)
    set("sim/private/controls/park/static_plane_build_dis", 10000.00)
    set("sim/private/controls/park/static_plane_density", 6) -- more intensive

  	do_once=true
	end
end
do_often("clouds()")
