#!/bin/bash

TARGET_BINARY="$HOME/.local/apps/hyprfm/0.7.0/AppRun"

ALLOWED_DIRS=(
  ".config"
  ".local"
  "Desktop"
  "Documents"
  "Downloads"
  "Music"
  "Pictures"
  "Projects"
  "Videos"
)

BWRAP_ARGS=(
  --unshare-user
  --unshare-net
  --uid $(id -u)
  --gid $(id -g)
  --dev-bind /dev /dev
  --proc /proc
  --bind /sys /sys
  --ro-bind /usr /usr
  --ro-bind /lib64 /lib64
  --ro-bind /bin /bin
  --tmpfs "$HOME"
)

for dir in "${ALLOWED_DIRS[@]}"; do
  if [ -e "$HOME/$dir" ]; then
    BWRAP_ARGS+=(--bind "$HOME/$dir" "$HOME/$dir")
  fi
done

BWRAP_ARGS+=(
  --bind /media /media
  --bind /mnt /mnt
  --bind /run/media /run/media
  --bind /run/user/$(id -u) /run/user/$(id -u)
  --setenv DISPLAY "$DISPLAY"
  --setenv WAYLAND_DISPLAY "$WAYLAND_DISPLAY"
  --setenv XDG_RUNTIME_DIR "/run/user/$(id -u)"
  --ro-bind /run/udev /run/udev
  --bind /run/dbus/system_bus_socket /run/dbus/system_bus_socket
)

# Pass all script arguments ("$@") directly to hyprfm
exec bwrap "${BWRAP_ARGS[@]}" "$TARGET_BINARY" "$@"
