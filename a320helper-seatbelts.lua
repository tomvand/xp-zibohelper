if PLANE_ICAO == "A320" then
  function a320helper_seatbelts_toggle()
    local current_state = get("a320/Overhead/LightBelts")
    if current_state < 1.5 then
      set("a320/Overhead/LightBelts", 2)
    else
      if get("sim/flightmodel2/position/y_agl") > 10 then
        set("a320/Overhead/LightBelts", 1)
      else
        set("a320/Overhead/LightBelts", 0)
      end
    end
  end
  create_command("a320helper/seatbelts_toggle", "Seatbelts: toggle",
      "a320helper_seatbelts_toggle()", "", "")
end