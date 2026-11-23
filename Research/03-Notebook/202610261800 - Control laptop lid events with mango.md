---
Tags:
Created: 2026-10-26
---

| Event             | Condition                           | Sleep/Wake | Screen         |
| :---------------- | :---------------------------------- | :--------- | :------------- |
| Laptop Lid Closed | Default                             | Sleep      | Turn off EDP-1 |
| --                | Connected to external power or dock | Ignore     | Turn off EDP-1 |
| Laptop Lid Opened | --                                  | Wake       | Turn on EDP-1  |

Edit **systemd-logind**
```bash
sudoedit /etc/systemd/logind.conf
```

  Ensure the following configurations are set.
  ```toml
  [Login]
  # Sets default behaviour on lid close/open as suspend/wake
  HandleLidSwitch=suspend
  
  # Overrides default lid behaviour to not suspend when
  # External Power or Dock detected
  HandleLidSwitchExternalPower=ignore
  HandleLidSwitchDocked=ignore
  ```

Edit Mango configurations to enable/disable laptop screen
```bash
micro ~/.config/mango/config.conf
```

Set the following commands.
```toml
# Disable screen when lid is closed
switchbind=fold,spawn,wlr-randr --output eDP-1 --off

# Enable screen when lid is opened
switchbind=unfold,spawn,wlr-randr --output eDP-1 --on
```