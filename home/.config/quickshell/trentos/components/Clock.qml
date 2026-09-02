import QtQuick
import Quickshell

SquirclePanel {
    id: root
    height: 32
    horizontalPadding: 9
    verticalPadding: 2
    radius: 14
    power: 4.6
    implicitWidth: Math.max(timeText.implicitWidth + horizontalPadding * 2, 34)

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        id: timeText
        anchors.centerIn: parent
        text: {
            const d = clock.date;
            const hours = d.getHours();
            const hour12 = hours % 12 === 0 ? 12 : hours % 12;
            const minute = d.getMinutes().toString().padStart(2, "0");
            const suffix = hours >= 12 ? "pm" : "am";
            return `${d.getMonth() + 1}/${d.getDate()}/${d.getFullYear()} ${hour12}:${minute} ${suffix}`;
        }
        color: "#ffffff"
        font.family: "Noto Sans"
        font.pixelSize: 18
        font.weight: Font.Medium
    }
}
