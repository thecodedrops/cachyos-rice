This is not your everyday rice - this is **Basmati** rice 🍚

---

### Structure
```bash
(Root)/
├── Packages/
│   # Configurations the setup relies on
│   ├── mango
│   └── ...
├── Quickshell/
│   # Shell code and project
│   └── ...
├── Scripts/
│   # Standalone bash scripts for my convenience
│   └── ...
├── Themes/
│   # Theme files for copy (e.g. GTK, Grub/Plymouth etc.)
│   └── ...
├── Wallpapers/
│   # (Optional folder) Default setup wallpapers
│   └── ...
├── Research/
│   # Research or specific notes behind actions/decisions
│   └── ...
└── README.md
```

---

### Packages
For some of my utilities, the following packages are required:

| Utility | Packages |
| :------ | :------- |
| ZSH | `zsh-history-substring-search` `zsh-syntax-highlighting` |
| Fonts | `ttf-jetbrains-mono-nerd` |
| Keyring | `gnome-keyring` |
| Telegram | `telegram-desktop` with themes from https://github.com/catppuccin/telegram |

---

### Roadmap (Improvements)

#### Process management
The shell launches many processes - some of which stay alive in the background (e.g. `swaybg`).

**Goal**: Clearer visualization, monitoring and tracking of processes managed by the shell, with ability to stop/pause/start on demand.
> E.g. Changing a wallpaper would require stopping/killing the ongoing `swaybg` process, and starting a new one.

- [ ] Keep track of running processes as reference objects.
- [ ] Visualize processes running under the shell.
- [ ] Stop/Pause/Start specific processes on demand.

#### Buttons and clickables
Too many files now provide for button component: `Clickable`, `ClickableWithIcon`, `ClickableIcon`, `ClickableButton`.

**Goal**: Clean up redundant button components, using only some generic versions.
- [ ] Review use of `ClickableWithAccent` - it might actually be fit to replace all buttons.