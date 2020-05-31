local start_time = os.clock()
local do_once = false

function vis_clouds()
    if os.clock() > start_time and do_once == false then
      --------------------------------------------------------------------
      -- CLOUDS
      --------------------------------------------------------------------
      -- Tuning based on Cloud Art 3.2 textures and sky colors

      -- OWN SETTINGS
      -- Cloud color --
      -- Appearance of diffuse/spec gain depends on light_curve
      set( "sim/private/controls/clouds/ambient_gain", 1.3) -- grayscale ambient lighting
      set( "sim/private/controls/clouds/diffuse_gain", 0.6) -- Sky/sun color. Very pinkish during sunset. Also darker on bottom/far side of clouds.
      set("sim/private/controls/clouds/spec_gain", 1.5) -- Sun reflection and power through clouds
      set( "sim/private/controls/clouds/light_curve_ratio", 20) -- Controls darker cloud bottom. Multiplied with curve_power in some way.
      set( "sim/private/controls/clouds/light_curve_power", 0.08)
      set( "sim/private/controls/clouds/plot_radius", 1.45) -- Slightly bigger
      set( "sim/private/controls/skyc/fog_start_lo_alt", 0.5) -- Cloud drawing distance from below
      -- Other settings --
      -- set( "sim/private/controls/clouds/soft_occlude",  0.0) -- not sure
      -- set("sim/private/controls/clouds/cloud_shadow_lighten_ratio", 1.0) -- shadow intensity. Overall multiplier with cloud shadow.
      -- set("sim/private/controls/clouds/shad_alpha_dry", 0.1) -- subtle shadow in dry weather
      -- set("sim/private/controls/clouds/shad_alpha_wet", 5.0) -- really dark shadow in wet weather. Alpha is clipped, so >1 does not darken but increases shadow size/leaves less gaps.
      -- set("sim/private/controls/clouds/limit_far",  0.3) -- physical size of cloud shadow texture (0.4: good. Smaller is sharper outlines but artifacts further away)
      -- set( "sim/private/controls/skyc/white_out_in_clouds", 1) -- Does not work anymore? Might be X-Visibility... -- personal preference
      -- set("sim/private/controls/clouds/shadow_size", 2048.0) -- not available anymore, crashes script


  
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
      -- set("sim/private/controls/clouds/shadow_size", 2048.0)  -- reduce shadow flicker, possibly not used in 11.35, removed in Vulkan?
  
  
      -- TrueHaze (static code only)
      -- https://forums.x-plane.org/index.php?/files/file/41411-fse/
      --clouds lighting
      -- set( "sim/private/controls/clouds/ambient_gain",       1.05 )
      -- set( "sim/private/controls/clouds/diffuse_gain",       1.39 )
      -- set( "sim/private/controls/clouds/spec_gain",        2.0 )
      -- set( "sim/private/controls/clouds/light_curve_power",  1.2)
      -- set( "sim/private/controls/clouds/light_curve_ratio",  1.0)
      --clouds draw settings
      -- set( "sim/private/controls/clouds/first_res_3d", 3)
      -- set( "sim/private/controls/clouds/last_res_3d", 5) -- overridden by me for performance
      -- set( "sim/private/controls/clouds/limit_far",  1.0) -- set by Vivid Sky to fix flickering
      -- set( "sim/private/controls/clouds/soft_occlude",  1.0)
      -- set( "sim/private/controls/clouds/plot_radius",  1.2)
      --clouds density
      -- set( "sim/private/controls/cloud/fade_far_end",       1.925 )
      -- set( "sim/private/controls/cloud/fade_far_start",     0.100 )
      -- set( "sim/private/controls/cloud/fade_near_end",       0.00 )
      -- set( "sim/private/controls/cloud/fade_near_start",   -1.000 ) -- produces clouds-in-ground with Cloud Art 3.2
      -- set( "sim/private/controls/clouds/overdraw_control", 0.9) -- overridden by me for performance
      --clouds resolution (depends on FSEnhancer textures?)
      -- set( "sim/private/controls/cloud/offscreen_res_tight", 4.0)
      -- set( "sim/private/controls/cloud/offscreen_scale", 0.986563)
      -- set( "sim/private/controls/cloud/offscreen_tight", 1.0)
      -- set( "sim/private/controls/cloud/offscreen_tweak", 1.0)
      -- set( "sim/private/controls/clouds/image_size_x", 4096.0)
      -- set( "sim/private/controls/clouds/image_size_y", 4096.0)
  
  
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
      -- set( "sim/private/controls/clouds/count_ratio/0", 0.20)
      -- set( "sim/private/controls/clouds/count_ratio/1", 0.30)
      -- set( "sim/private/controls/clouds/count_ratio/2", 0.40)
      -- set( "sim/private/controls/clouds/count_ratio/3", 0.40)
      -- set( "sim/private/controls/clouds/count_ratio/4", 0.30)
      -- set( "sim/private/controls/clouds/count_ratio/5", 0.20) 


      -- CloudArt.lua
      -- https://forums.x-plane.org/index.php?/files/file/40952-cloud-art/
      -- Version 3.2
      set( "sim/private/controls/clouds/first_res_3d", 3)
      set( "sim/private/controls/clouds/last_res_3d", 5)
      -- set( "sim/private/controls/clouds/plot_radius", 1.4)
      set( "sim/private/controls/clouds/overdraw_control", 0.1)
      -- set( "sim/private/controls/clouds/ambient_gain", 1.24)
      -- set( "sim/private/controls/clouds/diffuse_gain", 0)
      -- set( "sim/private/controls/clouds/light_curve_ratio", 100)
      -- set( "sim/private/controls/clouds/light_curve_power", 100)
      -- set( "sim/private/controls/clouds/shad_radius" , 1.0)
      -- set( "sim/private/controls/clouds/shad_alpha_dry" , 0.5)
      -- set( "sim/private/controls/clouds/shad_alpha_wet", 0)
      -- set( "sim/private/controls/clouds/shadow_size", 2048)
      set( "sim/private/controls/clouds/count_ratio/0",0.5)
      set( "sim/private/controls/clouds/count_ratio/1",0.5)
      set( "sim/private/controls/clouds/count_ratio/2",0.5)
      set( "sim/private/controls/clouds/count_ratio/3",0.5)
      set( "sim/private/controls/clouds/count_ratio/4",0.5)
      set( "sim/private/controls/clouds/check_z_hdr", 0.00)
      -- set( "sim/private/controls/dome/sun_gain_1_hdr", 0.7)
      -- set( "sim/private/controls/skyc/mie_scattering_ocast", 10.000000)
      -- set( "sim/private/controls/skyc/shadow_level_clean", 1.000000)
      -- set( "sim/private/controls/skyc/shadow_level_ocast", 1.000000)
      -- set( "sim/private/controls/hdr/white_point", 5.0)
      -- set( "sim/private/controls/atmo/atmo_scale_raleigh", 19.0)
      -- set( "sim/private/controls/atmo/inscatter_gain_raleigh", 0)
      -- set( "sim/private/controls/skyc/tone_ratio_hialt", 1)
      -- set( "sim/private/controls/skyc/tone_ratio_clean", 1)
      -- set( "sim/private/controls/skyc/tone_ratio_mount", 1)
      -- set( "sim/private/controls/clouds/cloud_shadow_lighten_ratio",  1.00)
      -- set( "sim/private/controls/clouds/shad_radius", 0.6)
      -- set( "sim/private/controls/shadow/adhoc/extra_far",  1.0 )
      -- set( "sim/private/controls/shadow/bias_const",  0.0 )
      -- set( "sim/private/controls/shadow/bias_slope",  1.0 )
      -- set( "sim/private/controls/shadow/extra_near",  1.0 )
      -- set( "sim/private/controls/shadow/overlap_ratio",  0.001000 )
  
  
      -- xp11_clouds.lua
      -- https://forums.x-plane.org/index.php?/forums/topic/118971-clouds-killing-fps/
      -- https://forums.x-plane.org/index.php?/forums/topic/106529-ultra-weather-xp-v15-script/&page=2
      -- https://www.avsim.com/forums/topic/492132-x-plane-10-clouds-datarefs-questions/page/3/?tab=comments#comment-3459349
      -- https://forums.x-plane.org/index.php?/forums/topic/150598-xp11-default-clouds-look-amazing/ -- TODO
      -- set( "sim/private/controls/clouds/first_res_3d", 3) -- set by vivid sky
      -- set( "sim/private/controls/clouds/last_res_3d", 4) -- 5
      -- set( "sim/private/controls/clouds/cloud_shadow_lighten_ratio", 0.0) -- was 0.85, 0 fixes flickering -- set by vivid sky
      -- set( "sim/private/controls/clouds/plot_radius", 1.1) -- set by vivid sky
      -- set( "sim/private/controls/clouds/overdraw_control", 0.75) -- slight performance hit, but looks MUCH better
      -- set( "sim/private/controls/clouds/shadow_size", 2048) -- set by vivid sky
      -- set( "sim/private/controls/clouds/shad_radius", 0.85) -- set by vivid sky
      -- set( "sim/private/controls/skyc/white_out_in_clouds", 0)
      -- set( "sim/private/controls/fog/fog_be_gone",    1.2 ) -- Disabled for X-Visibility

      do_once = true
    end
end
do_often("vis_clouds()")
