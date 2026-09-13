import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root

    required property var brightnessService

    property int topEmptySpace: 0
    property int rightEmptySpace: 1
    property int bottomEmptySpace: 0
    property int leftEmptySpace: 0

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

    Rectangle {
        anchors.fill: parent
        color: "#80303030"

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
            spacing: 0

            AppMenu {
                id: appMenu
                backgroundVisible: false
                height: root.sectionHeight
                Layout.preferredHeight: root.sectionHeight
            }

            Workspaces {
                id: workspaces
                backgroundVisible: false
                height: root.sectionHeight
                Layout.preferredHeight: root.sectionHeight
            }
        }

        Clock {
            id: clock
            backgroundVisible: false
            anchors.centerIn: parent
            height: root.sectionHeight
        }

        RowLayout {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            Tray {
                id: tray
                backgroundVisible: false
                height: root.sectionHeight
                Layout.preferredHeight: root.sectionHeight
            }

            SystemInfo {
                id: systemInfo
                backgroundVisible: false
                height: root.sectionHeight
                Layout.preferredHeight: root.sectionHeight
                brightnessService: root.brightnessService
                outputName: root.screen ? root.screen.name : ""
            }
        }
    }
}
