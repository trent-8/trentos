import QtQuick
import QtQuick.Layouts
import Quickshell

PopupWindow {
    id: root

    property Item anchorItem
    property int batteryPercent: -1
    property bool isCritical: false

    signal dismissed

    anchor.item: root.anchorItem
    anchor.edges: Edges.Bottom | Edges.Right
    anchor.gravity: Edges.Bottom | Edges.Left
    anchor.margins.bottom: -10

    implicitWidth: 360
    implicitHeight: 112
    color: "transparent"
    grabFocus: false

    readonly property color accentColor: isCritical ? "#ff625f" : "#f0b84b"

    SquirclePanel {
        anchors.fill: parent
        horizontalPadding: 14
        verticalPadding: 12
        radius: 18
        power: 4.6
        fillColor: "#f2252525"
        borderColor: root.accentColor
        highlightColor: "#44ffffff"
        borderWidth: 1

        RowLayout {
            anchors.fill: parent
            spacing: 12

            SquirclePanel {
                Layout.preferredWidth: 42
                Layout.preferredHeight: 42
                Layout.alignment: Qt.AlignVCenter
                horizontalPadding: 0
                verticalPadding: 0
                radius: 14
                power: 4.6
                fillColor: root.isCritical ? "#40ff625f" : "#38f0b84b"
                borderColor: root.accentColor
                borderWidth: 1
                highlightColor: "#22ffffff"

                Text {
                    anchors.centerIn: parent
                    text: "!"
                    color: root.accentColor
                    font.family: "Noto Sans"
                    font.pixelSize: 23
                    font.weight: Font.Bold
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                spacing: 3

                Text {
                    Layout.fillWidth: true
                    text: root.isCritical
                        ? `Critical battery · ${root.batteryPercent}%`
                        : `Low battery · ${root.batteryPercent}%`
                    color: "#f4f4f4"
                    font.family: "Noto Sans"
                    font.pixelSize: 13
                    font.weight: Font.DemiBold
                }

                Text {
                    Layout.fillWidth: true
                    text: root.isCritical
                        ? "Connect power now to avoid automatic sleep."
                        : "Connect power soon."
                    color: "#c9c9c9"
                    font.family: "Noto Sans"
                    font.pixelSize: 11
                    wrapMode: Text.WordWrap
                }
            }

            SquirclePanel {
                id: dismissButton

                Layout.preferredWidth: 76
                Layout.preferredHeight: 34
                Layout.alignment: Qt.AlignVCenter
                horizontalPadding: 0
                verticalPadding: 0
                radius: 12
                power: 4.6
                fillColor: dismissMouse.pressed
                    ? "#42ffffff"
                    : dismissMouse.containsMouse ? "#30ffffff" : "#1cffffff"
                borderColor: "#55ffffff"
                borderWidth: 1
                highlightColor: dismissMouse.containsMouse ? "#22ffffff" : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: "Dismiss"
                    color: "#f4f4f4"
                    font.family: "Noto Sans"
                    font.pixelSize: 11
                    font.weight: Font.DemiBold
                }

                MouseArea {
                    id: dismissMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.dismissed()
                }

                Behavior on fillColor {
                    ColorAnimation { duration: 100 }
                }
            }
        }
    }
}
