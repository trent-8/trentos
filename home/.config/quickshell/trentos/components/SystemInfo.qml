import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

SquirclePanel {
    id: root
    height: 32
    horizontalPadding: 8
    verticalPadding: 2
    radius: 13
    power: 4.6

    required property var brightnessService
    required property string outputName

    readonly property bool laptopOutput:
        outputName === brightnessService.laptopOutputName
    readonly property bool lgOutput:
        outputName === brightnessService.lgOutputName
    readonly property bool brightnessSupported:
        brightnessService.supportsOutput(outputName)
    readonly property bool brightnessAvailable: laptopOutput
        ? brightnessService.laptopPercent >= 0
        : lgOutput && brightnessService.lgAvailable
    readonly property int brightnessPercent: laptopOutput
        ? brightnessService.laptopPercent
        : lgOutput ? brightnessService.lgPercent : -1
    readonly property string brightnessIcon: laptopOutput ? "󰌢" : "󰍹"
    readonly property string brightnessTitle: laptopOutput
        ? "Laptop brightness" : "LG HDR QHD brightness"
    readonly property color brightnessColor: laptopOutput ? "#e3b341" : "#77bdfb"

    readonly property var audioSink: Pipewire.defaultAudioSink
    readonly property var sinkAudio: audioSink ? audioSink.audio : null
    readonly property int volumePercent: sinkAudio ? Math.round(sinkAudio.volume * 100) : -1
    readonly property bool volumeMuted: sinkAudio ? sinkAudio.muted : false
    readonly property var batteryDevice: UPower.displayDevice
    readonly property bool batteryAvailable: batteryDevice
        && batteryDevice.ready
        && batteryDevice.isPresent
    readonly property int batteryPercent: batteryAvailable ? Math.round(batteryDevice.percentage * 100) : -1
    readonly property bool batteryCharging: batteryAvailable
        && (batteryDevice.state === UPowerDeviceState.Charging
            || batteryDevice.state === UPowerDeviceState.PendingCharge)
    readonly property bool batteryFullPlugged: batteryAvailable
        && !UPower.onBattery
        && batteryDevice.state === UPowerDeviceState.FullyCharged
    readonly property bool batteryDischarging: batteryAvailable
        && UPower.onBattery
        && !batteryCharging
    readonly property real batteryTimeToEmpty: batteryAvailable ? batteryDevice.timeToEmpty : 0
    readonly property real batteryTimeToFull: batteryAvailable ? batteryDevice.timeToFull : 0

    property bool lowBatteryDismissed: false
    property bool criticalBatteryDismissed: false

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
        if (batteryWarningPopup.visible)
            return;

        const shouldOpen = !popup.visible;
        root.closeOtherPopups(popup);
        popup.visible = shouldOpen;
    }

    function updateBatteryWarning() {
        if (!root.batteryDischarging) {
            batteryWarningPopup.visible = false;
            root.lowBatteryDismissed = false;
            root.criticalBatteryDismissed = false;
            return;
        }

        if (root.batteryPercent > 10) {
            batteryWarningPopup.visible = false;
            root.lowBatteryDismissed = false;
            root.criticalBatteryDismissed = false;
            return;
        }

        if (root.batteryPercent > 5) {
            root.criticalBatteryDismissed = false;
            batteryWarningPopup.isCritical = false;
            batteryWarningPopup.visible = !root.lowBatteryDismissed;
            return;
        }

        batteryWarningPopup.isCritical = true;
        batteryWarningPopup.visible = !root.criticalBatteryDismissed;
    }

    onBatteryPercentChanged: Qt.callLater(root.updateBatteryWarning)
    onBatteryDischargingChanged: Qt.callLater(root.updateBatteryWarning)
    Component.onCompleted: Qt.callLater(root.updateBatteryWarning)

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

            visible: root.brightnessSupported
            implicitWidth: 78
            value: root.brightnessAvailable ? root.brightnessPercent : 0
            icon: root.brightnessIcon
            label: root.brightnessAvailable ? `${root.brightnessPercent}%` : "--"
            fillColor: root.laptopOutput ? "#90e3b341" : "#9077bdfb"
            onClicked: root.togglePopup(brightnessPopup)
        }

        BatteryIndicator {
            id: batteryBar

            visible: root.batteryAvailable
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
        title: root.brightnessTitle
        icon: root.brightnessIcon
        value: root.brightnessAvailable ? root.brightnessPercent : 0
        accentColor: root.brightnessColor
        onValueMoved: value => root.brightnessService.setOutput(root.outputName, value)

        onVisibleChanged: {
            if (visible)
                root.brightnessService.queryOutput(root.outputName);
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

    BatteryWarningPopup {
        id: batteryWarningPopup

        anchorItem: batteryBar
        batteryPercent: root.batteryPercent

        onVisibleChanged: {
            if (visible)
                root.closeOtherPopups(null);
        }

        onDismissed: {
            if (isCritical)
                root.criticalBatteryDismissed = true;
            else
                root.lowBatteryDismissed = true;

            visible = false;
        }
    }

}
