pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell

import qs
import qs.Services
import qs.Utilities
import qs.Components

RowLayout {
    id: root
    spacing: Constants.spacing

    property int max_height: 0

    Repeater {
        model: [
            {
                title: "Shutdown",
                desc: "Turn computer off",
                vector: "Power.svg",
                accent: Constants.power_color_shutdown,
                command: ["systemctl", "poweroff"],
                callback: null
            },
            {
                title: "Reboot",
                desc: "Restart the machine",
                vector: "Reboot.svg",
                accent: Constants.power_color_reboot,
                command: ["systemctl", "reboot"],
                callback: null
            },
            {
                title: "Suspend",
                desc: "Low power state",
                vector: "Suspend.svg",
                accent: Constants.power_color_suspend,
                command: ["systemctl", "suspend"],
                callback: null
            },
            {
                title: "Log Out",
                desc: "End session",
                vector: "Logout.svg",
                accent: Constants.power_color_logout,
                command: ["loginctl", "kill-session", Quickshell.env("XDG_SESSION_ID")],
                callback: null
            },
            {
                title: "Lock",
                desc: "Lock session",
                vector: "Lock.svg",
                accent: Constants.power_color_lock,
                command: null,
                callback: () => EventOrchestrator.lockDevice()
            }
        ]
        
        delegate: ClickableWithSweep {
            Layout.fillWidth: modelData.title
            Layout.preferredWidth: modelData.title ? 0 : Constants.size * 1.5
            Layout.preferredHeight: Constants.size * 1.5

            padding: Constants.padding
            
            required property var modelData

            vector: modelData.vector

            background_color: Constants.power_color_background
            border_color: Constants.power_color_border
            ink_color_active: modelData.accent
            ink_color_idle: Constants.power_color_ink_active

            text: modelData.title

            onClicked: {
                if (modelData.command) {
                    Debug.log(["Power Menu"], "Executing System Action: " + modelData.command)
                    Quickshell.execDetached({ command: modelData.command });
                    return;
                }

                modelData.callback && modelData.callback();
            }
        }
        
        // delegate: Clickable {
        //     id: item

        //     Layout.fillWidth: true
        //     Layout.preferredWidth: 0

        //     required property string title
        //     required property string desc
        //     required property string vector
        //     required property color accent
        //     required property list<string> command

        //     readonly property bool active: containsMouse

        //     Rectangle {
        //         implicitHeight: Math.max(160, root.max_height)

        //         radius: Constants.radius
        //         color: Constants.power_color_background

        //         border.width: 1
        //         border.color: (enabled && item.active) ? item.accent : Constants.power_color_border

        //         Behavior on radius { NumberAnimation { duration: Constants.animation_duration } }
        //         Behavior on color { ColorAnimation { duration: Constants.animation_duration } }
        //         Behavior on border.color { ColorAnimation { duration: Constants.animation_duration } }

        //         ColumnLayout {
        //             anchors.left: parent.left
        //             anchors.right: parent.right
        //             anchors.verticalCenter: parent.verticalCenter
        //             anchors.margins: Constants.padding * 2
        //             spacing: Constants.spacing / 2

        //             IconControl {
        //                 Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        //                 Layout.bottomMargin: Constants.padding
        //                 size: 48
        //                 source: item.vector
        //                 tint: (item.active) ? item.accent : Constants.power_color_ink_muted
        //             }

        //             StyledText {
        //                 Layout.fillWidth: true
        //                 Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        //                 font.bold: Constants.power_show_description
        //                 font.pixelSize: Constants.power_show_description ? Constants.font_size_lg : Constants.font_size
        //                 horizontalAlignment: Text.AlignHCenter
        //                 text: item.title
        //                 styles.color_idle: Constants.power_color_ink_muted
        //                 styles.color_active: item.accent
        //                 active: item.active
        //             }

        //             StyledText {
        //                 visible: Constants.power_show_description
        //                 Layout.fillWidth: true
        //                 Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        //                 font.pixelSize: Constants.font_size
        //                 horizontalAlignment: Text.AlignHCenter
        //                 wrapMode: Text.WordWrap
        //                 elide: Text.ElideRight
        //                 maximumLineCount: 2
        //                 text: item.desc
        //                 styles.color_idle: Constants.power_color_ink_muted
        //                 styles.color_active: Constants.power_color_ink_default
        //                 active: item.active
        //             }
        //         }

        //     }

        //     onClicked: {
        //         Debug.log(["Power Menu"], "Executing System Action: " + command)
        //         Quickshell.execDetached({ command: command });
        //     }
        // }
    }
}