if PLANE_ICAO == "B738" then
  function zibohelper_wipers_inc()
    command_once("laminar/B738/knob/left_wiper_up")
    command_once("laminar/B738/knob/right_wiper_up")
  end
  create_command("zibohelper/wipers/inc", "Wipers: increase",
      "zibohelper_wipers_inc()", "", "")


  function zibohelper_wipers_dec()
    command_once("laminar/B738/knob/left_wiper_dn")
    command_once("laminar/B738/knob/right_wiper_dn")
  end
  create_command("zibohelper/wipers/dec", "Wipers: decrease",
      "zibohelper_wipers_dec()", "", "")
end