if PLANE_ICAO == "A320" then
  function a320helper_transponder_tara()
    set("a320/Pedestal/ATC_Mode", 2)
    set("a320/Pedestal/TCAS_Traffic", 2)
  end
  create_command("a320helper/transponder/tara", "Transponder: TA/RA",
      "a320helper_transponder_tara()", "", "")
  

  function a320helper_transponder_stdby()
    set("a320/Pedestal/ATC_Mode", 2)
    set("a320/Pedestal/TCAS_Traffic", 0)
  end
  create_command("a320helper/transponder/stdby", "Transponder: STDBY",
      "a320helper_transponder_stdby()", "", "")
end