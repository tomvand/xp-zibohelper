if PLANE_ICAO == "A320" then
  function a320helper_wipers_inc()
    command_once("a320/Overhead/Wiper1Mode_switch+")
    command_once("a320/Overhead/Wiper2Mode_switch+")
  end
  create_command("a320helper/wipers/inc", "Wipers: increase",
      "a320helper_wipers_inc()", "", "")


  function a320helper_wipers_dec()
    command_once("a320/Overhead/Wiper1Mode_switch-")
    command_once("a320/Overhead/Wiper2Mode_switch-")
  end
  create_command("a320helper/wipers/dec", "Wipers: decrease",
      "a320helper_wipers_dec()", "", "")
end