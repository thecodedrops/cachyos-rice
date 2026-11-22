---
Tags:
Created: 2026-05-25
---
Waking from sleep, Network Manager would hang - so I created a script to restart it clean on wake:

```bash
# /usr/lib/systemd/system-sleep/ath11k-resume
#!/bin/sh
case "$1" in
  post)
    /usr/bin/modprobe -r ath11k_pci 2>/dev/null
    /usr/bin/modprobe ath11k_pci
    /usr/bin/systemctl restart NetworkManager
    ;;
esac
```