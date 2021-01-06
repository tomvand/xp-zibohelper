if PLANE_ICAO == "A320" then
  logMsg("A320Helper: setting up engine master commands...")

  function engmaster1_on()
    if get("a320/Aircraft/Cockpit/Pedestal/EngineMaster1/Position") < 1 then
      command_once("a320/Pedestal/EngineMaster1_switch+")
    end
  end
  create_command("a320helper/engmaster/1-on",
      "Engine master 1: on",
      "engmaster1_on()", "", "")

  function engmaster1_off()
    if get("a320/Aircraft/Cockpit/Pedestal/EngineMaster1/Position") > 0 then
      command_once("a320/Pedestal/EngineMaster1_switch+")
    end
  end
  create_command("a320helper/engmaster/1-off",
      "Engine master 1: off",
      "engmaster1_off()", "", "")

  function engmaster2_on()
    if get("a320/Aircraft/Cockpit/Pedestal/EngineMaster2/Position") < 1 then
      command_once("a320/Pedestal/EngineMaster2_switch+")
    end
  end
  create_command("a320helper/engmaster/2-on",
      "Engine master 2: on",
      "engmaster2_on()", "", "")

  function engmaster2_off()
    if get("a320/Aircraft/Cockpit/Pedestal/EngineMaster2/Position") > 0 then
      command_once("a320/Pedestal/EngineMaster2_switch+")
    end
  end
  create_command("a320helper/engmaster/2-off",
      "Engine master 2: off",
      "engmaster2_off()", "", "")

  logMsg("A320Helper: ok.")
end