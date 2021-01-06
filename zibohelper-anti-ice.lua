if PLANE_ICAO == "B738" then
  logMsg("ZiboHelper: setting up toggle both engine anti-ice command...")

  function anti_ice_command()
    command_once("laminar/B738/toggle_switch/eng1_heat")
    command_once("laminar/B738/toggle_switch/eng2_heat")
  end
  
  create_command("zibohelper/anti-ice",
      "Togle both engine anti-ice",
      "anti_ice_command()", "", "")

  logMsg("ZiboHelper: ok.")
end