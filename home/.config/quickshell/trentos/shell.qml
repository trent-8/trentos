//@ pragma UseQApplication
//@ pragma DefaultEnv QT_QPA_PLATFORMTHEME = gtk3

import Quickshell
import "components" as Components

ShellRoot {
    Variants {
        model: Quickshell.screens

        Components.Bar {
            required property ShellScreen modelData
            screen: modelData
        }
    }
}
