//@ pragma UseQApplication
//@ pragma DefaultEnv QT_QPA_PLATFORMTHEME = gtk3

import Quickshell
import "components" as Components
import "services" as Services

ShellRoot {
    Services.BrightnessService {
        id: displayBrightnessService
    }

    Variants {
        model: Quickshell.screens

        Components.Bar {
            required property ShellScreen modelData
            screen: modelData
            brightnessService: displayBrightnessService
        }
    }
}
