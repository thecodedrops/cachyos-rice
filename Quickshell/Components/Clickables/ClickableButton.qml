pragma ComponentBehavior: Bound

import QtQuick

ClickableBase {
    id: root
    property int radius: 0
    property int border_width: 1

    property color border_color: Qt.alpha(accent_color, 0.5)
    property color background_color: Qt.alpha(accent_color, 0.05)

    Behavior on radius { NumberAnimation { duration: root.animation.duration/2; easing.type: Easing.OutCubic } }
}