if PLANE_ICAO == "DH8D" then
  local axis = dataref_table("sim/joystick/joystick_axis_values")

  local AXIS_LANDINGLIGHTS = 2
  local AXIS_TAXILIGHTS = 0
  local AXIS_STROBELIGHTS = 1

  local landing_state = 0
  local taxi_state = 0
  local strobe_state = 0

  local strobe_pos = nil

  dt_landing_lights = dataref_table("sim/cockpit2/switches/landing_lights_switch")
  dataref("dr_taxi_light", "sim/cockpit2/switches/taxi_light_on", "writeable")

  -- dt_landing_lights[0]: approach lights
  -- dt_landing_lights[1]: flare lights

  function q400_lights_on_frame()
    -- Landing lights
    if 2 * axis[AXIS_LANDINGLIGHTS] > landing_state + 0.6 then
      landing_state = landing_state + 1
    elseif 2 * axis[AXIS_LANDINGLIGHTS] < landing_state - 0.6 then
      landing_state = landing_state - 1
    end
    local pos = dt_landing_lights[0] + dt_landing_lights[1]
    if landing_state == 0 and pos ~= 0 then
      dt_landing_lights[0] = 0
      dt_landing_lights[1] = 0
    elseif landing_state == 1 and pos ~= 1 then
      dt_landing_lights[0] = 1
      dt_landing_lights[1] = 0
    elseif landing_state == 2 and pos ~= 2 then
      dt_landing_lights[0] = 1
      dt_landing_lights[1] = 1
    end

    -- Taxi lights
    if axis[AXIS_TAXILIGHTS] > taxi_state + 0.6 then
      taxi_state = taxi_state + 1
    elseif axis[AXIS_TAXILIGHTS] < taxi_state - 0.6 then
      taxi_state = taxi_state - 1
    end
    local taxi_pos = dr_taxi_light
    if taxi_state ~= taxi_pos then
      dr_taxi_light = taxi_state
    end

    -- Strobe light
    if 2 * axis[AXIS_STROBELIGHTS] > strobe_state + 0.6 then
      strobe_state = strobe_state + 1
    elseif 2 * axis[AXIS_STROBELIGHTS] < strobe_state - 0.6 then
      strobe_state = strobe_state - 1
    end
    if strobe_state == 0 and strobe_pos ~= 0 then
      command_once("FJS/Com/antiRed")
      strobe_pos = strobe_state
    elseif strobe_state == 1 and strobe_pos ~= 1 then
      command_once("FJS/Com/antiOff")
      strobe_pos = strobe_state
    elseif strobe_state == 2 and strobe_pos ~= 2 then
      command_once("FJS/Com/antiWhite")
      strobe_pos = strobe_state
    end
  end
  do_every_frame("q400_lights_on_frame()")
end