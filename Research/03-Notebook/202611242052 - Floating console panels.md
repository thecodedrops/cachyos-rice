---
Tags:
Created: 2026-11-24
---
**Working code for floating panes, derived from current console (single pane)**
```qml
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell

import qs
import qs.Layouts
import qs.Services
import qs.Utilities
import qs.Components
import qs.Views.Power
import qs.Views.Audio
import qs.Views.System
import qs.Views.Display
import qs.Views.Network
import qs.Views.Battery
import qs.Views.Bluetooth
import qs.Views.Applications

ColumnLayout {
    id: root
    spacing: Constants.padding
    required property ShellScreen screen

    property bool _ready: false

    readonly property int _GAP: Constants.spacing / 1.5
    readonly property int _PADDING: Constants.padding * 3
    readonly property int _WIDTH: 1920 / 2.75
    readonly property Component _DEFAULT__ACTIVE_CONTENT: Launchpad { page_size: 8 }

    property Component _ACTIVE_CONTENT: root._NAVIGATION_STACK.length > 0 ? root._NAVIGATION_STACK[root._NAVIGATION_STACK.length - 1] : root._DEFAULT__ACTIVE_CONTENT
    property list<Component> _NAVIGATION_STACK: [ _DEFAULT__ACTIVE_CONTENT ]

    function back() {
        if (root._NAVIGATION_STACK.length > 1) {
            const updated_stack = root._NAVIGATION_STACK.slice(0, -1);
            root._NAVIGATION_STACK = updated_stack;
        }
    }

    function navigate(__ACTIVE_CONTENT) {
        // Toggling back to default if re-selecting current _ACTIVE_CONTENT
        if (__ACTIVE_CONTENT === root._ACTIVE_CONTENT) {
            root._NAVIGATION_STACK = [ root._DEFAULT__ACTIVE_CONTENT ];
            return;
        }

        if (Constants.console_disable_navigation) {
            root._NAVIGATION_STACK = [ __ACTIVE_CONTENT ];
            return;
        }

        // Filter out existing instances of __ACTIVE_CONTENT to avoid duplicate entries
        const filteredStack = root._NAVIGATION_STACK.filter(item => item !== __ACTIVE_CONTENT);
        filteredStack.push(__ACTIVE_CONTENT);

        // Reassign array to trigger QML property binding updates
        root._NAVIGATION_STACK = filteredStack;
    }

    StyledBox {
        id: _WidgetsBox
        colors.background: Constants.console_color_background
        colors.border: Constants.console_color_border

        radius: Constants.radius * 2

        implicitWidth: root._WIDTH
        implicitHeight: _Widgets.implicitHeight + (root._PADDING * 1.5)

        ColumnLayout {
            id: _Widgets

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            anchors.margins: (root._PADDING * 1.5) / 2

            spacing: root._GAP * 2
            visible: root.opacity > 0.1

            // --- Header Row ---
            RowLayout {
                Layout.fillWidth: true
                spacing: root._GAP

                ClockControl { Layout.alignment: Qt.AlignTop; }

                Item { Layout.fillWidth: true; }

                BluetoothControl {
                    Layout.maximumWidth: Constants.bluetooth_control_max_width
                    active: root._ACTIVE_CONTENT === bluetooth_devices
                    onClicked: root.navigate(bluetooth_devices)
                    Component { id: bluetooth_devices; BluetoothDevices { } }
                }

                NetworkControl {
                    Layout.maximumWidth: Constants.network_control_max_width
                    active: root._ACTIVE_CONTENT === network_devices
                    onClicked: root.navigate(network_devices)

                    Component {
                        id: network_devices
                        NetworkDevices { onOptionsViewClicked: root.navigate(network_options) }
                    }

                    Component {
                        id: network_options
                        NetworkDeviceSaved { Layout.fillWidth: true }
                    }
                }

                BatteryControl {
                    active: root._ACTIVE_CONTENT === battery_profiles
                    onClicked: root.navigate(battery_profiles)
                    Component { id: battery_profiles; BatteryProfiles { max_height: 160 } }
                }

                PowerControl {
                    active: root._ACTIVE_CONTENT === power_options
                    onClicked: root.navigate(power_options)
                    Component { id: power_options; PowerOptions { max_height: 160; } }
                }

                PowerControl {
                    iconname: "Lock.svg"
                    onClicked: EventOrchestrator.lockDevice()
                }
            }

            // --- Widgets Row ---
            RowLayout {
                Layout.fillWidth: true
                spacing: root._GAP

                MuteControl {}

                Clickable {
                    id: volume_wrapper
                    Layout.fillWidth: true
                    implicitHeight: volume_control.implicitHeight

                    readonly property bool active: root._ACTIVE_CONTENT === audio_devices

                    VolumeControl {
                        id: volume_control
                        radius: Constants.radius

                        readonly property bool hovered: volume_wrapper.containsMouse

                        styles.background_color: Constants.control_color_background_default
                        styles.border_color: (hovered || volume_wrapper.active) ?
                                                 Qt.alpha(Constants.volume_control_color_ink_default, 0.20) :
                                                 Constants.control_color_border_default

                        styles.track_color: Constants.volume_control_color_track
                        styles.accent_color: Constants.volume_control_color_ink_active

                        styles.animate_on_start: true

                        border.width: 1

                        Behavior on styles.border_color { ColorAnimation { duration: Constants.animation_duration }}
                    }

                    onClicked: root.navigate(audio_devices)
                    Component { id: audio_devices; AudioDevices { } }
                }

                BrightnessControl {
                    Layout.fillWidth: true
                    radius: Constants.radius

                    styles.background_color: Constants.control_color_background_default
                    styles.border_color: Constants.control_color_border_default

                    styles.track_color: Constants.display_control_color_track
                    styles.accent_color: Constants.display_control_color_active

                    styles.animate_on_start: true

                    border.width: 1
                }

                KeepAwakeControl {
                    inhibitor: Daemon.idle_inhibitor
                }
            }
        }
    }

    StyledBox {
        colors.background: Constants.console_color_background
        colors.border: Constants.console_color_border

        radius: Constants.radius * 2

        implicitWidth: root._WIDTH
        implicitHeight: _ViewPortLayout.implicitHeight + (root._PADDING * 1.5)

        ColumnLayout {
            id: _ViewPortLayout
            implicitHeight: _ViewPort.implicitHeight

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            
            anchors.margins: (root._PADDING * 1.5) / 2

            spacing: root._GAP * 2
            visible: root.opacity > 0.1

            // --- Main Container ---
            ContentContainer {
                id: _ViewPort
                Layout.fillWidth: true
                Layout.fillHeight: true

                content: (!root._ready) ? null : root._ACTIVE_CONTENT
            }
        }
    }

    Item {
        implicitWidth: root._WIDTH
        implicitHeight: _FooterRow.implicitHeight

        RowLayout {
            id: _FooterRow

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            visible: root.opacity > 0.1

            spacing: root._GAP

            ClickableButton {
                visible: (opacity) > 0
                opacity: (root._NAVIGATION_STACK.length > 1) ? 1 : 0
                Behavior on opacity { NumberAnimation { duration: 200 } }

                size: Constants.icon_size
                padding: Constants.padding
                radius: Constants.icon_size

                iconname: "Arrow-Left.svg"

                styles.background_color_idle: Constants.control_color_background_default

                styles.border_width: 1
                styles.border_color_idle: Constants.console_color_border
                styles.border_color_active: Constants.control_color_ink_active

                styles.icon_color_idle: Constants.control_color_ink_default
                styles.icon_color_active: Constants.control_color_ink_active

                onClicked: root.back()
            }

            Item { Layout.fillWidth: true }

            DisplayControl {
                active: root._ACTIVE_CONTENT === display_management
                onClicked: root.navigate(display_management)
                styles.border_color_idle: Constants.console_color_border
                Component {
                    id: display_management
                    DisplayManagement {
                        implicitHeight: 400
                        screen: root.screen
                    }
                }
            }

            ClickableButton {
                size: Constants.icon_size
                padding: Constants.padding
                radius: Constants.icon_size

                iconname: "Applications.svg"

                styles.background_color_idle: Constants.control_color_background_default

                styles.border_width: 1
                styles.border_color_idle: Constants.console_color_border
                styles.border_color_active: Constants.control_color_ink_active

                styles.icon_color_idle: Constants.control_color_ink_default
                styles.icon_color_active: Constants.control_color_ink_active

                active: root._ACTIVE_CONTENT === app_installer
                onClicked: root.navigate(app_installer)

                Component {
                    id: app_installer
                    PackageExtraction { onCompleted: root.back() }
                }
            }
        }
    }

    Component.onCompleted: _ready = true
}
```
