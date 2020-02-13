-- Allow changing of memorized views with the mousewheel with the cursor placed
-- at the edge of the screen. Click at the edge of the screen to return to the center view.

BORDER_SIZE = 5 -- px

-- default views
local view_commands = {
    "sim/view/quick_look_0",
    "sim/view/quick_look_1",
    "sim/view/quick_look_2",
    "sim/view/quick_look_3",
    "sim/view/quick_look_4",
    "sim/view/quick_look_5",
    "sim/view/quick_look_6",
    "sim/view/quick_look_7",
    "sim/view/quick_look_8",
    "sim/view/quick_look_9"
}
local center_view = 6

-- aircraft-specific views
if PLANE_ICAO == "B738" then
    view_commands = {
        --"sim/view/quick_look_0", -- EFB
        "sim/view/quick_look_3", -- radio stack
        "sim/view/quick_look_2", -- CDU
        "sim/view/quick_look_5", -- MCP
        "sim/view/quick_look_4", -- CPT view
        "sim/view/quick_look_8", -- Overhead
        "sim/view/quick_look_9"  -- AFT Overhead
    }
    center_view = 4
end

local current_view = center_view

-- mousewheel function
function on_mousewheel()
    if (MOUSE_X < BORDER_SIZE) or 
       (MOUSE_X > SCREEN_WIDTH - BORDER_SIZE) or
       (MOUSE_Y < BORDER_SIZE) or
       (MOUSE_Y > SCREEN_HIGHT - BORDER_SIZE) then
        RESUME_MOUSE_WHEEL = true
        current_view = current_view + MOUSE_WHEEL_CLICKS
        if current_view < 1 then current_view = 1; return; end
        if current_view > table.getn(view_commands) then current_view = table.getn(view_commands); return; end
        command_once(view_commands[current_view])
        logMsg(view_commands[current_view])
    end
end
do_on_mouse_wheel("on_mousewheel()")

-- mouse click function (center view)
function on_mouseclick()
    if (MOUSE_X < BORDER_SIZE) or 
       (MOUSE_X > SCREEN_WIDTH - BORDER_SIZE) or
       (MOUSE_Y < BORDER_SIZE) or
       (MOUSE_Y > SCREEN_HIGHT - BORDER_SIZE) then
        if MOUSE_STATUS == "down" then
            RESUME_MOUSE_CLICK = true
            current_view = center_view
            command_once(view_commands[current_view])
            logMsg(view_commands[current_view])
        end
    end
end
do_on_mouse_click("on_mouseclick()")