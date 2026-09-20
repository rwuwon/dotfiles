#!/bin/sh

# https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/using_the_desktop_environment_in_rhel_8/accessing-the-desktop-remotely_using-the-desktop-environment-in-rhel-8#disabling-encryption-in-gnome-vnc_remotely-accessing-the-desktop-as-a-single-user

# 1. On the server end:
echo "x11vnc -localhost -autoport 5901 -display :0 -forever -noxdamage -repeat -nowf -o ~/.config/tigervnc/x11vnc.log"
x11vnc -localhost -autoport 5901 -display :0 -forever -noxdamage -repeat -nowf -o ~/.config/tigervnc/x11vnc.log

# It needs to be 5900:localhost:5900 remotehost - NOT REMOTEHOST REMOTEHOST!
# ssh -L 5900:localhost:5900 io@cassini -N -T -f && vncviewer localhost



# cassini (local), stardust (remote)
#!/bin/sh
echo "export WLR_BACKENDS=headless && export WLR_LIBINPUT_NO_DEVICES=1 && export WAYLAND_DISPLAY=wayland-1"
export WLR_BACKENDS=headless && export WLR_LIBINPUT_NO_DEVICES=1 && export WAYLAND_DISPLAY=wayland-1

echo "echo $WLR_BACKENDS $WLR_LIBINPUT_NO_DEVICES $WAYLAND_DISPLAY"
echo $WLR_BACKENDS $WLR_LIBINPUT_NO_DEVICES $WAYLAND_DISPLAY

echo "wayvnc -C ~/.config/wayvnc/config"
wayvnc -C ~/.config/wayvnc/config

# https://lemmy.sdf.org/post/37907763
