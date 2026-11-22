---
Tags:
Created: 2026-11-22
---
##### Unlocking `gnome-keyring` on login

Solves Visual Studio Code asking for keyring password the first time it's opened.

1. Remove all previously created keyring configurations.
   ```bash
   rm ~/.local/share/keyrings/*
   ```

2. Ensure that `.zprofile` does not contain a manual keyring daemon launch.
   ```bash
   # Remove this if previously set
   # eval "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
   ```

3. Edit `/etc/pam.d/login` to add the following lines (the order matters).
   ```toml
   #%PAM-1.0

   # Pre-existing auth lines...
   # E.g. auth       include      system-local-login
   # Below them, add:
   auth       optional     pam_gnome_keyring.so

   # Pre-existing account lines...
   # E.g. account    include      system-local-login

   # Pre-existing session lines...
   # E.g. session    include      system-local-login
   # Below them, add:
   session    optional     pam_gnome_keyring.so auto_start

   # Pre-existing password lines...
   # E.g. password   include      system-local-login
   # Below them, add:
   password   optional     pam_gnome_keyring.so use_authtok
   ```

4. Reboot.
