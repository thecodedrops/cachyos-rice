### Test Scripts

Launching Quickshell in DEBUG mode to get detailed logs.
```bash
# Launch in DEBUG mode
DEBUG=1 quickshell -p ~/.config/shell/Shell.qml
```

Screen utilities via `wlr-randr`
```bash
wlr-randr --output eDP-1 --off
wlr-randr --output eDP-1 --on --pos 0,0 --mode 1920x1080 --output HDMI-A-1 --on --pos 0,0 --mode 1920x1080
```

Idling utilities via `swayidle`
```bash
swayidle -w \                                                          
  timeout 5 'brightnessctl --save --exponent=4 set 10%' \
    resume 'brightnessctl --restore' \
  timeout 10 '$HOME/.config/mango/scripts/screen-ctl.sh --sleep' \
    resume '$HOME/.config/mango/scripts/screen-ctl.sh --wake'
```

Symbolic Linking
```bash
# ln -sfn detect "duplicate linking" and skips
ln -sf <source-path> <target-path>
ln -sf $HOME/.local/apps/obsidian.desktop ./.local/share/applications/obsidian.desktop
```

Simulate notifications
```bash
notify-send -i discord -a "Discord" "Jane Doe" "Hey\n Are we still jumping on that raid tonight?"; /
sleep 2; /
notify-send -u critical -i dialog-warning -a "System Monitor" "Thermal Warning" "CPU temperature has exceeded 85°C"; /
sleep 2; /
notify-send -h string:transient:true -i Security "YubiKey" "Touch your security key..."; /
sleep 2; /
notify-send -h string:x-canonical-private-synchronous:volume -h int:value:40 -i audio-volume-medium "Volume" "40%"; sleep 2; /
notify-send -h string:x-canonical-private-synchronous:volume -h int:value:65 -i audio-volume-high "Volume" "65%"
```

Simulate privilege
```bash
pkexec echo "Polkit privileged"
```