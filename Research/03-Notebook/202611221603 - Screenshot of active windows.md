---
Tags:
Created: 2026-11-22
---
### Using Mango IPC and Quickshell to screenshot specific windows/clients

General flow:
1. Place a semi-opaque overlay on all screens.
2. Fetch details of all open windows (via `mango ipc`).
3. Highlight window at cursor position.
4. Get window coordinates and dimensions for screenshot
5. Pass to a bash script to use `grim` for capture

#### Finding all active windows/clients
```qml
import Quickshell
import Quickshell.Io

Scope {
    property var activeClients: []

    Process {
        id: clientProc
        command: ["mmsg", "get", "all-clients"]
        stdout: StdioCollector {
            onStreamFinished: {
                if (text.trim().length > 0) {
                    activeClients = JSON.parse(text);
                    console.log("Loaded " + activeClients.length + " windows");
                }
            }
        }
    }

    Component.onCompleted: clientProc.running = true
}
```

#### Finding window at cursor position
```js
function findWindowUnderCursor() {
    // Run cursorpos and all-clients via shell or background processes, 
    // then evaluate in JS:
    var cursorX = ...; 
    var cursorY = ...;
    var clients = ...; // parsed from mmsg get all-clients

    for (var i = 0; i < clients.length; i++) {
        var c = clients[i];
        if (cursorX >= c.x && cursorX <= (c.x + c.width) &&
            cursorY >= c.y && cursorY <= (c.y + c.height)) {
            return c; // Target window found
        }
    }
    return null;
}
```

#### Example bash snippet for grim capture
> Use coordinates and dimensions fetched prior to avoid requiring `jq`
```bash
# Example bash snippet utilizing mmsg and grim
geometry=$(mmsg get focusing-client | jq -r '"\(.x),\(.y) \(.width)x\(.height)"')
[ -n "$geometry" ] && grim -g "$geometry" "$HOME/Pictures/Screenshots/window-$(date +%s).png"
```

#### Highlighting windows for screenshot
```qml
import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    // Track global cursor coordinates
    property int cursorX: 0
    property int cursorY: 0

    // Continuously poll cursor position from MangoWM IPC
    Process {
        id: cursorPollProc
        running: true
        // Polling every ~50ms is lightweight and responsive for UI overlays
        command: ["sh", "-c", "while true; do mmsg get cursorpos; sleep 0.05; done"]
        stdout: StdioCollector {
            onStreamFinished: {}
            onLineReceived: (line) => {
                try {
                    var pos = JSON.parse(line);
                    if (pos.x !== undefined && pos.y !== undefined) {
                        cursorX = pos.x;
                        cursorY = pos.y;
                    }
                } catch (e) {
                    // Ignore malformed json chunks during streaming
                }
            }
        }
    }

    // Create a PanelWindow on every connected physical screen
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: screenWindow
            screen: modelData

            // Layer-shell configuration to cover the entire screen
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            color: "transparent"

            // Check if this specific screen bounds the current cursor coordinates
            readonly property bool hasCursor: 
                cursorX >= screen.x && cursorX < (screen.x + screen.width) &&
                cursorY >= screen.y && cursorY < (screen.y + screen.height)

            // Main overlay background and border
            Rectangle {
                anchors.fill: parent
                // Dim non-active screens; leave the cursor screen completely clear
                color: screenWindow.hasCursor ? "transparent" : "rgba(0, 0, 0, 0.45)"

                // Accent border highlight around the active screen
                border.color: screenWindow.hasCursor ? "#cba6f7" : "transparent" // Catppuccin Mauve
                border.width: screenWindow.hasCursor ? 4 : 0
            }
        }
    }
}
```
