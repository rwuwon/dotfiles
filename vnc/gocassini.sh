#!/bin/sh

# https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/using_the_desktop_environment_in_rhel_8/accessing-the-desktop-remotely_using-the-desktop-environment-in-rhel-8#disabling-encryption-in-gnome-vnc_remotely-accessing-the-desktop-as-a-single-user
#
# https://github.com/LibVNC/x11vnc/?tab=readme-ov-file#readme
#
# https://unix.stackexchange.com/questions/659362/how-to-generate-correctly-a-new-xauthority-file-for-a-display-missing-it-witho
#
# Use ssh -f for background, and ssh -t for pseudo-terminal


# One-step:

ssh -f -L 5902:localhost:5902 io@cassini 'x11vnc -localhost -autoport 5902 -display :0 -forever -noxdamage -repeat -nowf' && sleep 2; vncviewer localhost:5902
echo "\n\n========================"
echo "Final step if necessary:"
echo "vncviewer localhost:5902"
echo "========================\n\n"
