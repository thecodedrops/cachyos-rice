#!/bin/sh

# Start the desktop portal for screensharing/compatibility
/usr/lib/xdg-desktop-portal-wlr &

# Set the wallpaper using swaybg
quickshell -p $HOME/.config/quickshell/Shell.qml &