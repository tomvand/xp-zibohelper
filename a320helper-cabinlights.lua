--[[
Add the following lines to A320Connector/custom.cfg:
# add datarefs for fap cabin lights.  The main switch is a decoy. fwd/cab/aft are the controls
DATAREF;INT;Aircraft.Electric.CIDS.FAP.FwdLight;-1;NORM;
DATAREF;INT;Aircraft.Electric.CIDS.FAP.CabLight;-1;NORM;
DATAREF;INT;Aircraft.Electric.CIDS.FAP.AftLight;-1;NORM; 
]]--

if PLANE_ICAO == "A320" then
  local dr_fwdlight = nil
  local dr_cablight = nil
  local dr_aftlight = nil
  local dr_noselight = nil

  local dr_sun_pitch = nil
  local dr_onground = nil
  local dr_alt_m = nil

  function a320helper_cabinlights_sometimes()
    -- Find datarefs
    if dr_fwdlight == nil or dr_cablight == nil or dr_aftlight == nil or dr_noselight == nil then
      dr_fwdlight = XPLMFindDataRef("MOKNY/FFA320/Aircraft/Electric/CIDS/FAP/FwdLight")
      dr_cablight = XPLMFindDataRef("MOKNY/FFA320/Aircraft/Electric/CIDS/FAP/CabLight")
      dr_aftlight = XPLMFindDataRef("MOKNY/FFA320/Aircraft/Electric/CIDS/FAP/AftLight")
      dr_noselight = XPLMFindDataRef("a320/Overhead/LightNose")
      return
    end
    if dr_sun_pitch == nil or dr_onground == nil or dr_alt_m == nil then
      dr_sun_pitch = XPLMFindDataRef("sim/graphics/scenery/sun_pitch_degrees")
      dr_onground = XPLMFindDataRef("sim/flightmodel/failures/onground_any")
      dr_alt_m = XPLMFindDataRef("sim/flightmodel/position/elevation")
      return
    end

    -- Set lights
    local sun_pitch = XPLMGetDataf(dr_sun_pitch)
    local onground = XPLMGetDatai(dr_onground)
    local alt_m = XPLMGetDataf(dr_alt_m)
    local noselight = XPLMGetDataf(dr_noselight) > 0
    if sun_pitch > 1.0 then
      -- Daytime configuration: fully on at gate, off inbetween
      if onground and not noselight then
        XPLMSetDatai(dr_fwdlight, 3)
        XPLMSetDatai(dr_cablight, 3)
        XPLMSetDatai(dr_aftlight, 3)
      else
        XPLMSetDatai(dr_fwdlight, 0)
        XPLMSetDatai(dr_cablight, 0)
        XPLMSetDatai(dr_aftlight, 0)
      end
    else
      -- Night time configuration: fully on at gate, dimmed below FL100, medium inbetween
      if onground and not noselight then
        XPLMSetDatai(dr_fwdlight, 3)
        XPLMSetDatai(dr_cablight, 3)
        XPLMSetDatai(dr_aftlight, 3)
      elseif alt_m < 3048 then
        XPLMSetDatai(dr_fwdlight, 1)
        XPLMSetDatai(dr_cablight, 1)
        XPLMSetDatai(dr_aftlight, 1)
      else
        XPLMSetDatai(dr_fwdlight, 2)
        XPLMSetDatai(dr_cablight, 2)
        XPLMSetDatai(dr_aftlight, 2)
      end
    end
  end
  do_sometimes("a320helper_cabinlights_sometimes()")

end