-- Generic aircraft wrapper to simplify scripts
-- (So essentially what datarefs should have been doing(!))


-- Global aircraft table
-- See default value initialization in aircraft_keep_current() for overview
aircraft = nil


function aircraft_keep_current()
  if aircraft == nil or PLANE_ICAO ~= aircraft.icao_type then
    -- Set up global aircraft struct
    -- Set default values
    aircraft = {
      icao_type = PLANE_ICAO,
      -- LIGHTS ---------------------------------------------------------------
      lights = {
        nav = function(state)
          if state == "on" then
            command_once("sim/lights/nav_lights_on")
          elseif state == "off" then
            command_once("sim/lights/nav_lights_off")
          elseif state == "toggle" then
            command_once("sim/lights/nav_lights_toggle")
          end
          return get("sim/cockpit2/switches/navigation_lights_on") > 0
        end,
        beacon = function(state)
          if state == "on" then
            command_once("sim/lights/beacon_lights_on")
          elseif state == "off" then
            command_once("sim/lights/beacon_lights_off")
          elseif state == "toggle" then
            command_once("sim/lights/beacon_lights_toggle")
          end
          return get("sim/cockpit2/switches/beacon_on") > 0
        end,
        strobe = function(state)
          if state == "on" then
            command_once("sim/lights/strobe_lights_on")
          elseif state == "off" then
            command_once("sim/lights/strobe_lights_off")
          elseif state == "toggle" then
            command_once("sim/lights/strobe_lights_toggle")
          end
          return get("sim/cockpit2/switches/strobe_lights_on") > 0
        end,
        landing = {
          all = function(state)
            if state == "on" then
              command_once("sim/lights/landing_lights_on")
            elseif state == "off" then
              command_once("sim/lights/landing_lights_off")
            elseif state == "toggle" then
              command_once("sim/lights/landing_lights_toggle")
            end
            return get("sim/cockpit2/switches/landing_lights_on") > 0
          end,
        },
        taxi = {
          all = function(state)
            if state == "on" then
              command_once("sim/lights/taxi_lights_on")
            elseif state == "off" then
              command_once("sim/lights/taxi_lights_off")
            elseif state == "toggle" then
              command_once("sim/lights/taxi_lights_toggle")
            end
            return get("sim/cockpit2/switches/taxi_light_on") > 0
          end,
        },
      },
    }
    -- Override functions for specific aircraft
  end
end
do_every_frame("aircraft_keep_current()")  -- Should not cost fps, as it returns immediately unless switching aircraft