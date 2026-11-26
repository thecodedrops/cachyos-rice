## Improvements

### Process management
The shell launches many processes - some of which stay alive in the background (e.g. `swaybg`).
**Goal**: Clearer visualization, monitoring and tracking of processes managed by the shell, with ability to stop/pause/start on demand.
> E.g. Changing a wallpaper would require stopping/killing the ongoing `swaybg` process, and starting a new one.

- Keep track of running processes as reference objects.
- Visualize processes running under the shell.
- Stop/Pause/Start specific processes on demand.

### Toast System
Needs rework. Right now it's too tightly coupled with the toast content.
**Proposal:** Toasts are pushed via events with the component that should be rendered.

### Screenshot utility
Currently works as basic process that allows:
- Region selection, Full screen
- Load clipboard into `satty` (if it's an image)

**Improvement:** Allow mode selection on top of screenshot to clipboard.
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

### Battery Profiles
Currently only showing performance modes a big block buttons.
- Should shift to more details about the battery
	- Up-time since last shutdown / reboot
	- CPU and RAM usage
	- (Needs some research)
- Change performance profile switcher to smaller almost tab-like switch

## Ideation Corner

### Floating Panels / Single Panel
The shell right now opens as a single panel with widgets, the main view-port and the footer row (for navigation).   
[202611242052 - Floating console panels](202611242052%20-%20Floating%20console%20panels)

- Consider having floating panels as a customization option in `Constants`.
	- Likely most easily done with different code files altogether for each view.
	- Challenge would lie in sharing the navigation context to avoid code duplication.
		- Possibly having a `ConsoleContext` that manages state can solve this.

### Status Bar
The shell was not built to have a status bar - but the document below proposes an approach for the future.
[202611251121 - Status Bar with floating consoles](202611251121%20-%20Status%20Bar%20with%20floating%20consoles.md)

### Fancy Buttons
Current `clickables` have a simple color animation whereby the background, text and border colors change on state change.
**Proposal**: Sweep effect on state change.

- Background color slides in from a side (configurable).
- Border color changes in parallel throughout animation.
- Text could change at the end or towards the end for dramatic effect.
	- Optional: Text fades out early and fades back in with new color towards the end.

Might be interesting to try those out in Figma.

### Keep Awake Control - Rotating icon only
Not planning to do that now, but good to keep the code on hand.
```qml
contentItem.transform: Rotation {
	origin.x: keepawake.contentItem.width / 2
	origin.y: keepawake.contentItem.height / 2
	
	angle: inhibitor.enabled ? 270 : 0

	Behavior on angle { 
		RotationAnimation { 
			id: anim_rotation 
			duration: Constants.animation_duration 
			easing.type: Easing.InOutQuad 
		} 
	}
}
```