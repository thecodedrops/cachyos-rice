# Autostart Mango on TTY1
# Not needed if a Display Manager (like SDDM) is set up
if [[ -z $WAYLAND_DISPLAY && $(tty) == /dev/tty1 ]]; then
	dbus-update-activation-environment --systemd --all
    exec mango
fi

# GNOME Keyring
# eval "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
