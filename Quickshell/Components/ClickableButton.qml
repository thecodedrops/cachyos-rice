pragma ComponentBehavior: Bound

import QtQuick

import qs

ClickableBase {
    id: root
    property int radius: (active) ? Constants.radius * 1.75 : Constants.radius
    
    property int border_width: 1

    property color border_color: Qt.alpha(ink_color_active, 0.5)
    property color background_color: Qt.alpha(ink_color_active, 0.05)

    Behavior on radius {
        SpringAnimation {
            // Higher spring = faster/tighter snap
            spring: 4.0 
            // Lower damping = more wobble/bouncing before settling (0.0 to 1.0)
            damping: 0.35 
            mass: 1.0
        }
    }
}