if PLANE_ICAO == "A320" then
  logMsg("A320Helper: setting up throttle TOGA/Disco command...")

  local apu_toggle_time = 0.0
  local APU_TOGGLE_HOLD_TIME = 0.5

  function a320_apu_toggle_press()
    apu_toggle_time = os.clock()
  end

  function a320_apu_toggle_hold()
    if apu_toggle_time and os.clock() > (apu_toggle_time + APU_TOGGLE_HOLD_TIME) then
      command_begin("a320/Overhead/APU_Start_button")
    end
  end

  function a320_apu_toggle_release()
    if os.clock() <= (apu_toggle_time + APU_TOGGLE_HOLD_TIME) then
      command_once("a320/Overhead/APU_Master_button")
    else
      command_end("a320/Overhead/APU_Start_button")
    end
  end

  create_command("a320helper/apu_toggle",
      "APU Master/Start button",
      "a320_apu_toggle_press()",
      "a320_apu_toggle_hold()",
      "a320_apu_toggle_release()")

  logMsg("A320Helper: ok.")
end