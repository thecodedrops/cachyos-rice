# Heading 1
## Heading 2
### Heading 3

#### Heading 4

##### Process management
The shell launches many processes - some of which stay alive in the background (e.g. `swaybg`).

**Goal**: Clearer visualization, monitoring and tracking of processes managed by the shell, with ability to stop/pause/start on demand.
> E.g. Changing a wallpaper would require stopping/killing the ongoing `swaybg` process, and starting a new one.

- [ ] Keep track of running processes as reference objects.
- [ ] Visualize processes running under the shell.
- [ ] Stop/Pause/Start specific processes on demand.

##### Buttons and clickables
Too many files now provide for button component: `Clickable`, `ClickableWithIcon`, `ClickableIcon`, `ClickableButton`.

**Goal**: Clean up redundant button components, using only some generic versions.
- [ ] Review use of `ClickableWithAccent` - it might actually be fit to replace all buttons.

##### Screenshot utility
Currently works as basic process that allows:
- Region selection
- Full screen
- Load clipboard into `satty` (if it's an image)

Good for now, but can be better.

- [ ] Allow mode selection on top of screenshot to clipboard:
  - Do nothing (clipboard only)
  - Clipboard + save to folder
  - Clipboard + open in `satty`
  - (Optional) Clipboard + save to folder + open in `satty`

- [ ] Allow screenshot of windows
      Reference: [2026-11-22-Screenshot-of-windows](./Research/2026-11-22-Screenshot-of-windows.md)
- [ ] 
  