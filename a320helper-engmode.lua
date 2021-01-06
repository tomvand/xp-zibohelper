if PLANE_ICAO == "A320" then
  logMsg("A320Helper: setting up engine mode commands...")

  function engmode_crank()
    if get("a320/Aircraft/Cockpit/Pedestal/EngineMode/Position") > 0 then
      command_once("a320/Pedestal/EngineMode_switch-")
    end
  end
  create_command("a320helper/engine_mode/crank",
      "Engine mode: crank",
      "engmode_crank()", "", "")

  function engmode_norm()
    if get("a320/Aircraft/Cockpit/Pedestal/EngineMode/Position") < 0.25 then
      command_once("a320/Pedestal/EngineMode_switch+")
    end
    if get("a320/Aircraft/Cockpit/Pedestal/EngineMode/Position") > 0.75 then
      command_once("a320/Pedestal/EngineMode_switch-")
    end
  end
  create_command("a320helper/engine_mode/norm",
      "Engine mode: norm",
      "engmode_norm()", "", "")

  function engmode_start()
    if get("a320/Aircraft/Cockpit/Pedestal/EngineMode/Position") < 0.75 then
      command_once("a320/Pedestal/EngineMode_switch+")
    end
  end
  create_command("a320helper/engine_mode/start",
      "Engine mode: start",
      "engmode_start()", "", "")

  logMsg("A320Helper: ok.")
end