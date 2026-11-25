pragma ComponentBehavior: Bound

import QtQuick

ClickableButton {
    id: root

    readonly property color border_color_base: root.border_color
    readonly property color border_color_accent: Qt.alpha(root.accent_color, 1)

    readonly property color bockground_color_base: root.background_color
    readonly property color bockground_color_accent: Qt.alpha(root.accent_color, 1)

    readonly property color effective_border_color: (enabled) ? border_color_base : root.muted_color
    readonly property color effective_background_color: (is_active) ? bockground_color_accent : (enabled) ? bockground_color_base : root.muted_color

    effective_ink_color: (is_active) ? ink_color : (enabled) ? accent_color : muted_color

    background: Rectangle {
        radius: root.radius
        color: root.effective_background_color

        border.width: root.border_width
        border.color: root.effective_border_color

        Behavior on border.color { ColorAnimation { duration: root.animation.duration } }
        Behavior on color { ColorAnimation { duration: root.animation.duration } }
    }

    Behavior on radius { NumberAnimation { duration: root.animation.duration/2; easing.type: Easing.OutCubic } }
}