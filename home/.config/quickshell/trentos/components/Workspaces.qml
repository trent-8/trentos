import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: root

    property int minimumVerticalPadding: 3

    implicitWidth: workspacePanel.implicitWidth
    implicitHeight: workspaceRow.implicitHeight + minimumVerticalPadding * 2

    SquirclePanel {
        id: workspacePanel
        anchors.centerIn: parent
        implicitWidth: workspaceRow.implicitWidth + horizontalPadding * 2
        implicitHeight: workspaceRow.implicitHeight + root.minimumVerticalPadding * 2
        width: implicitWidth
        height: root.height
        horizontalPadding: Math.max(0, (height - workspaceRow.implicitHeight) / 2)
        verticalPadding: horizontalPadding
        radius: 11
        power: 4.6

        RowLayout {
            id: workspaceRow
            anchors.centerIn: parent
            spacing: 2

            Repeater {
                model: Hyprland.workspaces

                delegate: Item {
                    id: workspace

                    required property HyprlandWorkspace modelData

                    readonly property int pillHeight: Math.ceil(workspaceLabel.implicitHeight) + 6
                    readonly property int pillRadius: Math.ceil(pillHeight / 2)

                    visible: modelData.id > 0
                    width: visible ? Math.max(height, Math.ceil(workspaceLabel.implicitWidth + 12)) : 0
                    height: pillHeight

                    Rectangle {
                        anchors.fill: parent
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
}
