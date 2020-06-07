if PLANE_ICAO == "B738" then
    dataref("dr_fd_cpt", "laminar/B738/autopilot/pfd_fd_cmd")
    dataref("dr_fd_fo", "laminar/B738/autopilot/pfd_fd_cmd_fo")

    -- Toggle both FDs
    logMsg("ZiboHelper: setting up FD toggle command...")
    function fd_toggle()
        if dr_fd_cpt == 0 then
            command_once("laminar/B738/autopilot/flight_director_toggle")
            if dr_fd_fo == 0 then
                command_once("laminar/B738/autopilot/flight_director_fo_toggle")
            end
        else
            if dr_fd_fo == 1 then
                command_once("laminar/B738/autopilot/flight_director_fo_toggle")
            end
            command_once("laminar/B738/autopilot/flight_director_toggle")
        end
    end
    create_command("zibohelper/fd_toggle_both_cpt",
                   "Toggle both flight directors (CPT as MA)",
                   "fd_toggle()",
                   "",
                   "")
    logMsg("ZiboHelper: ok.")
end