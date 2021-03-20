if PLANE_ICAO == "B738" then
  local dt_lights = dataref_table("laminar/B738/lights_sw")

  function zibohelper_landing_lights_toggle()
    local current_state = get("laminar/B738/switch/land_lights_left_pos")
    if current_state < 0.5 then
      -- Turn on
      command_once("laminar/B738/spring_switch/landing_lights_all")
      set("laminar/B738/switch/land_lights_left_pos", 1)
      set("laminar/B738/switch/land_lights_right_pos", 1)
    else
      -- Turn off
      command_once("laminar/B738/switch/land_lights_ret_left_off")
      command_once("laminar/B738/switch/land_lights_ret_right_off")
      set("laminar/B738/switch/land_lights_left_pos", 0)
      set("laminar/B738/switch/land_lights_right_pos", 0)
    end
  end
  create_command("zibohelper/lights/landing_lights_toggle", "Toggle landing lights",
      "zibohelper_landing_lights_toggle()", "", "")
  

  function zibohelper_taxi_lights_toggle()
    local current_state = dt_lights[8]
    if current_state < 0.5 then
      -- Turn on
      command_once("laminar/B738/switch/rwy_light_left_on")
      command_once("laminar/B738/switch/rwy_light_right_on")
      command_once("laminar/B738/toggle_switch/taxi_light_brightness_on")
    else
      -- Turn off
      command_once("laminar/B738/switch/rwy_light_left_off")
      command_once("laminar/B738/switch/rwy_light_right_off")
      command_once("laminar/B738/toggle_switch/taxi_light_brightness_off")
    end
  end
  create_command("zibohelper/lights/taxi_lights_toggle", "Toggle taxi lights",
      "zibohelper_taxi_lights_toggle()", "", "")
  

  function zibohelper_strobe_light_toggle()
    local current_state = dt_lights[0]
    if current_state == -1 then
      -- Strobes on
      command_once("laminar/B738/toggle_switch/position_light_strobe")
    else
      -- Steady on
      command_once("laminar/B738/toggle_switch/position_light_steady")
    end
  end
  create_command("zibohelper/lights/strobe_light_toggle", "Toggle strobe light",
      "zibohelper_strobe_light_toggle()", "", "")
end