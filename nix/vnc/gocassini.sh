#!/bin/sh

# https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/using_the_desktop_environment_in_rhel_8/accessing-the-desktop-remotely_using-the-desktop-environment-in-rhel-8#disabling-encryption-in-gnome-vnc_remotely-accessing-the-desktop-as-a-single-user
#
# https://github.com/LibVNC/x11vnc/?tab=readme-ov-file#readme
#
# https://unix.stackexchange.com/questions/659362/how-to-generate-correctly-a-new-xauthority-file-for-a-display-missing-it-witho
#
# Use ssh -f for background, and ssh -t for pseudo-terminal


# One-step:
echo "========================================================="
echo "ssh -f -L 5902:localhost:5902 io@cassini 'x11vnc -allow 127.0.0.1,172.16.2. -autoport 5902 -display :0 -forever -noxdamage -repeat -nowf -nevershared -nopw' && sleep 2; vncviewer localhost:5902 -MenuKey=Home -FullScreen=0"
echo "=========================================================\n"

ssh -f -L 5902:localhost:5902 io@cassini 'x11vnc -allow 127.0.0.1,172.16.2. -autoport 5902 -display :0 -forever -noxdamage -repeat -nowf -nevershared -nopw' && sleep 2; vncviewer localhost:5902 -MenuKey=Home -FullScreen=0
echo "\n========================================================="
echo "Reconnect using one of:"
echo "vncviewer localhost:5902 -MenuKey=Home -FullScreen=0 -AutoSelect=0 -CompressLevel=9 -QualityLevel=2 -LowColorLevel=0 #cassini"
echo "vncviewer localhost:5902 -MenuKey=Home -FullScreen=0 #cassini"
echo "vncviewer 172.16.2.2:5902 -MenuKey=Home -FullScreen=0 -AutoSelect=0 -CompressLevel=9 -QualityLevel=2 -LowColorLevel=0 #cassini"
echo "vncviewer 172.16.2.2:5902 -MenuKey=Home -FullScreen=0 #cassini"
echo "=========================================================\n"

viewcassini.sh
