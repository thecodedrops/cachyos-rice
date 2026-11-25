pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Widgets

ClickableButton {
    id: root

    readonly property color border_color_base: root.border_color
    readonly property color border_color_accent: Qt.alpha(root.accent_color, 1)

    readonly property color bockground_color_base: root.background_color
    readonly property color bockground_color_accent: Qt.alpha(root.accent_color, 1)

    readonly property color effective_border_color: (enabled) ? border_color_base : root.muted_color
    readonly property color effective_background_color: (is_active) ? bockground_color_accent : (enabled) ? bockground_color_base : root.muted_color

    effective_ink_color: (is_active) ? ink_color : (enabled) ? accent_color : muted_color

    background: ClippingRectangle {
        radius: root.radius
        color: root.bockground_color_base

        border.width: root.border_width
        border.color: root.border_color_base

        layer.enabled: true
        layer.smooth: true

        Behavior on radius { NumberAnimation { duration: root.animation.duration } }
        Behavior on border.color { ColorAnimation { duration: root.animation.duration } }

        Rectangle { 
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width + 4

                x: root.enabled && root.is_active ? -2 : parent.width + 2
                opacity: root.enabled && root.is_active ? 1 : 0
                visible: opacity > 0
                color: root.bockground_color_accent

                Behavior on x {
                    enabled: root.enabled
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutQuad
                    }
                }

                Behavior on opacity {
                    enabled: root.enabled
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutQuad
                    }
                }
            }
    }

    Behavior on radius { NumberAnimation { duration: root.animation.duration/2; easing.type: Easing.OutCubic } }
}