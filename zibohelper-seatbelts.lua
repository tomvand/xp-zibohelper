if PLANE_ICAO == "B738" then
  function zibohelper_seatbelts_toggle()
    local current_state = get("laminar/B738/toggle_switch/seatbelt_sign_pos")
    if current_state < 1.5 then
      command_once("laminar/B738/toggle_switch/seatbelt_sign_dn")
      command_once("laminar/B738/toggle_switch/seatbelt_sign_dn")
    else
      if get("sim/flightmodel2/position/y_agl") > 10 then
        command_once("laminar/B738/toggle_switch/seatbelt_sign_up")
      else
        command_once("laminar/B738/toggle_switch/seatbelt_sign_up")
        command_once("laminar/B738/toggle_switch/seatbelt_sign_up")
      end
    end
  end
  create_command("zibohelper/seatbelts_toggle", "Seatbelts: toggle",
      "zibohelper_seatbelts_toggle()", "", "")
end