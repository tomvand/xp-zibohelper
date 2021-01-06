if PLANE_ICAO == "A320" then
  a320sbrk_dr_speedbrake = XPLMFindDataRef("sim/cockpit2/controls/speedbrake_ratio")

  function a320sbrk_retract_arm()
    local x = XPLMGetDataf(a320sbrk_dr_speedbrake)
    if x < 0.1 then
      XPLMSetDataf(a320sbrk_dr_speedbrake, -0.5)
    else
      command_once("sim/flight_controls/speed_brakes_up_one")
    end
  end

  create_command("a320helper/speedbrake/retract_arm",
      "Speedbrake: retract one or arm",
      "a320sbrk_retract_arm()", "", "")
end