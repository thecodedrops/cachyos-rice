pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls.Fusion

import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland

import qs
import qs.Services
import qs.Utilities
import qs.Components

WlSessionLockSurface {
    id: root
    required property LockContext context

    color: Constants.color_transparent

    Image {
        anchors.fill: parent
        source: Debug.uri(Constants.system_wallpaper_path)
        fillMode: Image.PreserveAspectCrop
    }

    ColumnLayout {
        spacing: Constants.spacing
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: (Constants.padding * 10)
        anchors.leftMargin: (Constants.padding * 12)

        StyledText {
            Layout.alignment: Qt.AlignLeft
            text: Qt.formatDateTime(Daemon.clock.date, "dddd, MMMM dd")
            font.pixelSize: 36
            color: Constants.color_light
        }

        StyledText {
            Layout.alignment: Qt.AlignLeft
            text: Qt.formatDateTime(Daemon.clock.date, "hh:mm")
            font.pixelSize: 32;
            color: Constants.color_light
        }
    }

    ColumnLayout {
        spacing: Constants.spacing
        anchors.fill: parent

        Row {
            Layout.fillWidth: true
            Layout.margins: Constants.padding * 4

            spacing: Constants.spacing

            ClickableIcon {
                anchors.top: parent.top
                anchors.left: parent.left

                visible: Debug._DEBUG_MODE_
                iconname: "Key.svg"
                size: Constants.icon_size
                styles.icon_color_idle: Constants.color_subtext
                styles.icon_color_active: Constants.color_text
                onClicked: if (Debug._DEBUG_MODE_) root.context.unlocked()
            }

            ClickableIcon {
                anchors.top: parent.top
                anchors.right: parent.right

                iconname: "Power.svg"
                size: Constants.icon_size
                styles.icon_color_idle: Constants.color_subtext
                styles.icon_color_active: Constants.color_text
                onClicked: Daemon.execute(["systemctl", "poweroff"])
            }
        }

        Item { Layout.fillHeight: true }

        Column {
            spacing: Constants.spacing

            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.margins: Constants.padding * 4
            Layout.bottomMargin: 128
            Layout.preferredHeight: Constants.size * 2

            width: 200

            TextField {
                id: _PasswordTextField

                anchors.horizontalCenter: parent.horizontalCenter

                implicitWidth: 200
                implicitHeight: Constants.size

                padding: Constants.padding/2
                echoMode: TextInput.Password
                inputMethodHints: Qt.ImhSensitiveData
                placeholderText: "Unlock device"
                placeholderTextColor: Constants.color_subtext
                font.family: Constants.font_family
                font.pixelSize: Constants.font_size_sm
                color: Constants.color_text
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: TextInput.AlignVCenter
                focus: true

                background: Rectangle {
                    color: Qt.alpha(Constants.color_base, 0.75)
                    radius: Constants.radius
                    // border.color: (root.context.showFailure) ? Constants.color_red : _PasswordTextField.activeFocus ? Constants.color_subtext : Constants.color_surface
                    border.color: (root.context.showFailure) ? Constants.color_red : Qt.alpha(Constants.color_surface, _PasswordTextField.activeFocus ? 1 : 0.5)
                    border.width: 1

                    Behavior on border.color { ColorAnimation { duration: 200 } }
                }

                onTextChanged: root.context.currentText = this.text;

                onAccepted: root.context.tryUnlock();

                Connections {
                    target: root.context

                    function onCurrentTextChanged() {
                        _PasswordTextField.text = root.context.currentText;
                    }
                }
            }

            StyledText {
                anchors.horizontalCenter: parent.horizontalCenter
                visible: opacity > 0
                opacity: root.context.showFailure ? 1 : 0
                text: "Incorrect password"
                color: Constants.color_red

                Behavior on opacity { NumberAnimation { duration: 200 } }
            }
        }
    }
}