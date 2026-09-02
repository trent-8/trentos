import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root

    property int topEmptySpace: 3
    property int rightEmptySpace: 3
    property int bottomEmptySpace: 0
    property int leftEmptySpace: 3

    readonly property int sectionHeight: Math.max(
        appMenu.implicitHeight,
        workspaces.implicitHeight,
        clock.implicitHeight,
        tray.implicitHeight,
        systemInfo.implicitHeight
    )

    color: "transparent"
    implicitHeight: topEmptySpace + sectionHeight + bottomEmptySpace
    exclusiveZone: implicitHeight
    WlrLayershell.namespace: "trentos-bar"

    anchors {
        left: true
        right: true
        top: true
    }

    Item {
        anchors.fill: parent
        anchors.topMargin: root.topEmptySpace
        anchors.rightMargin: root.rightEmptySpace
        anchors.bottomMargin: root.bottomEmptySpace
        anchors.leftMargin: root.leftEmptySpace

        RowLayout {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            AppMenu {
                id: appMenu
                height: root.sectionHeight
                Layout.preferredHeight: root.sectionHeight
            }

            Workspaces {
                id: workspaces
                height: root.sectionHeight
                Layout.preferredHeight: root.sectionHeight
            }
        }

        Clock {
            id: clock
            anchors.centerIn: parent
            height: root.sectionHeight
        }

        RowLayout {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            Tray {
                id: tray
                height: root.sectionHeight
                Layout.preferredHeight: root.sectionHeight
            }

            SystemInfo {
                id: systemInfo
                height: root.sectionHeight
                Layout.preferredHeight: root.sectionHeight
            }
        }
    }
}
