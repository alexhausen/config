#!/usr/bin/env bash
xsetroot -solid black &
/usr/bin/dbus-launch --sh-syntax
gnome-screensaver &
gnome-keyring-daemon &
gnome-settings-daemon &
volumeicon &
nm-applet&
dropbox start &
rocketchat &
skype &
~/projects/examples/bash/set-keyboard-layout-per-window.sh &
exec /usr/local/bin/awesome
