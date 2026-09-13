import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    id: root

    readonly property string laptopOutputName: "eDP-1"
    // Connector names change between HDMI, DisplayPort, and docks.
    readonly property string lgOutputName: {
        for (const screen of Quickshell.screens) {
            if (screen.serialNumber === "303NTHM4B113"
                || screen.model.indexOf("LG HDR QHD") !== -1)
                return screen.name;
        }
        return "";
    }

    property int laptopPercent: -1
    property int lgPercent: -1
    property int laptopCurrentPercent: -1
    property int lgCurrentPercent: -1
    property int lgMaximum: 100
    property bool lgAvailable: false

    property int pendingLaptopPercent: laptopPercent
    property int pendingLgPercent: lgPercent
    property bool laptopPending: false
    property bool lgPending: false
    property int laptopConfirmAttempts: 0
    property int lgConfirmAttempts: 0

    function parseLaptopBrightness(text) {
        const parts = text.trim().split(",");
        if (parts.length >= 4) {
            const percent = parts[3].replace("%", "").trim();
            if (percent.length > 0) {
                root.acceptLaptopBrightness(Math.round(Number(percent)));
                return;
            }
        }

        const rawValue = text.trim();
        const numeric = Number(rawValue);
        if (rawValue.length > 0 && Number.isFinite(numeric))
            root.acceptLaptopBrightness(Math.round(numeric));
        else
            root.rejectLaptopBrightness();
    }

    function rejectLaptopBrightness() {
        if (root.laptopPending && root.laptopConfirmAttempts < 5) {
            laptopConfirmTimer.restart();
        } else if (root.laptopPending) {
            root.laptopPercent = root.laptopCurrentPercent;
            root.laptopPending = false;
        } else {
            root.laptopPercent = -1;
        }
    }

    function acceptLaptopBrightness(actualPercent) {
        root.laptopCurrentPercent = actualPercent;

        if (!root.laptopPending) {
            root.laptopPercent = actualPercent;
            return;
        }

        if (Math.abs(actualPercent - root.pendingLaptopPercent) <= 1) {
            root.laptopPercent = actualPercent;
            root.laptopPending = false;
        } else if (root.laptopConfirmAttempts < 5) {
            laptopConfirmTimer.restart();
        } else {
            root.laptopPercent = actualPercent;
            root.laptopPending = false;
        }
    }

    function parseLgBrightness(text) {
        const match = text.match(/VCP\s+10\s+C\s+(\d+)\s+(\d+)/);
        if (!match) {
            if (root.lgPending && root.lgConfirmAttempts < 5) {
                lgConfirmTimer.restart();
            } else if (root.lgPending) {
                root.lgPercent = root.lgCurrentPercent;
                root.lgPending = false;
            } else {
                root.lgAvailable = false;
                root.lgPercent = -1;
            }
            return;
        }

        const current = Number(match[1]);
        const maximum = Number(match[2]);
        root.lgMaximum = Math.max(1, maximum);
        root.acceptLgBrightness(Math.round(current * 100 / root.lgMaximum));
        root.lgAvailable = true;
    }

    function acceptLgBrightness(actualPercent) {
        root.lgCurrentPercent = actualPercent;

        if (!root.lgPending) {
            root.lgPercent = actualPercent;
            return;
        }

        if (Math.abs(actualPercent - root.pendingLgPercent) <= 1) {
            root.lgPercent = actualPercent;
            root.lgPending = false;
        } else if (root.lgConfirmAttempts < 5) {
            lgConfirmTimer.restart();
        } else {
            root.lgPercent = actualPercent;
            root.lgPending = false;
        }
    }

    function queryLaptop() {
        if (!laptopQuery.running && !laptopSetter.running)
            laptopQuery.exec(["brightnessctl", "-d", "amdgpu_bl1", "-m"]);
    }

    function queryLg() {
        if (!lgQuery.running && !lgSetter.running) {
            lgQuery.exec([
                "ddcutil", "--model", "LG HDR QHD",
                "getvcp", "10", "--terse"
            ]);
        }
    }

    function refresh() {
        root.queryLaptop();
        root.queryLg();
    }

    function supportsOutput(outputName) {
        return outputName === root.laptopOutputName
            || outputName === root.lgOutputName;
    }

    function queryOutput(outputName) {
        if (outputName === root.laptopOutputName)
            root.queryLaptop();
        else if (outputName === root.lgOutputName)
            root.queryLg();
    }

    function setOutput(outputName, value) {
        if (outputName === root.laptopOutputName)
            root.setLaptop(value);
        else if (outputName === root.lgOutputName)
            root.setLg(value);
    }

    function setLaptop(value) {
        root.pendingLaptopPercent = Math.round(value);
        root.laptopPercent = root.pendingLaptopPercent;
        root.laptopPending = true;
        root.laptopConfirmAttempts = 0;
        laptopSetTimer.restart();
    }

    function setLg(value) {
        root.pendingLgPercent = Math.round(value);
        root.lgPercent = root.pendingLgPercent;
        root.lgPending = true;
        root.lgConfirmAttempts = 0;
        lgSetTimer.restart();
    }

    Timer {
        running: true
        repeat: true
        interval: 2000
        triggeredOnStart: true
        onTriggered: root.queryLaptop()
    }

    Timer {
        running: true
        repeat: true
        interval: 10000
        triggeredOnStart: true
        onTriggered: root.queryLg()
    }

    Timer {
        id: laptopSetTimer
        interval: 80
        onTriggered: {
            if (laptopQuery.running || laptopSetter.running) {
                restart();
                return;
            }

            laptopSetter.exec([
                "brightnessctl",
                "-d",
                "amdgpu_bl1",
                "set",
                `${root.pendingLaptopPercent}%`
            ]);
        }
    }

    Timer {
        id: lgSetTimer
        interval: 250
        onTriggered: {
            if (lgQuery.running || lgSetter.running) {
                restart();
                return;
            }

            const rawValue = Math.round(
                root.pendingLgPercent * root.lgMaximum / 100
            );
            lgSetter.exec([
                "ddcutil", "--model", "LG HDR QHD",
                "setvcp", "10", rawValue.toString()
            ]);
        }
    }

    Timer {
        id: laptopConfirmTimer
        interval: 120
        onTriggered: {
            if (laptopQuery.running || laptopSetter.running) {
                restart();
                return;
            }

            root.laptopConfirmAttempts++;
            root.queryLaptop();
        }
    }

    Timer {
        id: lgConfirmTimer
        interval: 350
        onTriggered: {
            if (lgQuery.running || lgSetter.running) {
                restart();
                return;
            }

            root.lgConfirmAttempts++;
            root.queryLg();
        }
    }

    Process {
        id: laptopQuery
        stdout: StdioCollector {
            onStreamFinished: root.parseLaptopBrightness(this.text)
        }
    }

    Process {
        id: laptopSetter
        onExited: laptopConfirmTimer.restart()
    }

    Process {
        id: lgQuery
        stdout: StdioCollector {
            onStreamFinished: root.parseLgBrightness(this.text)
        }
    }

    Process {
        id: lgSetter
        onExited: lgConfirmTimer.restart()
    }
}
