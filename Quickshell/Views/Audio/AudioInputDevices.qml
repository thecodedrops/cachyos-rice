pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell.Services.Pipewire

import qs
import qs.Components

ColumnLayout {
    id: root
    spacing: Constants.spacing

    required property var nodes
    required property PwNode defaultNode

    readonly property int item_height: Constants.size + Constants.padding
    property int page_size: Math.min(5, root.nodes?.length ?? 0)
    readonly property int capped_height: (item_height * page_size) + (Constants.spacing * Math.max(0, page_size - 1))

    Loader {
        Layout.fillWidth: true
        sourceComponent: (root.page_size > 0) ? _AudioInputDeviceListComponent : _NoDevicesFoundComponent
    }

    Component {
        id: _AudioInputDeviceListComponent

        ListView {
            Layout.fillWidth: true

            implicitHeight: root.capped_height
            Layout.preferredHeight: root.capped_height

            spacing: Constants.spacing
            clip: true

            model: root.nodes ?? []

            ScrollBar.vertical: ScrollBar { policy: ScrollBar.AlwaysOff }

            delegate: Clickable {
                id: _AudioInputDevice
                width: ListView.view.width
                implicitHeight: root.item_height

                required property var modelData

                readonly property PwNode nodeObj: modelData?.node ?? modelData
                readonly property bool isDefault: root.defaultNode && nodeObj && (root.defaultNode.id === nodeObj.id)
                readonly property string deviceName: nodeObj?.description || nodeObj?.name || "Unknown Audio Device"
                readonly property string nickName: nodeObj?.properties["node.nick"] || nodeObj?.properties["device.description"] || ""

                readonly property color accent: Constants.network_color_active

                onClicked: {
                    if (!nodeObj) return;
                    Pipewire.preferredDefaultAudioSource = nodeObj;
                }

                StyledBox {
                    anchors.fill: parent
                    radius: Constants.radius

                    color: Constants.network_color_background
                    border.color: _AudioInputDevice.isDefault ? Qt.alpha(_AudioInputDevice.accent, 0.5) :
                        (_AudioInputDevice.containsMouse) ? Qt.alpha(Constants.network_color_border, 1) : Qt.alpha(Constants.network_color_border, 0.5)
                    border.width: 1

                    Behavior on border.color {
                        ColorAnimation {
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: Constants.padding * 1.25
                        anchors.rightMargin: Constants.padding * 1.25
                        spacing: Constants.spacing

                        StyledText {
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignLeft
                            text: _AudioInputDevice.deviceName
                            color: _AudioInputDevice.isDefault ? _AudioInputDevice.accent : Constants.network_color_ink_default
                            elide: Text.ElideRight
                        }

                        StyledText {
                            horizontalAlignment: Text.AlignRight
                            text: _AudioInputDevice.nickName
                            color: Constants.network_color_ink_muted
                            font.pixelSize: Constants.font_size - 1
                            visible: _AudioInputDevice.nickName !== "" && _AudioInputDevice.nickName !== _AudioInputDevice.deviceName
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }
    }

    Component {
        id: _NoDevicesFoundComponent

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: _NoDeviceFoundLabel.implicitHeight + Constants.padding * 3
            radius: Constants.radius
            color: Qt.alpha(Constants.network_color_inactive, 0.15)
            border.width: 1
            border.color: Constants.network_color_inactive

            StyledText {
                id: _NoDeviceFoundLabel
                leftPadding: Constants.padding * 1.5
                rightPadding: Constants.padding * 1.5
                anchors.verticalCenter: parent.verticalCenter
                text: "No input devices found"
                color: Constants.network_color_ink_muted
            }
        }
    }
}