if PLANE_ICAO == "B738" then
  logMsg("ZiboHelper: setting up throttle TOGA/Disco command...")

  local toga_disco_time = 0.0
  local TOGA_DISCO_HOLD_TIME = 0.5  -- seconds for long press

  function toga_disco_press()
    toga_disco_time = os.clock()
  end

  function toga_disco_hold()
    if toga_disco_time and os.clock() > (toga_disco_time + TOGA_DISCO_HOLD_TIME) then
      command_once("laminar/B738/autopilot/left_at_dis_press")
    end
  end

  function toga_disco_release()
    if os.clock() <= (toga_disco_time + TOGA_DISCO_HOLD_TIME) then
      command_once("laminar/B738/autopilot/left_toga_press")
    end
  end

  create_command("zibohelper/toga_disco",
      "Combined TOGA/Disconnect button",
      "toga_disco_press()",
      "toga_disco_hold()",
      "toga_disco_release()")

  logMsg("ZiboHelper: ok.")
end