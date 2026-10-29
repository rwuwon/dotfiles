#!/bin/bash
SERVICE="swayidle"
if pgrep -x "$SERVICE" >/dev/null
then
    echo "$SERVICE is running; killing"
    pkill swayidle
else
    echo "$SERVICE stopped; starting"
    swayidle -w timeout 10 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' &
fi

# Source: https://www.cyberciti.biz/faq/bash-check-if-process-is-running-or-notonlinuxunix/#:~:text=Bash%20shell%20script%20to%20check%20running%20process
#
# Corresponding sway config line:
# bindsym Ctrl+$mod+d exec ~/nix/scripts/displaytoggle.sh
