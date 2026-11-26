import QtQuick

import Quickshell.Wayland

import qs
import qs.Components

ClickableWithAccent {
    id: root
    required property IdleInhibitor inhibitor
    
    active: inhibitor.enabled || anim_rotation.running

    size: Constants.icon_size
    padding: Constants.padding
    
    vector: "Awake.svg"

    background_color: Constants.control_color_background_default
    ink_color_active: Constants.keepawake_color_active
    ink_color_idle: Constants.keepawake_color_ink_default

    border_color: Constants.control_color_border_default

    onClicked: inhibitor.enabled = !inhibitor.enabled

    contentItem.transform: Rotation {
        origin.x: root.contentItem.width / 2
        origin.y: root.contentItem.height / 2
        
        angle: root.active ? 270 : 0

        Behavior on angle { 
            RotationAnimation { 
                id: anim_rotation 
                duration: Constants.animation_duration 
                easing.type: Easing.InOutQuad 
            } 
        }
    }
}