if PLANE_ICAO == "B738" then
  logMsg("ZiboHelper: setting up APU toggle command...")

  local apu_current_pos = 0  -- 0: Off, 1: On, 2: Start
  local apu_press_time = 0.0
  local APU_HOLD_TIME = 0.5  -- seconds for long press

  function apu_toggle_press()
    if get("laminar/B738/electrical/apu_door") > 0.0 then
      apu_current_pos = 1
    else
      apu_current_pos = 0
    end
    apu_press_time = os.clock()
  end

  function apu_toggle_hold()
    if apu_current_pos == 1 and apu_press_time and os.clock() > (apu_press_time + APU_HOLD_TIME) then
      command_begin("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
      apu_current_pos = 2
    end
  end

  function apu_toggle_release()
    if apu_current_pos == 0 then
      command_once("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
    elseif apu_current_pos == 1 then
      command_once("laminar/B738/spring_toggle_switch/APU_start_pos_up")
    else
      command_end("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
    end
  end

  create_command("zibohelper/apu_toggle",
      "Toggle APU On/Off/Start",
      "apu_toggle_press()",
      "apu_toggle_hold()",
      "apu_toggle_release()")

  logMsg("ZiboHelper: ok.")
end