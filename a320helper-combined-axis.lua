local THROTTLE1_ID = 127  -- joystick_axis_values
local THROTTLE1_IDLE = 1.0 - 0.24
local THROTTLE1_REVERSE = 1.0 - 0.17

local THROTTLE2_ID = 126  -- joystick_axis_values
local THROTTLE2_IDLE = 1.0 - 0.24
local THROTTLE2_REVERSE = 1.0 - 0.17


if PLANE_ICAO == "A320" then
  logMsg("A320Helper: setting up throttle/reverser axis...")

  DataRef("dr_throttle1", "sim/joystick/joystick_axis_values", "readonly", THROTTLE1_ID)
  DataRef("dr_throttle2", "sim/joystick/joystick_axis_values", "readonly", THROTTLE2_ID)

  DataRef("dr_rev", "a320/Aircraft/PowerPlant/EngineL/Reverse1", "readonly")

  DataRef("dr_lever1", "a320/Aircraft/Cockpit/Pedestal/EngineLever1", "writeable")
  DataRef("dr_lever2", "a320/Aircraft/Cockpit/Pedestal/EngineLever2", "writeable")

  local THROTTLE1_THRES = (THROTTLE1_IDLE + THROTTLE1_REVERSE) / 2.0
  local THROTTLE2_THRES = (THROTTLE2_IDLE + THROTTLE2_REVERSE) / 2.0

  function clip(inp)
    local out = inp
    if out > 1.0 then
      out = 1.0
    end
    if out < 0.0 then
      out = 0.0
    end
    return out
  end

  local throttle1_prev = -1.0
  local throttle2_prev = -1.0

  function throttle_changed()
    if dr_throttle1 ~= throttle1_prev or dr_throttle2 ~= throttle2_prev then
      throttle1_prev = dr_throttle1
      throttle2_prev = dr_throttle2
      return true
    end
    return false
  end

  function throttle_t_to_lever(t)
    if t < 0.385 then
      return 20.0 + (44.0 - 20.0) * t / 0.385
    elseif t < 0.68 then
      return 44.0 + (55.0 - 44.0) * (t - 0.385) / (0.68 - 0.385)
    else
      return 55.0 + (65.0 - 55.0) * (t - 0.68) / (1.0 - 0.68)
    end
  end


  local rev_cmd = false

  function a320_throttle_run()
    -- logMsg(dr_throttle1)
    -- logMsg(dr_throttle2)
    -- logMsg(dr_lever1)
    -- logMsg(dr_lever2)

    local reverse = false
    if dr_throttle1 > THROTTLE1_THRES or dr_throttle2 > THROTTLE2_THRES then
      reverse = true
    end

    if reverse and not rev_cmd then
      command_once("sim/engines/thrust_reverse_toggle")
      rev_cmd = true
      return
    elseif not reverse and rev_cmd then
      command_once("sim/engines/thrust_reverse_toggle")
      rev_cmd = false
      return
    end

    if not throttle_changed() then
      return
    end
    
    if reverse then
      local t1 = clip((dr_throttle1 - THROTTLE1_REVERSE) / (1.0 - THROTTLE1_REVERSE))
      local t2 = clip((dr_throttle2 - THROTTLE2_REVERSE) / (1.0 - THROTTLE2_REVERSE))
      dr_lever1 = 20.0 + (65.0 - 20.0) * t1
      dr_lever2 = 20.0 + (65.0 - 20.0) * t2
    else
      local t1 = clip((THROTTLE1_IDLE - dr_throttle1) / THROTTLE1_IDLE)
      local t2 = clip((THROTTLE2_IDLE - dr_throttle2) / THROTTLE2_IDLE)
      dr_lever1 = throttle_t_to_lever(t1)
      dr_lever2 = throttle_t_to_lever(t2)
    end
  end

  do_every_frame("a320_throttle_run()")

  logMsg("A320Helper: ok.")
end