import QtQuick
import Quickshell
import Quickshell.Io

SquirclePanel {
    id: root
    implicitWidth: Math.max(iconMetrics.tightBoundingRect.width + horizontalPadding * 2, 34)
    implicitHeight: iconMetrics.tightBoundingRect.height + verticalPadding * 2
    width: implicitWidth
    height: implicitHeight
    horizontalPadding: 3
    verticalPadding: 0
    radius: 11
    power: 4.6

    TextMetrics {
        id: iconMetrics
        text: "󰀻"
        font.family: "SauceCodePro NF"
        font.pixelSize: 20
        font.weight: Font.Normal
    }

    Text {
        id: menuIcon
        x: (parent.width - iconMetrics.tightBoundingRect.width) / 2 - iconMetrics.tightBoundingRect.x
        y: (parent.height - iconMetrics.tightBoundingRect.height) / 2 - baselineOffset - iconMetrics.tightBoundingRect.y
        text: iconMetrics.text
        color: "#ffffff"
        font: iconMetrics.font
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: launcher.startDetached()
        onEntered: root.fillColor = "#99505050"
        onExited: root.fillColor = "#80323232"
    }

    Process {
        id: launcher
        command: ["sh", "-c", "pidof wofi >/dev/null && pkill wofi || wofi -t=alacritty -S drun -I -n -W 300 -H 700"]
    }
}
