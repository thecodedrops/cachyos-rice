pragma ComponentBehavior: Bound

import QtQuick

ClickableButton {
    id: root

    property color border_color_idle: root.border_color
    property color border_color_active: Qt.alpha(root.ink_color_active, 1)

    property bool persist_border_color: true

    readonly property color effective_active_border_color: (persist_border_color && active) ? border_color_active : (hovered) ? border_color_active : border_color_idle
    readonly property color effective_border_color: (is_active) ? effective_active_border_color : (enabled) ? border_color_idle : root.muted_color

    background: Rectangle {
        radius: root.radius
        color: root.background_color

        border.width: root.border_width
        border.color: root.effective_border_color

        Behavior on border.color { ColorAnimation { duration: root.animation.duration } }
    }

    Behavior on radius { NumberAnimation { duration: root.animation.duration/2; easing.type: Easing.OutCubic } }
}