require("graphics")

local xplm_landing_lights = nil
local xplm_taxi_lights = nil
local xplm_strobe = nil
local xplm_beacon = nil
local xplm_parkbrake = nil
local xplm_onground = nil

local current_landing_lights = false
local current_taxi_lights = false
local current_strobe = false
local current_beacon = false
local current_parkbrake = false

local datarefs_loaded = false

local taxi_lights_label = "T"

local reminder_timeout = 0.0

local TIMEOUT = 1.0
local FADEOUT_TIME = 1.0

local function lr_load_datarefs()
  if datarefs_loaded then
    return true
  end

  if xplm_onground == nil then
    xplm_onground = XPLMFindDataRef("sim/flightmodel/failures/onground_any")
    return false
  end

  if PLANE_ICAO == "A320" then
    if xplm_landing_lights == nil then
      xplm_landing_lights = XPLMFindDataRef("a320/Overhead/LightLandL")
      return false
    elseif xplm_taxi_lights == nil then
      xplm_taxi_lights = XPLMFindDataRef("a320/Overhead/LightNose")
      taxi_lights_label = "N"
      return false
    elseif xplm_strobe == nil then
      xplm_strobe = XPLMFindDataRef("a320/Overhead/LightStrobe")
      return false
    elseif xplm_beacon == nil then
      xplm_beacon = XPLMFindDataRef("a320/Overhead/LightBeacon")
      return false
    elseif xplm_parkbrake == nil then
      xplm_parkbrake = XPLMFindDataRef("a320/Pedestal/ParkBrake")
      return false
    end
  elseif PLANE_ICAO == "B738" then
    if xplm_landing_lights == nil then
      xplm_landing_lights = XPLMFindDataRef("laminar/B738/switch/land_lights_left_pos")
      return false
    elseif xplm_taxi_lights == nil then
      xplm_taxi_lights = XPLMFindDataRef("a320/Overhead/LightNose")
      taxi_lights_label = "N"
      return false
    elseif xplm_strobe == nil then
      xplm_strobe = XPLMFindDataRef("a320/Overhead/LightStrobe")
      return false
    elseif xplm_beacon == nil then
      xplm_beacon =  XPLMFindDataRef("a320/Overhead/LightBeacon")
      return false
    elseif xplm_parkbrake == nil then
      xplm_parkbrake = XPLMFindDataRef("a320/Pedestal/ParkBrake")
      return false
    end
  else
    -- TODO
  end
  datarefs_loaded = true
  return true
end


function lights_reminder_on_frame()
  if not lr_load_datarefs() then
    return
  end

  local landing_lights = XPLMGetDataf(xplm_landing_lights) > 0.5
  local taxi_lights = XPLMGetDataf(xplm_taxi_lights) > 0.5
  local strobe = XPLMGetDataf(xplm_strobe) > 0.5
  local beacon = XPLMGetDataf(xplm_beacon) > 0.5

  onground = XPLMGetDatai(xplm_onground) == 1
  current_parkbrake = XPLMGetDataf(xplm_parkbrake) > 0.5

  -- Detect changes
  if landing_lights ~= current_landing_lights then
    current_landing_lights = landing_lights
    reminder_timeout = os.clock() + TIMEOUT
  end
  if taxi_lights ~= current_taxi_lights then
    current_taxi_lights = taxi_lights
    reminder_timeout = os.clock() + TIMEOUT
  end
  if strobe ~= current_strobe then
    current_strobe = strobe
    reminder_timeout = os.clock() + TIMEOUT
  end
  if beacon ~= current_beacon then
    current_beacon = beacon
    reminder_timeout = os.clock() + TIMEOUT
  end

  -- Always show in these circumstances
  if onground and (landing_lights or strobe) then
    reminder_timeout = os.clock() + TIMEOUT
  end
  if landing_lights and not taxi_lights then
    reminder_timeout = os.clock() + TIMEOUT
  end
  if parkbrake and not beacon then
    reminder_timeout = os.clock() + TIMEOUT
  end
end
do_every_frame("lights_reminder_on_frame()")


function lights_reminder_on_draw()
  if os.clock() > reminder_timeout + 1.0 then
    return
  end

  -- fadeout transparency
  local alpha = 1.0 - (os.clock() - reminder_timeout) / FADEOUT_TIME
  if alpha < 0 then
    alpha = 0
  end
  glColor4f(0.0, 1.0, 0.0, alpha)

  -- draw
  local x0 = SCREEN_WIDTH * 0.90
  local y0 = SCREEN_HIGHT - 32.0
  
  if current_landing_lights then
    glColor4f(0.0, 1.0, 0.0, alpha)
  else
    glColor4f(1.0, 1.0, 1.0, alpha)
  end
  draw_string_Helvetica_18(x0 - 30, y0, "L")
  
  if current_taxi_lights then
    glColor4f(0.0, 1.0, 0.0, alpha)
  elseif current_landing_lights then
    glColor4f(1.0, 0.0, 0.0, alpha)
  else
    glColor4f(1.0, 1.0, 1.0, alpha)
  end
  draw_string_Helvetica_18(x0, y0, taxi_lights_label)

  if current_strobe then
    glColor4f(0.0, 1.0, 0.0, alpha)
  else
    glColor4f(1.0, 1.0, 1.0, alpha)
  end
  draw_string_Helvetica_18(x0 + 30, y0, "S")

  if current_beacon then
    glColor4f(0.0, 1.0, 0.0, alpha)
  elseif not current_parkbrake then
    glColor4f(1.0, 1.0, 1.0, alpha)
  else
    glColor4f(1.0, 1.0, 1.0, alpha)
  end
  draw_string_Helvetica_18(x0 - 30, y0 - 30, "B")
end
do_every_draw("lights_reminder_on_draw()")
