#!/bin/sh

xset r rate 250 40

# https://wiki.archlinux.org/index.php/Libinput#Via_xinput
# Reverse scroll direction
# Handled instead by /etc/X11/xorg.conf.d/30-touchpad.conf
# https://wiki.archlinux.org/index.php/Libinput#Change_touchpad_sensitivity
#xinput set-prop 11 287 1

# https://wiki.archlinux.org/index.php/Display_Power_Management_Signaling
# Use xset q to query
xset dpms 300 300 300
xset s 300 300
