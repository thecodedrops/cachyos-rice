pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.Components

ClickableWithFade {    
    size: Constants.icon_size 
    padding: Constants.padding
    radius: (active) ? Constants.radius_active : Constants.radius

    vector: "Power.svg"
    
    background_color: Constants.control_color_background_default
    ink_color_active: Constants.power_color_active
    ink_color_idle: Constants.power_color_ink_active

    border_color: Constants.control_color_border_default

    Behavior on radius { NumberAnimation { duration: Constants.animation_duration/4; easing.type: Easing.OutCubic } }
}