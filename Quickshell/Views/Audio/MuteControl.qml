import QtQuick

import qs
import qs.Services
import qs.Components

ClickableWithAccent {
    readonly property bool muted: PipewireService.defaultMicrophone?.audio?.muted ?? false

    size: Constants.icon_size
    padding: Constants.padding
    radius: Constants.radius

    vector: (muted) ? "Microphone-Off.svg" : "Microphone-On.svg"

    background_color: Constants.control_color_background_default

    border_color: Constants.control_color_border_default
    border_color_active: Qt.alpha(Constants.volume_control_color_ink_default, 0.20)

    ink_color_idle: (muted) ? Constants.volume_control_color_ink_muted : Constants.volume_control_color_ink_default
    ink_color_active: Constants.volume_control_color_ink_active

    onClicked: if (PipewireService.defaultMicrophone.audio) {
        PipewireService.defaultMicrophone.audio.muted = !muted;
    }
}