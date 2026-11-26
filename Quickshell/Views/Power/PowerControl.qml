pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.Components

ClickableWithSweep {    
    size: Constants.icon_size 
    padding: Constants.padding

    vector: "Power.svg"
    
    background_color: Constants.control_color_background_default
    ink_color_active: Constants.power_color_active
    ink_color_idle: Constants.power_color_ink_active

    border_color: Constants.control_color_border_default
}