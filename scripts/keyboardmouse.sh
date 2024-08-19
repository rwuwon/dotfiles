#!/bin/sh

# This script has mostly been replaced with ~/.profile and /etc/X11/xorg.conf.d
# xset r rate remains for desktop keyboard hot-plugging

# Previous default of 250 30 was fine; 40 is faster
xset r rate 250 40

# Mouse accel under Fedora/Gnome is handled via Gnome conf
#xset m 0 0

# https://wiki.archlinux.org/index.php/Libinput#Via_xinput
# Reverse scroll direction
# Handled instead by /etc/X11/xorg.conf.d/30-touchpad.conf
# https://wiki.archlinux.org/index.php/Libinput#Change_touchpad_sensitivity
#xinput set-prop 11 287 1

# This will change if the USB legacy support setting is changed in BIOS
# type "xinput list" to set the right mouse prop and then:
# xinput list-props 'Kingsis Peripherals ZOWIE Gaming mouse'|grep Coordinate
# 9 is id for mouse, 154 is Coordinate Transformation Matrix for mouse

# 2 is double speed for 400 dpi mouse setting. Works well at 1080p.
#xinput set-prop 9 154 2 0 0 0 2 0 0 0 1 # speed for red light
#xinput set-prop 9 154 0 0 0 0 0 0 0 0 1 # speed for pink light
# source: https://wiki.ubuntu.com/X/InputCoordinateTransformation

# https://wiki.archlinux.org/index.php/Display_Power_Management_Signaling
# Use xset q to query
#xset dpms 300 300 300
#xset s 300 300
