#!/bin/sh

# Post macOS Monterey -> Debian change:

ssh -f -L 5903:localhost:5903 io@newhorizons 'export WLR_BACKENDS=headless && export WLR_LIBINPUT_NO_DEVICES=1 && export WAYLAND_DISPLAY=wayland-1 && wayvnc localhost 5907' && sleep 2; vncviewer localhost:5903
echo "\n\n========================"
echo "Final step if necessary:"
echo "vncviewer localhost:5903"
echo "========================\n\n"
