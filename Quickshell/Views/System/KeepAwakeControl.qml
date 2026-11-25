import QtQuick

import Quickshell.Wayland

import qs
import qs.Components

ClickableWithFade {
    required property IdleInhibitor inhibitor
    
    active: inhibitor.enabled || anim_rotation.running

    id: keepawake
    size: Constants.icon_size
    padding: Constants.padding
    
    radius: (inhibitor.enabled) ? Constants.icon_size : Constants.radius

    vector: "Awake.svg"

    background_color: Constants.control_color_background_default
    ink_color_active: Constants.keepawake_color_active
    ink_color_idle: Constants.keepawake_color_ink_active

    border_color: Constants.control_color_border_default

    onClicked: inhibitor.enabled = !inhibitor.enabled

    // Rotate the whole component
    rotation: inhibitor.enabled ? 270 : 0
    transformOrigin: Item.Center

    Behavior on rotation { 
        RotationAnimation { 
            id: anim_rotation 
            duration: Constants.animation_duration 
            easing.type: Easing.InOutQuad 
        } 
    }
}