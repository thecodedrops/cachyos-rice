---
Tags:
Created: 2026-11-25
---
### Status Bar + Floating Consoles
Header row in console already consists of several items that would be fit for a status bar.
![](20261125113658.webp)

Support for status bar could be achieved by:
- Decoupling the header row items from console
	- (Optional) Allow background for some elements like clock.
	- (Optional) Group the control buttons in a container with background.
- Modifying `Shell.qml` to have a full screen panel window that reserves space for status bar
	- Placing the decoupled items in the reserved space, filling the width

Impact on console behaviour:
- Status bar and console header will show the same information, which could be tackled as follows:
	- Do nothing - it's redundant information, but not a problem
	- Fade out the status bar when opening the console
	- Create a custom console for when status bar is used whereby:
		- The status bar widgets animate into the console
		- Container backgrounds fade out + items move and resize to fit in the console
		- New information can fade in along the way or once in the console