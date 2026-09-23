#!/bin/sh

# Post macOS Monterey -> Debian change:
echo "ssh -f -L 5903:localhost:5903 io@newhorizons 'pkill wayvnc ; \
export WLR_BACKENDS=headless && \
export WLR_LIBINPUT_NO_DEVICES=1 && \
export WAYLAND_DISPLAY=wayland-1 && \
wayvnc -v 172.16.3.3 5903' && \
sleep 2 && \
vncviewer 172.16.3.3:5903 -MenuKey=Home -FullScreen=0"

echo "=========================================================\n"

ssh -f -L 5903:localhost:5903 io@newhorizons 'pkill wayvnc ; \
export WLR_BACKENDS=headless && \
export WLR_LIBINPUT_NO_DEVICES=1 && \
export WAYLAND_DISPLAY=wayland-1 && \
wayvnc -v 172.16.3.3 5903' && \
sleep 2 && \
vncviewer 172.16.3.3:5903 -MenuKey=Home -FullScreen=0

echo "\n========================================================="
echo "Reconnect using one of:"
echo "vncviewer 172.16.3.3:5903 -MenuKey=Home -FullScreen=0 -AutoSelect=0 -CompressLevel=9 -QualityLevel=2 -LowColorLevel=0 #newhorizons"
echo "vncviewer 172.16.3.3:5903 -MenuKey=Home -FullScreen=0 #newhorizons"
echo "viewnewhorizons.sh"
echo "---------------------------------------------------------"
echo "Troubleshooting:"
echo "ssh -t -L 5903:172.16.3.3:5903 io@newhorizons 'pkill wayvnc'"
echo "========================================================="

viewnewhorizons.sh
