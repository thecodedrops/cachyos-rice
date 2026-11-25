pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.Components

ClickableWithAccent {
    size: Constants.icon_size
    padding: Constants.padding
    radius: Constants.icon_size

    vector: "Desktop.svg"

    background_color: Constants.control_color_background_default
    border_color: Constants.control_color_border_default
    ink_color_idle: Constants.display_control_color_ink_default
    ink_color_active: Constants.display_control_color_active
}