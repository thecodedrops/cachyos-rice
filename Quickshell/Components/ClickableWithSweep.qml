pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Widgets

import qs

ClickableButton {
    id: root
    radius: Constants.radius

    readonly property color border_color_idle: root.border_color
    readonly property color border_color_active: Qt.alpha(root.ink_color_active, 1)

    readonly property color bockground_color_idle: root.background_color
    readonly property color background_color_active: Qt.alpha(root.ink_color_active, 1)

    readonly property color effective_border_color: (enabled) ? border_color_idle : root.muted_color
    readonly property color effective_background_color: (is_active) ? background_color_active : (enabled) ? bockground_color_idle : root.muted_color

    effective_ink_color: (is_active) ? ink_color_idle : (enabled) ? ink_color_active : muted_color

    background: ClippingRectangle {
        radius: root.radius
        color: root.bockground_color_idle

        border.width: root.border_width
        border.color: root.border_color_idle

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
                color: root.background_color_active

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