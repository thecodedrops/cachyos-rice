pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import Quickshell

import qs

Button {
    id: root

    property int size: 0
    property string vector: ""
    property bool active: false

    required property color accent_color
    required property color ink_color

    property color muted_color: Constants.color_overlay

    component AnimationOptions: QtObject { required property int duration }
    property AnimationOptions animation: AnimationOptions { duration: 250 }

    readonly property bool is_active: enabled && (hovered || active)
    readonly property string _icon_path: (`${Quickshell.shellDir}/${Constants.icons_directory}/${vector}`).replace("//", "/")

    property color effective_ink_color: (is_active) ? accent_color : (enabled) ? ink_color : muted_color

    padding: 0
    hoverEnabled: enabled

    antialiasing: true
    smooth: true

    width: (size > 0) ? size : implicitWidth
    height: (size > 0) ? size : implicitHeight

    icon.width: size
    icon.height: size

    icon.color: effective_ink_color
    icon.source: (vector.length > 0) ? Qt.resolvedUrl(_icon_path) : ""

    onPressed: scale = 0.94
    onReleased: scale = 1.00

    font.pixelSize: Constants.font_size
    font.family: Constants.font_family
    font.letterSpacing: Constants.font_spacing

    palette.buttonText: effective_ink_color

    background: null

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        enabled: false
    }

    Behavior on scale { NumberAnimation { duration: root.animation.duration } }
    Behavior on icon.color { ColorAnimation { duration: root.animation.duration } }
    Behavior on palette.buttonText { ColorAnimation { duration: root.animation.duration } }
}