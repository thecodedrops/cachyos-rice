pragma ComponentBehavior: Bound

import QtQuick

ClickableButton {
    id: root

    property color border_color_idle: root.border_color
    property color border_color_active: Qt.alpha(root.ink_color_active, 1)

    property color bockground_color_idle: root.background_color
    property color background_color_active: Qt.alpha(root.ink_color_active, 1)

    readonly property color effective_border_color: (is_active) ? Qt.alpha(border_color_idle, 0.01) : (enabled) ? border_color_idle : root.muted_color
    readonly property color effective_background_color: (is_active) ? background_color_active : bockground_color_idle

    effective_ink_color: (is_active) ? ink_color_idle : (enabled) ? ink_color_active : muted_color

    background: Rectangle {
        radius: root.radius
        color: root.effective_background_color

        border.width: root.border_width
        border.color: root.effective_border_color

        Behavior on border.color { ColorAnimation { duration: root.animation.duration } }
        Behavior on color { ColorAnimation { duration: root.animation.duration } }
    }
}