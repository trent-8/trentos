import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

SquirclePanel {
    id: root
    height: 32
    horizontalPadding: 8
    verticalPadding: 2
    radius: 13
    power: 4.6

    property int brightnessPercent: -1

    readonly property var audioSink: Pipewire.defaultAudioSink
    readonly property var sinkAudio: audioSink ? audioSink.audio : null
    readonly property int volumePercent: sinkAudio ? Math.round(sinkAudio.volume * 100) : -1
    readonly property bool volumeMuted: sinkAudio ? sinkAudio.muted : false
    readonly property var batteryDevice: UPower.displayDevice
    readonly property bool batteryAvailable: batteryDevice && batteryDevice.ready
    readonly property int batteryPercent: batteryAvailable ? Math.round(batteryDevice.percentage * 100) : -1
    readonly property bool batteryCharging: batteryAvailable
        && (batteryDevice.state === UPowerDeviceState.Charging
            || batteryDevice.state === UPowerDeviceState.PendingCharge)
    readonly property bool batteryFullPlugged: batteryAvailable
        && !UPower.onBattery
        && batteryDevice.state === UPowerDeviceState.FullyCharged
    readonly property real batteryTimeToEmpty: batteryAvailable ? batteryDevice.timeToEmpty : 0
    readonly property real batteryTimeToFull: batteryAvailable ? batteryDevice.timeToFull : 0

    property int pendingBrightness: brightnessPercent

    function parseBrightness(text) {
        const parts = text.trim().split(",");
        if (parts.length >= 4) {
            const percent = parts[3].replace("%", "").trim();
            if (percent.length > 0) {
                root.brightnessPercent = Math.round(Number(percent));
                return;
            }
        }

        const numeric = Number(text.trim());
        root.brightnessPercent = Number.isFinite(numeric) ? Math.round(numeric) : -1;
    }

    function volumeIcon() {
        if (root.volumeMuted || root.volumePercent === 0)
            return "󰖁";
        if (root.volumePercent < 35)
            return "󰕿";
        if (root.volumePercent < 70)
            return "󰖀";
        return "󰕾";
    }

    function closeOtherPopups(exceptPopup) {
        if (volumePopup !== exceptPopup)
            volumePopup.visible = false;
        if (brightnessPopup !== exceptPopup)
            brightnessPopup.visible = false;
        if (powerPopup !== exceptPopup)
            powerPopup.visible = false;
    }

    function togglePopup(popup) {
        const shouldOpen = !popup.visible;
        root.closeOtherPopups(popup);
        popup.visible = shouldOpen;
    }

    PwObjectTracker {
        objects: [root.audioSink]
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: 10

        LevelBar {
            id: volumeBar

            value: root.volumeMuted ? 0 : root.volumePercent
            icon: root.volumeIcon()
            label: root.volumePercent >= 0 ? `${root.volumePercent}%` : "--"
            fillColor: root.volumeMuted ? "#556b7280" : "#9077bdfb"
            onClicked: root.togglePopup(volumePopup)
        }

        LevelBar {
            id: brightnessBar

            value: root.brightnessPercent
            icon: ""
            label: root.brightnessPercent >= 0 ? `${root.brightnessPercent}%` : "--"
            fillColor: "#90e3b341"
            onClicked: root.togglePopup(brightnessPopup)
        }

        BatteryIndicator {
            id: batteryBar

            value: root.batteryPercent
            charging: root.batteryCharging
            fullPlugged: root.batteryFullPlugged
            onClicked: root.togglePopup(powerPopup)
        }
    }

    StatusSliderPopup {
        id: volumePopup

        anchorItem: volumeBar
        title: root.volumeMuted ? "Volume · Muted" : "Volume"
        icon: root.volumeIcon()
        value: root.volumeMuted ? 0 : root.volumePercent
        accentColor: "#77bdfb"

        onValueMoved: value => {
            if (root.sinkAudio) {
                root.sinkAudio.muted = false;
                root.sinkAudio.volume = value / 100;
            }
        }
    }

    StatusSliderPopup {
        id: brightnessPopup

        anchorItem: brightnessBar
        title: "Brightness"
        icon: ""
        value: root.brightnessPercent
        accentColor: "#e3b341"

        onValueMoved: value => {
            root.pendingBrightness = Math.round(value);
            brightnessSetTimer.restart();
        }
    }

    PowerPopup {
        id: powerPopup

        anchorItem: batteryBar
        batteryAvailable: root.batteryAvailable
        batteryPercent: root.batteryPercent
        charging: root.batteryCharging
        fullyCharged: root.batteryFullPlugged
        timeToEmpty: root.batteryTimeToEmpty
        timeToFull: root.batteryTimeToFull
    }

    Timer {
        running: true
        repeat: true
        interval: 2000
        triggeredOnStart: true
        onTriggered: {
            brightnessProc.exec(["brightnessctl", "-m"]);
        }
    }

    Timer {
        id: brightnessSetTimer
        interval: 80
        onTriggered: brightnessSetProc.exec([
            "brightnessctl",
            "set",
            `${root.pendingBrightness}%`
        ])
    }

    Process {
        id: brightnessProc
        stdout: StdioCollector {
            onStreamFinished: root.parseBrightness(this.text)
        }
    }

    Process {
        id: brightnessSetProc
        onExited: brightnessProc.exec(["brightnessctl", "-m"])
    }
}
