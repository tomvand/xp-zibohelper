require("graphics")

local get_landing_lights = nil
local get_taxi_lights = nil
local get_strobe = nil
local get_beacon = nil
local get_xpdr = nil
local get_parkbrake = nil
local get_gear = nil
local get_onground = nil

local current_landing_lights = false
local current_taxi_lights = false
local current_strobe = false
local current_beacon = false
local current_xpdr = false
local current_parkbrake = false
local current_gear = false
local current_onground = true

local datarefs_loaded = false

local taxi_lights_label = "T"

local reminder_timeout = 0.0

local TIMEOUT = 1.0
local FADEOUT_TIME = 1.0

local function lr_load_datarefs()
  if datarefs_loaded then
    return true
  end

  if get_onground == nil then
    local xplm_onground = XPLMFindDataRef("sim/flightmodel/failures/onground_any")
    if xplm_onground ~= nil then
      get_onground = function() return XPLMGetDatai(xplm_onground) == 1; end
    end
    return false
  end
  
  if PLANE_ICAO == "A320" then
    if get_landing_lights == nil then
      local xplm_landing_lights = XPLMFindDataRef("a320/Overhead/LightLandL")
      if xplm_landing_lights ~= nil then
        get_landing_lights = function() return XPLMGetDataf(xplm_landing_lights) > 1.5; end
      end
    elseif get_taxi_lights == nil then
      xplm_taxi_lights = XPLMFindDataRef("a320/Overhead/LightNose")
      if xplm_taxi_lights ~= nil then
        get_taxi_lights = function() return XPLMGetDataf(xplm_taxi_lights) > 0.5; end
      end
      taxi_lights_label = "N"
    elseif get_strobe == nil then
      xplm_strobe = XPLMFindDataRef("sim/cockpit/electrical/strobe_lights_on")
      if xplm_strobe ~= nil then
        get_strobe = function() return XPLMGetDatai(xplm_strobe) == 1; end
      end
    elseif get_beacon == nil then
      xplm_beacon = XPLMFindDataRef("a320/Overhead/LightBeacon")
      if xplm_beacon ~= nil then
        get_beacon = function() return XPLMGetDataf(xplm_beacon) > 0.5; end
      end
    elseif get_xpdr == nil then
      xplm_xpdr = XPLMFindDataRef("a320/Pedestal/TCAS_Traffic")
      if xplm_xpdr ~= nil then
        get_xpdr = function() return XPLMGetDataf(xplm_xpdr) > 0.5; end
      end
    elseif get_parkbrake == nil then
      xplm_parkbrake = XPLMFindDataRef("a320/Pedestal/ParkBrake")
      if xplm_parkbrake ~= nil then
        get_parkbrake = function() return XPLMGetDataf(xplm_parkbrake) > 0.5; end
      end
    elseif get_gear == nil then
      xplm_gear = XPLMFindDataRef("sim/cockpit2/controls/gear_handle_down")
      if xplm_gear ~= nil then
        get_gear = function() return XPLMGetDataf(xplm_gear) > 0.5; end
      end
    else
      datarefs_loaded = true
    end
  elseif PLANE_ICAO == "B738" then
    local drt_lights = dataref_table("laminar/B738/lights_sw")
    if get_landing_lights == nil then
      local xplm_landing_lights = XPLMFindDataRef("laminar/B738/switch/land_lights_left_pos")
      if xplm_landing_lights ~= nil then
        get_landing_lights = function() return XPLMGetDataf(xplm_landing_lights) > 0.5; end
      end
    elseif get_taxi_lights == nil then
      if drt_lights ~= nil then
        get_taxi_lights = function() return drt_lights[8] > 0.5; end
      end
    elseif get_strobe == nil then
      if drt_lights ~= nil then
        get_strobe = function() return drt_lights[0] > 0.5; end
      end
    elseif get_beacon == nil then
      if drt_lights ~= nil then
        get_beacon = function() return drt_lights[17] > 0.5; end
      end
    elseif get_xpdr == nil then
      local xplm_xpdr = XPLMFindDataRef("laminar/B738/knob/transponder_pos")
      if xplm_xpdr ~= nil then
        get_xpdr = function() return XPLMGetDataf(xplm_xpdr) > 3.5; end
      end
    elseif get_parkbrake == nil then
      local xplm_parkbrake = XPLMFindDataRef("laminar/B738/parking_brake_pos")
      if xplm_parkbrake ~= nil then
        get_parkbrake = function() return XPLMGetDataf(xplm_parkbrake) > 0.5; end
      end
    elseif get_gear == nil then
      local xplm_gear = XPLMFindDataRef("laminar/B738/controls/gear_handle_down")
      if xplm_gear ~= nil then
        get_gear = function() return XPLMGetDataf(xplm_gear) > 0.75; end
      end
    else
      datarefs_loaded = true
    end
  else
    -- TODO Default
  end
  return false
end


function lights_reminder_on_frame()
  if not lr_load_datarefs() then
    return
  end

  local landing_lights = get_landing_lights()
  local taxi_lights = get_taxi_lights()
  local strobe = get_strobe()
  local beacon = get_beacon()
  local xpdr = get_xpdr()

  current_parkbrake = get_parkbrake()
  current_onground = get_onground()  
  current_gear = get_gear()

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
  if xpdr ~= current_xpdr then
    current_xpdr = xpdr
    reminder_timeout = os.clock() + TIMEOUT
  end

  -- Always show in these circumstances
  if current_onground and (landing_lights or strobe) then
    reminder_timeout = os.clock() + TIMEOUT
  end
  if not current_onground and not (strobe and beacon) then
    reminder_timeout = os.clock() + TIMEOUT
  end
  if current_gear and landing_lights and not taxi_lights then
    reminder_timeout = os.clock() + TIMEOUT
  end
  if not current_parkbrake and not beacon then
    reminder_timeout = os.clock() + TIMEOUT
  end
  if strobe ~= xpdr then
    reminder_timeout = os.clock() + TIMEOUT
  end
end
do_every_frame("lights_reminder_on_frame()")


function lights_reminder_on_draw()
  if os.clock() > reminder_timeout + FADEOUT_TIME then
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
  elseif current_landing_lights and current_gear then
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
    glColor4f(1.0, 0.0, 0.0, alpha)
  else
    glColor4f(1.0, 1.0, 1.0, alpha)
  end
  draw_string_Helvetica_18(x0 - 30, y0 - 30, "B")

  if current_xpdr then
    glColor4f(0.0, 1.0, 0.0, alpha)
  elseif current_strobe then
    glColor4f(1.0, 0.0, 0.0, alpha)
  else
    glColor4f(1.0, 1.0, 1.0, alpha)
  end
  draw_string_Helvetica_18(x0, y0 - 30, "XPDR")
end
do_every_draw("lights_reminder_on_draw()")
