#!/bin/sh

# https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/using_the_desktop_environment_in_rhel_8/accessing-the-desktop-remotely_using-the-desktop-environment-in-rhel-8#disabling-encryption-in-gnome-vnc_remotely-accessing-the-desktop-as-a-single-user
#
# https://github.com/LibVNC/x11vnc/?tab=readme-ov-file#readme
#
# https://unix.stackexchange.com/questions/659362/how-to-generate-correctly-a-new-xauthority-file-for-a-display-missing-it-witho
#
# Use ssh -f for background, and ssh -t for pseudo-terminal


# One-step:

ssh -f -L 5905:localhost:5905 io@nix "export WLR_BACKENDS=headless && export WLR_LIBINPUT_NO_DEVICES=1 && export WAYLAND_DISPLAY=wayland-1 && wayvnc localhost 5905" && sleep 2; vncviewer localhost:5905
echo "\n\n========================"
echo "Final step if necessary:"
echo "vncviewer localhost:5905"
echo "========================\n\n"


# For X11 VMs:
# sway to i3 with Xauthority auth set
# -auth tip: ps wwwwaux | grep auth

#ssh -f -L 5905:localhost:5905 io@nix 'x11vnc -localhost -autoport 5905 -display :0 -forever -noxdamage -repeat -nowf -auth /run/user/1000/gdm/Xauthority' && sleep 2; vncviewer localhost:5905
