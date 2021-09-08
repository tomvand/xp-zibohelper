xpdr_wxr_tara = nil
xpdr_wxr_altoff = nil
xpdr_wxr_stdby = nil

local xpdr_wxr_initialized = false

local function xpdr_wxr_init()
  if xpdr_wxr_initialized then
    return true
  end

  if PLANE_ICAO == "A320" then
    local xplm_xpdr_mode = XPLMFindDataRef("a320/Pedestal/ATC_Mode")
    local xplm_wxr = XPLMFindDataRef("a320/Pedestal/WR_POWER")
    if xpdr_wxr_tara == nil then
      if xplm_wxr ~= nil then
        xpdr_wxr_tara = function()
          command_once("a320helper/transponder/tara")
          XPLMSetDataf(xplm_wxr, 0)
          XPLMSetDataf(xplm_xpdr_mode, 2)
        end
      end
    elseif xpdr_wxr_altoff == nil then
      xpdr_wxr_altoff = function()
        command_once("a320helper/transponder/stdby")
        XPLMSetDataf(xplm_wxr, 1)
        XPLMSetDataf(xplm_xpdr_mode, 2)
      end
    elseif xpdr_wxr_stdby == nil then
      xpdr_wxr_stdby = function()
        command_once("a320helper/transponder/stdby")
        XPLMSetDataf(xplm_wxr, 1)
        XPLMSetDataf(xplm_xpdr_mode, 0)
      end
    else
      xpdr_wxr_initialized = true
    end
  elseif PLANE_ICAO == "B738" then
    local xplm_wxr = XPLMFindDataRef("laminar/B738/EFIS/EFIS_wx_on")
    if xpdr_wxr_tara == nil then
      if xplm_wxr then
        xpdr_wxr_tara = function()
          command_once("laminar/B738/knob/transponder_tara")
          if XPLMGetDataf(xplm_wxr) <= 0.5 then
            command_begin("laminar/B738/EFIS_control/capt/push_button/wxr_press")
            command_end("laminar/B738/EFIS_control/capt/push_button/wxr_press")
          end
        end
      end
    elseif xpdr_wxr_altoff == nil then
      xpdr_wxr_altoff = function()
        command_once("laminar/B738/knob/transponder_altoff")
        if XPLMGetDataf(xplm_wxr) > 0.5 then
          command_once("laminar/B738/EFIS_control/capt/push_button/wxr_press")
        end
      end
    elseif xpdr_wxr_stdby == nil then
      xpdr_wxr_stdby = function()
        command_once("laminar/B738/knob/transponder_stby")
        if XPLMGetDataf(xplm_wxr) > 0.5 then
          command_once("laminar/B738/EFIS_control/capt/push_button/wxr_press")
        end
      end
    else
      xpdr_wxr_initialized = true
    end
  else
  end
  return false
end

function xpdr_wxr_on_frame()
  if not xpdr_wxr_init() then
    return
  end
end
do_every_frame("xpdr_wxr_on_frame()")

local press_time = 0.0
local HOLD_TIME = 0.5

function xpdr_wxr_press()
  press_time = os.clock()
end

function xpdr_wxr_hold()
  if press_time and os.clock() > (press_time + HOLD_TIME) then
    xpdr_wxr_stdby()
    press_time = 0.0
  end
end

function xpdr_wxr_release()
  if os.clock() <= (press_time + HOLD_TIME) then
    xpdr_wxr_altoff()
    press_time = 0.0
  end
end

create_command("luahelper/xpdr_wxr/stdby_altoff",
"Transponder ALT OFF/STDBY, WXR off",
"xpdr_wxr_press()",
"xpdr_wxr_hold()",
"xpdr_wxr_release()"
)

create_command("luahelper/xpdr_wxr/tara",
"Transponder TA/RA, WXR on",
"", "xpdr_wxr_tara()", ""
)
