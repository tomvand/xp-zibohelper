if PLANE_ICAO == "A320" then
  function a320helper_landing_lights_toggle()
    local current_state = get("a320/Overhead/LightLandL")
    if current_state < 1.5 then
      set("a320/Overhead/LightLandL", 2)
      set("a320/Overhead/LightLandR", 2)
    else
      set("a320/Overhead/LightLandL", 0)
      set("a320/Overhead/LightLandR", 0)
    end
  end
  create_command("a320helper/lights/landing_lights_toggle", "Toggle landing lights",
      "a320helper_landing_lights_toggle()", "", "")
  

  function a320helper_taxi_lights_toggle()
    local current_state = get("a320/Overhead/LightNose")
    if current_state < 0.5 then
      set("a320/Overhead/LightNose", 1)
    elseif current_state < 1.5 and get("a320/Overhead/LightLandL") > 0.5 and get("sim/flightmodel2/position/y_agl") < 10 then
      set("a320/Overhead/LightNose", 2)
    else
      set("a320/Overhead/LightNose", 0)
    end
    local current_state = get("a320/Overhead/LightNose")
    if current_state > 0.5 then
      set("a320/Overhead/LightTurn", 1)
    else
      set("a320/Overhead/LightTurn", 0)
    end
  end
  create_command("a320helper/lights/taxi_lights_toggle", "Toggle taxi lights",
      "a320helper_taxi_lights_toggle()", "", "")
    

  function a320helper_strobe_light_toggle()
    local current_state = get("a320/Overhead/LightStrobe")
    if current_state < 1.5 then
      set("a320/Overhead/LightStrobe", 2)
    else
      set("a320/Overhead/LightStrobe", 0)
    end
  end
  create_command("a320helper/lights/strobe_light_toggle", "Toggle strobe light",
      "a320helper_strobe_light_toggle()", "", "")
end