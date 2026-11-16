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

        // Rectangle {
        //     anchors.fill: parent
        //     color: Constants.color_mantle
        //     opacity: 0.50
        // }
    }

    Rectangle {
        anchors.fill: parent
        color: Constants.color_mantle
        opacity: 0.5

        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            blurMax: 15
            shadowColor: Qt.alpha(Constants.color_mantle, 0.7)
        }
    }

    Item {
        anchors.fill: parent

        RowLayout {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: Constants.padding * 4

            spacing: Constants.spacing

            ClickableIcon {
                visible: Debug._DEBUG_MODE_
                iconname: "Key.svg"
                size: Constants.icon_size
                styles.icon_color_idle: Constants.color_subtext
                styles.icon_color_active: Constants.color_text
                onClicked: if (Debug._DEBUG_MODE_) root.context.unlocked()
            }

            ClickableIcon {
                iconname: "Power.svg"
                size: Constants.icon_size
                styles.icon_color_idle: Constants.color_subtext
                styles.icon_color_active: Constants.color_text
                onClicked: Daemon.execute(["systemctl", "poweroff"])
            }
        }

        Column {
            spacing: Constants.spacing

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.margins: Constants.padding * 4
            anchors.bottomMargin: 128

            width: 200
            height: Constants.size * 2

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