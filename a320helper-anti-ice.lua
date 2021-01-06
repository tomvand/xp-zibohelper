if PLANE_ICAO == "A320" then
  logMsg("A320Helper: setting up both engine anti-ice command...")

  function a320_anti_ice_command()
    command_once("a320/Overhead/HeatEngine1_button")
    command_once("a320/Overhead/HeatEngine2_button")
  end

  create_command("a320helper/anti-ice",
      "Togle both engine anti-ice",
      "a320_anti_ice_command()", "", "")

  logMsg("A320Helper: ok.")
end