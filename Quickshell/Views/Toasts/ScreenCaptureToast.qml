pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Io

import qs
import qs.Services
import qs.Components

StyledBox {
    id: control

    property bool clipboard_holds_image: false

    readonly property list<var> options: [
        { 
            vector: "Capture-Region.svg",
            disabled: false,
            command: () => {
                EventOrchestrator.osdDismissEvent(); 
                Quickshell.execDetached([
                    "sh", "-c", Constants.screen_capture_command_region
                ]);
            } 
        },
        { 
            vector: "Capture-Screen.svg",
            disabled: false,
            command: () => {
                EventOrchestrator.osdDismissEvent(); 
                Quickshell.execDetached([
                    "sh", "-c", Constants.screen_capture_command_full
                ])
            } 
        },
        { 
            vector: "Capture-Image.svg",
            disabled: !control.clipboard_holds_image,
            command: () => {
                EventOrchestrator.osdDismissEvent(); 
                Quickshell.execDetached([
                    "sh", "-c", Constants.screen_capture_command_clipboard
                ])
            } 
        },
        { 
            vector: "Dismiss.svg",
            disabled: false,
            command: () => { 
                EventOrchestrator.osdDismissEvent(); 
            } 
        }
    ]

    implicitHeight: content.implicitHeight + Constants.padding
    implicitWidth: content.implicitWidth + Constants.padding

    RowLayout {
        id: content
        anchors.centerIn: parent

        spacing: 2

        Repeater {
            model: control.options
            delegate: ClickableWithFade {
                required property var modelData

                visible: !modelData.disabled

                padding: Constants.padding / 1.5

                size: Constants.icon_size
                vector: modelData.vector
                radius: Constants.radius / 2

                ink_color_active: Constants.color_subtext
                ink_color_idle: Constants.default_color_accent
                
                border_color: Qt.alpha(Constants.color_surface, 0)
                background_color: Qt.alpha(Constants.color_surface, 0)
                background_color_active: Qt.alpha(Constants.color_surface, 1)

                onClicked: modelData.command()
            }
        }
    }

    Process {
        id: proc_clipboard_check
        command: ["wl-paste", "--list-types"]
        running: !control.clipboard_holds_image

        stdout: SplitParser {
            onRead: (data) => {
                if (control.clipboard_holds_image) return;
                control.clipboard_holds_image = data.includes("image/");
            }
        }
    }
}