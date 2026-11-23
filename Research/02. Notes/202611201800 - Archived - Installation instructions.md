---
Tags:
  - Archive
Created: 2026-11-20
---
> Archived (Deprecated 2026.11.20)

> [!WARNING] Archived
> Instructions have been deprecated since 2026.11.20

### Installation Instructions 

Symlink the following with "./*" paths being relative from the script's pwd:​‌
- `./fastfetch` → `$HOME/.config/fastfetch`
- `./foot` → `$HOME/.config/foot`
- `./mako` → `$HOME/.config/mako`
- `./mango` → `$HOME/.config/mango`
- `./mpv` → `$HOME/.config/mpv`
- `./shell` → `$HOME/.config/quickshell`
- `./zsh` → `$HOME/.config/zsh`
- `./themes/starship/starship.toml` → `$HOME/.config/starship.toml`
- `./themes/gtk/catppuccin-mocha-mauve` → `$HOME/.local/share/themes/catppuccin-mocha-mauve`
- `./themes/gtk/catppuccin-mocha-mauve/gtk-3.0` → `$HOME/.config/gtk-3.0`
- `./themes/gtk/catppuccin-mocha-mauve/gtk-4.0` → `$HOME/.config/gtk-4.0`
- `./themes/micro/catppuccin.micro` → `$HOME/.config/micro/colorschemes/catppuccin.micro`
- `./themes/micro/settings.json` → `$HOME/.config/micro/settings.json`

Copy the following:
- `./themes/xcursor/BibataModernIce` → `/usr/share/icons/BibataModernIce`
- `./themes/xcursor/GoogleDotBlue` → `/usr/share/icons/GoogleDotBlue`
- `./themes/sddm` → `/usr/share/sddm/themes/material`
- `./themes/grub/catppuccin` → `/usr/share/grub/themes/catppuccin`
- `./themes/plymouth/cross-hud` → `/usr/share/plymouth/themes/cross-hud`

**Plymouth (Splash Screen)**
```bash
# Prerequisites:
# Plymouth theme folder has been copied to your system

# Command: sudo plymouth-set-default-theme -R <theme-folder-name>
sudo plymouth-set-default-theme -R cross-hud
sudo mkinitcpio -P
```

**GRUB**
```bash
# Prerequisites:
# 1. GRUB theme folder has been copied to your system
# 2. Content of ./themes/grub/grub file is copied to /etc/default/grub

sudo grub-mkconfig -o /boot/grub/grub.cfg
```

**SDDM**
```conf
# Edit file at /etc/sddm.conf

[Theme]
# Configuration: Current=<theme-name>
Current=material
```