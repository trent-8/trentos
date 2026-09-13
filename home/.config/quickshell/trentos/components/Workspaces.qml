import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: root

    property int minimumVerticalPadding: 3
    property bool backgroundVisible: true
    property int iconSpacing: 4

    implicitWidth: workspacePanel.implicitWidth
    implicitHeight: workspaceRow.implicitHeight + minimumVerticalPadding * 2

    SquirclePanel {
        id: workspacePanel
        backgroundVisible: root.backgroundVisible
        anchors.centerIn: parent
        implicitWidth: workspaceRow.implicitWidth + horizontalPadding * 2
        implicitHeight: workspaceRow.implicitHeight + root.minimumVerticalPadding * 2
        width: implicitWidth
        height: root.height
        horizontalPadding: 0
        verticalPadding: 0
        radius: 11
        power: 4.6

        RowLayout {
            id: workspaceRow
            anchors.fill: parent
            spacing: 0

            Repeater {
                model: Hyprland.workspaces

                delegate: Item {
                    id: workspace

                    required property HyprlandWorkspace modelData

                    readonly property int pillHeight: Math.ceil(workspaceLabel.implicitHeight) + 6
                    readonly property int pillRadius: Math.ceil(pillHeight / 2)
                    readonly property int pillWidth: Math.max(pillHeight, Math.ceil(workspaceLabel.implicitWidth + 12))

                    visible: modelData.id > 0
                    // Visual gaps belong to the adjacent full-height click targets.
                    implicitWidth: pillWidth + root.iconSpacing
                    implicitHeight: pillHeight
                    Layout.fillHeight: true

                    Rectangle {
                        anchors.centerIn: parent
                        width: workspace.pillWidth
                        height: workspace.pillHeight
                        radius: workspace.pillRadius
                        color: modelData.focused ? "#ccffffff" : modelData.toplevels.values.length > 0 ? "#66323232" : "#33222222"
                        border.color: modelData.focused ? "#ffffffff" : "#55ffffff"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 1
                            radius: Math.max(0, workspace.pillRadius - 1)
                            color: "transparent"
                            border.color: modelData.focused ? "#55ffffff" : "#22ffffff"
                            border.width: 1
                        }

                        Text {
                            id: workspaceLabel
                            anchors.centerIn: parent
                            text: workspace.modelData.name || workspace.modelData.id
                            color: workspace.modelData.focused ? "#181818" : "#ffffff"
                            font.family: "SauceCodePro Nerd Font Mono"
                            font.pixelSize: 12
                            font.weight: Font.DemiBold
                        }

                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: workspace.modelData.activate()
                    }
                }
            }
        }
    }
}
