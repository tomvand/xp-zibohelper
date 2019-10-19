# xp-zibohelper
LUA helper script for Zibo 737

Functions:
- Flap lever display
- Flap lever hysteresis for noisy joystick axis. Note: requires FLAP_AXIS_INDEX to be set manually. Will remove joystick assignment if necessary.
- Taxi in flow. The taxi-in flow is automatically started when the flaps are retracted (with gear down and ground speed < 60kt).

Commands
- `zibohelper/fd_toggle_both_cpt`: Toggle both flight directors. Captain's side is MA.
- `zibohelper/ap_at_disco`: Disconnect both autopilot and autothrottle. Push annunciators.
- `zibohelper/speedbrake_arm_toggle`: Arm or retract speedbrake.
