#!/bin/sh

#xset m 0 0
xset r rate 250 30
xset dpms 2400 2460 2520
xset s off

# This will change if the USB legacy support setting is changed in BIOS
# type "xinput list" to set the right mouse prop and then:
# xinput list-props 'Kingsis Peripherals ZOWIE Gaming mouse'|grep Coordinate
# 9 is id for mouse, 173 is Coordinate Transformation Matrix for mouse
# 2 is double speed for 400 dpi mouse setting. Works well at 1080p.
xinput set-prop 9 173 2 0 0 0 2 0 0 0 1
# source: https://wiki.ubuntu.com/X/InputCoordinateTransformation
