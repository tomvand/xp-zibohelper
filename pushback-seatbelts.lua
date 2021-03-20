local seatbelts_cmd = "sim/systems/seatbelt_sign_toggle"

if PLANE_ICAO == "B738" then
  seatbelts_cmd = "zibohelper/seatbelts_toggle"
elseif PLANE_ICAO == "A320" then
  seatbelts_cmd = "a320helper/seatbelts_toggle"
end

local PUSHBACK_STATE_CONNECT = 0
local PUSHBACK_STATE_START = 1
local PUSHBACK_STATE_DONE = 2
local pushback_state = PUSHBACK_STATE_CONNECT

local function is_seatbelts_on()
  if get("sim/cockpit2/switches/fasten_seat_belts") > 0.5 then
    return true
  elseif get("laminar/B738/toggle_switch/seatbelt_sign_pos") > 1.5 then
    return true
  elseif get("a320/Overhead/LightBelts") > 1.5 then
    return true
  end
  return false
end

function pushback_seatbelts_begin()
  if pushback_state < PUSHBACK_STATE_DONE and not is_seatbelts_on() then
    command_once(seatbelts_cmd)
  elseif pushback_state == PUSHBACK_STATE_CONNECT then
    command_once("BetterPushback/connect_first")
    pushback_state = PUSHBACK_STATE_START
  elseif pushback_state == PUSHBACK_STATE_START then
    command_once("BetterPushback/start")
    pushback_state = PUSHBACK_STATE_DONE
  else
    command_once(seatbelts_cmd)
  end
end
create_command("misc/pushback_seatbelts_toggle", "Start pushback, toggle seatbelts",
    "pushback_seatbelts_begin()", "", "")