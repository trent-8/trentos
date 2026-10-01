import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

PopupWindow {
    id: root

    property Item anchorItem
    property bool batteryAvailable: false
    property int batteryPercent: -1
    property bool charging: false
    property bool fullyCharged: false
    property real timeToEmpty: 0
    property real timeToFull: 0
    property string pendingAction: ""

    anchor.item: root.anchorItem
    anchor.edges: Edges.Bottom | Edges.Right
    anchor.gravity: Edges.Bottom | Edges.Left
    anchor.margins.bottom: -10

    implicitWidth: 302
    implicitHeight: 150
    color: "transparent"
    grabFocus: true

    function formatDuration(seconds) {
        if (!Number.isFinite(seconds) || seconds <= 0)
            return "";

        const totalMinutes = Math.max(1, Math.round(seconds / 60));
        const hours = Math.floor(totalMinutes / 60);
        const minutes = totalMinutes % 60;

        if (hours === 0)
            return `${minutes} min`;
        if (minutes === 0)
            return `${hours} hr`;
        return `${hours} hr ${minutes} min`;
    }

    function batteryDetail() {
        if (!root.batteryAvailable)
            return "Battery information unavailable";
        if (root.fullyCharged)
            return "Fully charged";

        const remaining = root.charging
            ? root.formatDuration(root.timeToFull)
            : root.formatDuration(root.timeToEmpty);

        if (remaining.length === 0)
            return root.charging ? "Charging · Calculating time" : "Calculating time remaining";
        return root.charging ? `${remaining} until full` : `${remaining} remaining`;
    }

    function requestAction(action) {
        if (root.pendingAction !== action) {
            root.pendingAction = action;
            confirmTimer.restart();
            return;
        }

        root.visible = false;
        root.pendingAction = "";

        if (action === "poweroff")
            actionProcess.exec(["systemctl", "poweroff"]);
        else if (action === "reboot")
            actionProcess.exec(["systemctl", "reboot"]);
        else
            actionProcess.exec(["hyprctl", "dispatch", "exit"]);
    }

    onVisibleChanged: {
        if (!visible) {
            pendingAction = "";
            confirmTimer.stop();
        }
    }

    SquirclePanel {
        anchors.fill: parent
        horizontalPadding: 14
        verticalPadding: 12
        radius: 18
        power: 4.6
        fillColor: "#ee252525"
        borderColor: "#55ffffff"
        highlightColor: "#44ffffff"
        borderWidth: 1

        ColumnLayout {
            anchors.fill: parent
            spacing: 12

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                BatteryIndicator {
                    value: root.batteryPercent
                    charging: root.charging
                    fullPlugged: root.fullyCharged
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 1

                    Text {
                        text: root.batteryAvailable
                            ? `Battery · ${root.batteryPercent}%`
                            : "Battery"
                        color: "#f4f4f4"
                        font.family: "Noto Sans"
                        font.pixelSize: 13
                        font.weight: Font.DemiBold
                    }

                    Text {
                        text: root.batteryDetail()
                        color: "#bdbdbd"
                        font.family: "Noto Sans"
                        font.pixelSize: 11
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 7

                Repeater {
                    model: [
                        { "action": "poweroff", "icon": "", "label": "Power off" },
                        { "action": "reboot", "icon": "", "label": "Restart" },
                        { "action": "logout", "icon": "󰍃", "label": "Log out" }
                    ]

                    delegate: SquirclePanel {
                        id: actionButton

                        required property var modelData

                        Layout.fillWidth: true
                        implicitHeight: 55
                        horizontalPadding: 0
                        verticalPadding: 0
                        radius: 15
                        power: 4.6
                        fillColor: actionMouse.pressed
                            ? "#3dffffff"
                            : actionMouse.containsMouse ? "#28ffffff" : "#16ffffff"
                        borderWidth: root.pendingAction === modelData.action ? 1 : 0
                        borderColor: modelData.action === "poweroff" ? "#ff7b72" : "#77bdfb"
                        highlightColor: actionMouse.containsMouse ? "#22ffffff" : "transparent"

                        Column {
                            anchors.centerIn: parent
                            spacing: 2

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: actionButton.modelData.icon
                                color: actionButton.modelData.action === "poweroff"
                                    ? "#ff938a" : "#eeeeee"
                                font.family: "SauceCodePro Nerd Font Mono"
                                font.pixelSize: 17
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: root.pendingAction === actionButton.modelData.action
                                    ? "Confirm?"
                                    : actionButton.modelData.label
                                color: "#eeeeee"
                                font.family: "Noto Sans"
                                font.pixelSize: 10
                                font.weight: Font.Medium
                            }
                        }

                        MouseArea {
                            id: actionMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.requestAction(actionButton.modelData.action)
                        }

                        Behavior on fillColor {
                            ColorAnimation { duration: 100 }
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: confirmTimer
        interval: 4000
        onTriggered: root.pendingAction = ""
    }

    Process {
        id: actionProcess
    }
}
