import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

SquirclePanel {
    id: root

    height: 32
    horizontalPadding: 5
    verticalPadding: 5
    radius: 13
    power: 4.6

    RowLayout {
        anchors.centerIn: parent
        spacing: 3

        Repeater {
            model: SystemTray.items

            delegate: Item {
                id: trayItem

                required property SystemTrayItem modelData

                width: 22
                height: 22

                QsMenuAnchor {
                    id: menuAnchor
                    menu: trayItem.modelData.menu
                    anchor.item: trayItem
                    anchor.edges: Edges.Bottom | Edges.Right
                    anchor.gravity: Edges.Bottom | Edges.Left
                }

                IconImage {
                    anchors.centerIn: parent
                    width: 18
                    height: 18
                    source: trayItem.modelData.icon
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                    cursorShape: Qt.PointingHandCursor

                    onClicked: event => {
                        if (event.button === Qt.RightButton) {
                            if (trayItem.modelData.hasMenu && !menuAnchor.visible)
                                menuAnchor.open();
                        } else if (event.button === Qt.MiddleButton) {
                            trayItem.modelData.secondaryActivate();
                        } else if (trayItem.modelData.onlyMenu && trayItem.modelData.hasMenu) {
                            if (!menuAnchor.visible)
                                menuAnchor.open();
                        } else {
                            trayItem.modelData.activate();
                        }
                    }

                    onWheel: wheel => trayItem.modelData.scroll(wheel.angleDelta.y, false)
                }
            }
        }

        Text {
            visible: SystemTray.items.values.length === 0
            text: "tray"
            color: "#cfcfcf"
            font.family: "Noto Sans"
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
        }
    }
}
