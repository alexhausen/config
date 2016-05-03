#!/usr/bin/env bash
xsetroot -solid black &
gnome-screensaver &
gnome-settings-daemon &
gnome-power-manager &
exec /usr/local/bin/awesome
