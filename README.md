# xp-zibohelper
LUA helper script for Zibo 737

Functions:
- Flap lever display
- Flap lever hysteresis for noisy joystick axis. Note: requires FLAP_AXIS_INDEX to be set manually. Will remove joystick assignment if necessary.

Commands
- `zibohelper/fd_toggle_both_cpt`: Toggle both flight directors. Captain's side is MA.
- `zibohelper/ap_at_disco`: Disconnect both autopilot and autothrottle. (TODO: cancel annunciators)
- `zibohelper/speedbrake_arm_toggle`: Arm or retract speedbrake.
