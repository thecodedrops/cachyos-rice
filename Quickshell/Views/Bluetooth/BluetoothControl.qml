pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Bluetooth

import qs
import qs.Components

ClickableWithFade {
    id: root

    // qmllint disable
    readonly property var adapter: Bluetooth.defaultAdapter
    // qmllint enable

    component DatamapModel: QtObject {
        property string label: "Bluetooth"
        property string icon: "Bluetooth-Off.svg"
        property color accent: Constants.bluetooth_color_critical
    }

    QtObject {
        id: _States
        property DatamapModel enabling: DatamapModel {
            icon: "Bluetooth-On.svg"
            accent: Constants.bluetooth_color_busy
        }
        property DatamapModel disabling: DatamapModel {
            icon: "Bluetooth-Off.svg"
            accent: Constants.bluetooth_color_busy
        }
        property DatamapModel disabled: DatamapModel {
            icon: "Bluetooth-Off.svg"
            accent: Constants.bluetooth_color_ink_default
        }
        property DatamapModel enabled: DatamapModel {
            icon: "Bluetooth-On.svg"
            accent: Constants.bluetooth_color_active
        }
        property DatamapModel blocked: DatamapModel {
            icon: "Bluetooth-Error.svg"
            accent: Constants.bluetooth_color_critical
        }
        property DatamapModel unknown: DatamapModel {
            icon: "Bluetooth-Error.svg"
            accent: Constants.bluetooth_color_critical
        }
    }

    property DatamapModel statemap: switch (adapter.state ?? BluetoothAdapterState.Blocked) {
        case BluetoothAdapterState.Enabling: return _States.enabling;
        case BluetoothAdapterState.Disabling: return _States.disabling;
        case BluetoothAdapterState.Disabled: return _States.disabled;
        case BluetoothAdapterState.Enabled: return _States.enabled;
        case BluetoothAdapterState.Blocked: return _States.blocked;
        default: return _States.unknown;
    }

    property DatamapModel datamap: statemap ?? _States.unknown

    size: Constants.icon_size

    padding: Constants.padding
    rightPadding: (text.length > 0) ? Constants.padding * 1.25 : Constants.padding

    vector: datamap.icon

    ink_color_active: datamap.accent
    ink_color_idle: Constants.bluetooth_color_ink_active

    border_color: Constants.control_color_border_default
    background_color: Constants.control_color_background_default

    font.family: Constants.font_family

    radius: (active) ? Constants.radius_active : Constants.radius
    Behavior on radius { NumberAnimation { duration: 100; easing.type: Easing.OutCubic } }
}