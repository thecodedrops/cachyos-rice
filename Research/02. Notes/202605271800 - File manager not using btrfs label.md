---
Tags:
Created: 2026-05-27
---
##### File Manager (Nautilus/Dolphin)
Dedicated storage partition (in BTRFS) would not appear in File Manager, requiring a manual fix.

```
# /etc/fstab
...
UUID=<Storage-UUID> /mnt/storage   btrfs   defaults,noatime,compress=zstd:1,x-gvfs-show 0 0
...
  ```

Setting up default folders (Documents, Pictures etc.) requires a shell command:
```bash
xdg-user-dirs-update
```