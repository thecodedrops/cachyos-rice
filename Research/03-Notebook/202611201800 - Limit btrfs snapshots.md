---
Tags:
Created: 2026-11-20
---
#### Limiting BTRFS snapshots

```conf
# Edit /etc/snapper/configs/root

# Fraction or absolute size of the filesystems space the snapshots may use
SPACE_LIMIT="0.5"

# Fraction or absolute size of the filesystems space that should be free
FREE_LIMIT="0.2"

# Run daily number cleanup
NUMBER_CLEANUP="yes"

# Limit for number cleanup
NUMBER_MIN_AGE="1800"
NUMBER_LIMIT="20"
NUMBER_LIMIT_IMPORTANT="10"

# Create hourly snapshots
TIMELINE_CREATE="no"

# Cleanup hourly snapshots after some time
TIMELINE_CLEANUP="yes"

# Limits for timeline cleanup
TIMELINE_MIN_AGE="1800"
TIMELINE_LIMIT_HOURLY="5"
TIMELINE_LIMIT_DAILY="7"
TIMELINE_LIMIT_WEEKLY="0"
TIMELINE_LIMIT_MONTHLY="0"
TIMELINE_LIMIT_YEARLY="0"
```