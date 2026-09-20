#!/bin/sh

# https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/using_the_desktop_environment_in_rhel_8/accessing-the-desktop-remotely_using-the-desktop-environment-in-rhel-8#disabling-encryption-in-gnome-vnc_remotely-accessing-the-desktop-as-a-single-user
#
# https://github.com/LibVNC/x11vnc/?tab=readme-ov-file#readme
#
# https://unix.stackexchange.com/questions/659362/how-to-generate-correctly-a-new-xauthority-file-for-a-display-missing-it-witho
#
# Use ssh -f for background, and ssh -t for pseudo-terminal


# One-step:
echo "ssh -f -L 5907:localhost:5907 io@stardust 'pkill wayvnc && export WLR_BACKENDS=headless && export WLR_LIBINPUT_NO_DEVICES=1 && export WAYLAND_DISPLAY=wayland-1 && wayvnc 172.16.7.7 5907' && sleep 2; vncviewer 172.16.7.7:5903 -MenuKey=Home"
echo "======================================\n\n"

ssh -f -L 5907:localhost:5907 io@stardust 'export WLR_BACKENDS=headless && export WLR_LIBINPUT_NO_DEVICES=1 && export WAYLAND_DISPLAY=wayland-1 && wayvnc 172.16.7.7 5907' && sleep 2; vncviewer 172.16.7.7:5907 -MenuKey=Home
echo "\n\n======================================"
echo "Final step if necessary:"
echo "vncviewer 172.16.7.7:5907 -MenuKey=Home -FullScreen=0 -CompressLevel=9 -QualityLevel=2 -LowColorLevel=0 -AutoSelect=0 #stardust"
echo "======================================\n\n"
