if PLANE_ICAO == "B738" then
    dataref("dr_fd_cpt", "laminar/B738/switches/autopilot/fd_ca", "writeable")
    dataref("dr_fd_fo", "laminar/B738/switches/autopilot/fd_fo", "writeable")

    -- Toggle both FDs
    logMsg("ZiboHelper: setting up FD toggle command...")
    function fd_toggle()
        if dr_fd_cpt == 0 then
            dr_fd_cpt = 1
            dr_fd_fo = 1
        else
            dr_fd_fo = 0
            dr_fd_cpt = 0
        end
    end
    create_command("zibohelper/fd_toggle_both_cpt",
                   "Toggle both flight directors (CPT as MA)",
                   "fd_toggle()",
                   "",
                   "")
    logMsg("ZiboHelper: ok.")
end