-- Fixes A320 beacon not syncing with x-plane, and therefore SAM/autogate
-- Based on marcgaub: https://forum.thresholdx.net/topic/546-jetway-not-connecting-to-a320-ultimate/page/2/?tab=comments#comment-7613

if PLANE_ICAO == "A320" then
  local ff_beacon = nil
  local xp_beacon = XPLMFindDataRef("sim/cockpit/electrical/beacon_lights_on")

  function a320helper_beacon_on_frame()
    -- Find datarefs
    if ff_beacon == nil then
      ff_beacon = XPLMFindDataRef("a320/Overhead/LightBeacon")
      if ff_beacon == nil then  -- still not found; probably still loading...
        return
      end
    end
    -- Sync datarefs
    -- set("sim/flightmodel2/lights/override_beacons_and_strobes", 0)
    if XPLMGetDataf(ff_beacon) > 0 then
      XPLMSetDatai(xp_beacon, 1)
    else
      XPLMSetDatai(xp_beacon, 0)
    end
  end
  do_every_frame("a320helper_beacon_on_frame()")
end
