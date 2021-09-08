if PLANE_ICAO == "B738" then
  -- Speedbrake ARM toggle
  logMsg("ZiboHelper: setting up transponder STDBY/ALT OFF command...")
  local xpdr_time = 0.0
  local XPDR_HOLD_TIME = 0.5 -- seconds for long press
  function xpdr_press()
      xpdr_time = os.clock()
  end
  function xpdr_hold()
      if xpdr_time and os.clock() > (xpdr_time + XPDR_HOLD_TIME) then
          command_once("laminar/B738/knob/transponder_stby")
          xpdr_time = 0.0
      end
  end
  function xpdr_release()
      if os.clock() <= (xpdr_time + XPDR_HOLD_TIME) then
        command_once("laminar/B738/knob/transponder_altoff")
        xpdr_time = 0.0
      end
  end
  create_command("zibohelper/xpdr_stbdy_altoff",
          "Transponder ALT OFF/STDBY",
          "xpdr_press()",
          "xpdr_hold()",
          "xpdr_release()")
  logMsg("ZiboHelper: ok.")
end