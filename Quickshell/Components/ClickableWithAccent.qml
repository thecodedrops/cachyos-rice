pragma ComponentBehavior: Bound

import QtQuick

import qs

ClickableButton {
    id: root
    radius: Constants.radius

    property color border_color_idle: root.border_color
    property color border_color_active: Qt.alpha(root.ink_color_active, 1)

    readonly property color effective_border_color: (is_active) ? border_color_active : (enabled) ? border_color_idle : root.muted_color

    background: Rectangle {
        radius: root.radius
        color: root.background_color

        border.width: root.border_width
        border.color: root.effective_border_color

        Behavior on border.color { ColorAnimation { duration: root.animation.duration } }
    }

    Behavior on radius { NumberAnimation { duration: root.animation.duration/2; easing.type: Easing.OutCubic } }
}