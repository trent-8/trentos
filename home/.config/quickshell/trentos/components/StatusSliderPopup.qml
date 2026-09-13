import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import Quickshell

PopupWindow {
    id: root

    property Item anchorItem
    property string title: ""
    property string icon: ""
    property real value: 0
    property real minimumValue: 0
    property real maximumValue: 100
    property color accentColor: "#77bdfb"
    property real displayedValue: boundedValue(value)

    signal valueMoved(real value)

    function boundedValue(candidate) {
        return Math.max(root.minimumValue, Math.min(candidate, root.maximumValue));
    }

    function followExternalValue() {
        if (!levelSlider.pressed)
            root.displayedValue = root.boundedValue(root.value);
    }

    onValueChanged: followExternalValue()
    onMinimumValueChanged: followExternalValue()
    onMaximumValueChanged: followExternalValue()

    anchor.item: root.anchorItem
    anchor.edges: Edges.Bottom | Edges.Right
    anchor.gravity: Edges.Bottom | Edges.Left
    anchor.margins.bottom: -10

    implicitWidth: 248
    implicitHeight: 96
    color: "transparent"
    grabFocus: true

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
            spacing: 8

            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    text: root.icon
                    color: root.accentColor
                    font.family: "SauceCodePro Nerd Font Mono"
                    font.pixelSize: 18
                }

                Text {
                    Layout.fillWidth: true
                    text: root.title
                    color: "#f4f4f4"
                    font.family: "Noto Sans"
                    font.pixelSize: 13
                    font.weight: Font.DemiBold
                }

                Text {
                    text: `${Math.round(levelSlider.value)}%`
                    color: "#e8e8e8"
                    font.family: "Noto Sans"
                    font.pixelSize: 12
                    font.weight: Font.DemiBold
                }
            }

            Controls.Slider {
                id: levelSlider

                Layout.fillWidth: true
                from: root.minimumValue
                to: root.maximumValue
                value: root.displayedValue
                live: true

                onMoved: {
                    root.displayedValue = value;
                    root.valueMoved(value);
                }

                background: Rectangle {
                    x: levelSlider.leftPadding
                        + (levelSlider.handle.width - implicitHeight) / 2
                    y: levelSlider.topPadding + levelSlider.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 6
                    width: levelSlider.availableWidth
                        - levelSlider.handle.width + implicitHeight
                    height: implicitHeight
                    radius: height / 2
                    color: "#4dffffff"

                    Rectangle {
                        width: levelSlider.visualPosition * parent.width
                        height: parent.height
                        radius: height / 2
                        color: root.accentColor
                    }
                }

                handle: Rectangle {
                    x: levelSlider.leftPadding
                        + levelSlider.visualPosition * (levelSlider.availableWidth - width)
                    y: levelSlider.topPadding + levelSlider.availableHeight / 2 - height / 2
                    implicitWidth: 18
                    implicitHeight: 18
                    radius: 9
                    color: levelSlider.pressed ? root.accentColor : "#f5f5f5"
                    border.width: 1
                    border.color: "#66000000"

                    Behavior on color {
                        ColorAnimation { duration: 100 }
                    }
                }
            }
        }
    }
}
