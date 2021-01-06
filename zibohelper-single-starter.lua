if PLANE_ICAO == "B738" then
  logMsg("ZiboHelper: setting up single engine starter command...")

  function starter_grd()
    if get("laminar/B738/engine/mixture_ratio2") < 0.5 then
      command_once("laminar/B738/rotary/eng2_start_grd")
    else
      command_once("laminar/B738/rotary/eng1_start_grd")
    end
  end
  create_command("zibohelper/single_starter/grd",
      "Single starter: GRD",
      "starter_grd()",
      "",
      "")

  function starter_off()
    command_once("laminar/B738/rotary/eng1_start_off")
    command_once("laminar/B738/rotary/eng2_start_off")
  end
  create_command("zibohelper/single_starter/off",
      "Single starter: OFF/AUTO",
      "starter_off()",
      "",
      "")

  function starter_cont()
    if get("laminar/B738/engine/mixture_ratio1") > 0.5 then
      command_once("laminar/B738/rotary/eng1_start_cont")
    end
    if get("laminar/B738/engine/mixture_ratio2") > 0.5 then
      command_once("laminar/B738/rotary/eng2_start_cont")
    end
  end
  create_command("zibohelper/single_starter/cont",
      "Single starter: CONT",
      "starter_cont()",
      "",
      "")

  function starter_flt()
    if get("laminar/B738/engine/mixture_ratio1") > 0.5 then
      command_once("laminar/B738/rotary/eng1_start_flt")
    end
    if get("laminar/B738/engine/mixture_ratio2") > 0.5 then
      command_once("laminar/B738/rotary/eng2_start_flt")
    end
  end
  create_command("zibohelper/single_starter/flt",
      "Single starter: FLT",
      "starter_flt()",
      "",
      "")

  logMsg("ZiboHelper: ok.")
end