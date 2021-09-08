if PLANE_ICAO == "B738" then
  local axis = dataref_table("sim/joystick/joystick_axis_values")

  local AXIS_LANDINGLIGHTS = 2
  local AXIS_TAXILIGHTS = 0
  local AXIS_STROBELIGHTS = 1

  local landing_state = 0
  local taxi_state = 0
  local strobe_state = 0

  if axis[AXIS_LANDINGLIGHTS] < 0 or axis[AXIS_STROBELIGHTS] < 0 or axis[AXIS_TAXILIGHTS] < 0 then
    return -- Joystick not connected
  end

  function zibohelper_lights_axes_on_frame()
    -- Landing lights
    if 2 * axis[AXIS_LANDINGLIGHTS] > landing_state + 0.6 then
      landing_state = landing_state + 1
    elseif 2 * axis[AXIS_LANDINGLIGHTS] < landing_state - 0.6 then
      landing_state = landing_state - 1
    end
    local ret_pos = get("laminar/B738/switch/land_lights_ret_left_pos")
    if landing_state == 0 and ret_pos ~= 0 then
      set("laminar/B738/switch/land_lights_left_pos", 0)
      set("laminar/B738/switch/land_lights_right_pos", 0)
      command_once("laminar/B738/switch/land_lights_ret_left_off")
      command_once("laminar/B738/switch/land_lights_ret_right_off")
    elseif landing_state == 1 and ret_pos ~= 1 then
      set("laminar/B738/switch/land_lights_left_pos", 0)
      set("laminar/B738/switch/land_lights_right_pos", 0)
      command_once("laminar/B738/switch/land_lights_ret_left_ret")
      command_once("laminar/B738/switch/land_lights_ret_right_ret")
    elseif landing_state == 2 and ret_pos ~= 2 then
      set("laminar/B738/switch/land_lights_left_pos", 1)
      set("laminar/B738/switch/land_lights_right_pos", 1)
      command_once("laminar/B738/switch/land_lights_ret_left_on")
      command_once("laminar/B738/switch/land_lights_ret_right_on")
    end

    -- Taxi lights
    if 2 * axis[AXIS_TAXILIGHTS] > taxi_state + 0.6 then
      taxi_state = taxi_state + 1
    elseif 2 * axis[AXIS_TAXILIGHTS] < taxi_state - 0.6 then
      taxi_state = taxi_state - 1
    end
    local rwy_pos = get("laminar/B738/toggle_switch/rwy_light_left")
    if taxi_state == 0 and rwy_pos ~= 0 then
      command_once("laminar/B738/switch/rwy_light_left_off")
      command_once("laminar/B738/switch/rwy_light_right_off")
    elseif taxi_state > 0 and rwy_pos == 0 then
      command_once("laminar/B738/switch/rwy_light_left_on")
      command_once("laminar/B738/switch/rwy_light_right_on")
    end
    local taxi_pos = get("laminar/B738/toggle_switch/taxi_light_brightness_pos")
    if taxi_state < 2 and taxi_pos ~= 0 then
      command_once("laminar/B738/toggle_switch/taxi_light_brightness_off")
    elseif taxi_state == 2 and taxi_pos == 0 then
      command_once("laminar/B738/toggle_switch/taxi_light_brightness_on")
    end

    -- Strobe light
    if 2 * axis[AXIS_STROBELIGHTS] > strobe_state + 0.6 then
      strobe_state = strobe_state + 1
    elseif 2 * axis[AXIS_STROBELIGHTS] < strobe_state - 0.6 then
      strobe_state = strobe_state - 1
    end
    local strobe_pos = get("laminar/B738/toggle_switch/position_light_pos")
    if strobe_state == 0 and strobe_pos ~= 1 then
      command_once("laminar/B738/toggle_switch/position_light_strobe")
    elseif strobe_state == 1 and strobe_pos ~= 0 then
      command_once("laminar/B738/toggle_switch/position_light_off")
    elseif strobe_state == 2 and strobe_pos ~= -1 then
      command_once("laminar/B738/toggle_switch/position_light_steady")
    end
  end
  do_every_frame("zibohelper_lights_axes_on_frame()")
end