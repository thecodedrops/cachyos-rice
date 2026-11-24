### Floating Panels / Single Panel
The shell right now opens as a single panel with widgets, the main view-port and the footer row (for navigation).

- Consider having floating panels as a customization option in `Constants`.
	- Likely most easily done with different code files altogether for each view.
	- Challenge would lie in sharing the navigation context to avoid code duplication.
		- Possibly having a `ConsoleContext` that manages state can solve this.
- [202611242052 - Floating console panels](202611242052%20-%20Floating%20console%20panels)

### Process management
The shell launches many processes - some of which stay alive in the background (e.g. `swaybg`).

**Goal**: Clearer visualization, monitoring and tracking of processes managed by the shell, with ability to stop/pause/start on demand.
> E.g. Changing a wallpaper would require stopping/killing the ongoing `swaybg` process, and starting a new one.

- Keep track of running processes as reference objects.
- Visualize processes running under the shell.
- Stop/Pause/Start specific processes on demand.

### Buttons
Clean up redundant button components, using only some generic versions.
- Review use of `ClickableWithAccent` - it might actually be fit to replace all buttons.
- Too many files now provide for button component: `Clickable`, `ClickableWithIcon`, `ClickableIcon`, `ClickableButton`.

### Screenshot utility
Currently works as basic process that allows:
- Region selection, Full screen
- Load clipboard into `satty` (if it's an image)

**Improvements:**   
Allow mode selection on top of screenshot to clipboard:
- Do nothing (clipboard only)
- Clipboard + save to folder
- Clipboard + open in `satty`
- (Optional) Clipboard + save to folder + open in `satty`

Reference: [202611221603 - Screenshot of active windows](202611221603%20-%20Screenshot%20of%20active%20windows.md)

### Screen Recording
`gpu-screen-recorder` is already a good command-line tool with `gpu-screen-recorder-ui` being just a GUI on top.
- Call `gpu-screen-recorder` from the shell for built-in screen recording capabilities.
	- Toast to inform recording starting
	- Configurable (in shell, not constants) whether toast should be sticky (stay on screen during recording)
	- Toast to inform recording ended and where it was saved.

### Wallpaper Selector
Changing / choosing a wallpaper, and theme in the future.
**Dependencies**: Persistent configuration storage problem (via files or database).
- Closest to desired approach: [Wallpaper Picker (By Dhruv Sharma)](gh-dhrruvsharma-shell-wallpaper-picker.webp) with the following changes:
	- Carousel with 5-7 cards shown at a time, and rest is hidden.
		- Navigation by keyboard or mouse (carousel left and right buttons)
		- Current selection is always the middle card
		- Leftward and rightward cards are smaller and fading
		- Keep the overlap and shadow between cards
		- Consider how symmetry should adjust for less than 5-7 cards
	- Live preview immediately applying wallpaper when navigated to
		- Wallpaper transition similar to transitions in [Tsugumori (Reddit)](https://www.reddit.com/r/unixporn/s/nRMesZJuiy)
			- Overlay block color slide, followed by new wallpaper reveal
		- Cache true active setup to revert back to on exit
		- Persist choices
- Future: Add theme previews and selection to the tool.