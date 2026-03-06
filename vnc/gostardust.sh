#!/bin/sh

# https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/using_the_desktop_environment_in_rhel_8/accessing-the-desktop-remotely_using-the-desktop-environment-in-rhel-8#disabling-encryption-in-gnome-vnc_remotely-accessing-the-desktop-as-a-single-user
#
# https://github.com/LibVNC/x11vnc/?tab=readme-ov-file#readme
#
# https://unix.stackexchange.com/questions/659362/how-to-generate-correctly-a-new-xauthority-file-for-a-display-missing-it-witho
#
# Use ssh -f for background, and ssh -t for pseudo-terminal


# One-step:

ssh -f -L 5907:localhost:5907 io@stardust 'export WLR_BACKENDS=headless && export WLR_LIBINPUT_NO_DEVICES=1 && export WAYLAND_DISPLAY=wayland-1 && wayvnc localhost 5907' && sleep 2; vncviewer localhost:5907
echo "\n\n========================"
echo "Final step if necessary:"
echo "vncviewer localhost:5907"
echo "========================\n\n"
