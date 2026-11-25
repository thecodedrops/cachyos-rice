pragma ComponentBehavior: Bound

import QtQuick

ClickableButton {
    id: root

    readonly property color border_color_base: root.border_color
    readonly property color border_color_accent: Qt.alpha(root.accent_color, 1)

    readonly property color effective_border_color: (is_active) ? border_color_accent : (enabled) ? border_color_base : root.muted_color

    background: Rectangle {
        radius: root.radius
        color: root.background_color

        border.width: root.border_width
        border.color: root.effective_border_color

        Behavior on border.color { ColorAnimation { duration: root.animation.duration } }
    }

    Behavior on radius { NumberAnimation { duration: root.animation.duration/2; easing.type: Easing.OutCubic } }
}