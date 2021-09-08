if PLANE_ICAO == "E170" or PLANE_ICAO == "E195" then
  -- Light axes
  local axis = dataref_table("sim/joystick/joystick_axis_values")
  local AXIS_LANDINGLIGHTS = 2
  local AXIS_TAXILIGHTS = 0
  local AXIS_STROBELIGHTS = 1
  local landing_state = 0
  local taxi_state = 0
  local strobe_state = 0

  function ejethelper_lights_axes_on_frame()
    if axis[AXIS_LANDINGLIGHTS] < 0 or axis[AXIS_STROBELIGHTS] < 0 or axis[AXIS_TAXILIGHTS] < 0 then
      return -- Joystick not connected
    end
    -- Landing lights
    if 2.0 - 2 * axis[AXIS_LANDINGLIGHTS] > landing_state + 0.6 then
      landing_state = landing_state + 1
    elseif 2.0 - 2 * axis[AXIS_LANDINGLIGHTS] < landing_state - 0.6 then
      landing_state = landing_state - 1
    end
    local land_side_pos = get("SSG/EJET/LIGHTS/land_left_lights_sw")
    local land_nose_pos = get("SSG/EJET/LIGHTS/land_nose_lights_sw")
    if landing_state == 0 and land_side_pos ~= 0 then
      set("SSG/EJET/LIGHTS/land_left_lights_sw", 0)
      set("SSG/EJET/LIGHTS/land_right_lights_sw", 0)
      set("SSG/EJET/LIGHTS/land_nose_lights_sw", 0)
    elseif landing_state == 1 and (land_side_pos ~= 1 or land_nose_pos ~= 0) then
      set("SSG/EJET/LIGHTS/land_left_lights_sw", 1)
      set("SSG/EJET/LIGHTS/land_right_lights_sw", 1)
      set("SSG/EJET/LIGHTS/land_nose_lights_sw", 0)
    elseif landing_state == 2 and land_nose_pos ~= 1 then
      set("SSG/EJET/LIGHTS/land_left_lights_sw", 1)
      set("SSG/EJET/LIGHTS/land_right_lights_sw", 1)
      set("SSG/EJET/LIGHTS/land_nose_lights_sw", 1)
    end

    -- Taxi lights
    if 2.0 - 2 * axis[AXIS_TAXILIGHTS] > taxi_state + 0.6 then
      taxi_state = taxi_state + 1
    elseif 2.0 - 2 * axis[AXIS_TAXILIGHTS] < taxi_state - 0.6 then
      taxi_state = taxi_state - 1
    end
    local taxi_side_pos = get("SSG/EJET/LIGHTS/taxi_side_lights_sw")
    local taxi_nose_pos = get("SSG/EJET/LIGHTS/taxi_nose_lights_sw")
    if taxi_state == 0 and taxi_side_pos ~= 0 then
      set("SSG/EJET/LIGHTS/taxi_side_lights_sw", 0)
      set("SSG/EJET/LIGHTS/taxi_nose_lights_sw", 0)
    elseif taxi_state == 1 and (taxi_side_pos ~= 1 or taxi_nose_pos ~= 0) then
      set("SSG/EJET/LIGHTS/taxi_side_lights_sw", 1)
      set("SSG/EJET/LIGHTS/taxi_nose_lights_sw", 0)
    elseif taxi_state == 2 and taxi_nose_pos ~= 1 then
      set("SSG/EJET/LIGHTS/taxi_side_lights_sw", 1)
      set("SSG/EJET/LIGHTS/taxi_nose_lights_sw", 1)
    end

    -- Beacon/strobe lights
    if 2.0 - 2 * axis[AXIS_STROBELIGHTS] > strobe_state + 0.6 then
      strobe_state = strobe_state + 1
    elseif 2.0 - 2 * axis[AXIS_STROBELIGHTS] < strobe_state - 0.6 then
      strobe_state = strobe_state - 1
    end
    local beacon_pos = get("SSG/EJET/LIGHTS/bcn_lights_sw")
    local strobe_pos = get("SSG/EJET/LIGHTS/strobe_lights_sw")
    if strobe_state == 0 and beacon_pos ~= 0 then
      set("SSG/EJET/LIGHTS/bcn_lights_sw", 0)
      set("SSG/EJET/LIGHTS/strobe_lights_sw", 0)
    elseif strobe_state == 1 and (beacon_pos ~= 1 or strobe_pos ~= 0) then
      set("SSG/EJET/LIGHTS/bcn_lights_sw", 1)
      set("SSG/EJET/LIGHTS/strobe_lights_sw", 0)
    elseif strobe_state == 2 and strobe_pos ~= 1 then
      set("SSG/EJET/LIGHTS/bcn_lights_sw", 1)
      set("SSG/EJET/LIGHTS/strobe_lights_sw", 1)
    end
  end
  do_every_frame("ejethelper_lights_axes_on_frame()")

  -- XPDR (bug: MCDU display does not update, but transponder changes!)
  local xpdr_toggling = false
  local xpdr_radio_pressed = false
  local xpdr_lk6_pressed = false
  function ejethelper_xpdr_on_frame()
    if xpdr_toggling then
      if not xpdr_radio_pressed then
        logMsg("RADIO press")
        set("SSG/UFMC/NAVRAD", -1)
        xpdr_radio_pressed = true
      elseif get("SSG/UFMC/NAVRAD") ~= 0 then
        logMsg("RADIO release")
        set("SSG/UFMC/NAVRAD", 0)
      elseif not xpdr_lk6_pressed then
        logMsg("LK6 press")
        set("SSG/UFMC/LK6", -1)
        xpdr_lk6_pressed = true
      elseif get("SSG/UFMC/LK6") ~= 0 then
        logMsg("LK6 release")
        set("SSG/UFMC/LK6", 0)
      else
        xpdr_toggling = false
        xpdr_radio_pressed = false
        xpdr_lk6_pressed = false
      end
    end
  end
  do_every_frame("ejethelper_xpdr_on_frame()")

  function ejethelper_xpdr(pos)
    if get("sim/cockpit/radios/transponder_mode") ~= pos then
      xpdr_toggling = true
    end
  end
  create_command("ejethelper/xpdr/stdby", "Transponder: STDBY",
      "ejethelper_xpdr(1)", "", "")
  create_command("ejethelper/xpdr/tara", "Transponder: TA/RA",
      "ejethelper_xpdr(2)", "", "")
end
