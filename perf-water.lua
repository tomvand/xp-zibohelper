dataref("dr_cloud_tops0", "sim/weather/cloud_tops_msl_m[0]", "readonly")
local time_prev = 0
function perf_water()
    if not dr_cloud_tops0 then
      logMsg("perftweaks: waiting for cloud_base_msl_m to become available...")
      return
    end
    local time = os.clock()
    -- Disable fft water above first cloud level or FL100 and < 25fps
    if (ELEVATION > dr_cloud_tops0 or ELEVATION > 3333) and ((time - time_prev) > 0.04) then
      set("sim/private/controls/reno/draw_fft_water", 0)
    else
      set("sim/private/controls/reno/draw_fft_water", 1)
    end
    time_prev = time
end
do_sometimes("perf_water()")
