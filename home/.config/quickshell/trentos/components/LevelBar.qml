import QtQuick

Item {
    id: root

    signal clicked

    property real value: 0
    property real maximumValue: 100
    property string icon: ""
    property string label: ""
    property color trackColor: "#40202020"
    property color fillColor: "#8077bdfb"
    property color borderColor: "#55ffffff"
    property color textColor: "#ffffff"

    readonly property real progress: maximumValue > 0
        ? Math.max(0, Math.min(value / maximumValue, 1))
        : 0
    readonly property bool hovered: mouseArea.containsMouse
    property real animatedProgress: progress

    implicitWidth: 88
    implicitHeight: 22

    Behavior on animatedProgress {
        NumberAnimation {
            duration: 140
            easing.type: Easing.OutCubic
        }
    }

    Canvas {
        id: barCanvas

        anchors.fill: parent
        antialiasing: true

        function roundedPath(ctx, x, y, width, height, radius) {
            const right = x + width;
            const bottom = y + height;
            const r = Math.max(0, Math.min(radius, width / 2, height / 2));

            ctx.beginPath();
            ctx.moveTo(x + r, y);
            ctx.lineTo(right - r, y);
            ctx.quadraticCurveTo(right, y, right, y + r);
            ctx.lineTo(right, bottom - r);
            ctx.quadraticCurveTo(right, bottom, right - r, bottom);
            ctx.lineTo(x + r, bottom);
            ctx.quadraticCurveTo(x, bottom, x, bottom - r);
            ctx.lineTo(x, y + r);
            ctx.quadraticCurveTo(x, y, x + r, y);
            ctx.closePath();
        }

        onPaint: {
            const ctx = getContext("2d");
            const inset = 0.5;
            const x = inset;
            const y = inset;
            const barWidth = Math.max(0, width - inset * 2);
            const barHeight = Math.max(0, height - inset * 2);
            const radius = barHeight / 2;

            ctx.reset();
            ctx.clearRect(0, 0, width, height);

            roundedPath(ctx, x, y, barWidth, barHeight, radius);
            ctx.fillStyle = root.trackColor;
            ctx.fill();

            ctx.save();
            roundedPath(ctx, x, y, barWidth, barHeight, radius);
            ctx.clip();
            ctx.fillStyle = root.fillColor;
            ctx.fillRect(x, y, barWidth * root.animatedProgress, barHeight);
            ctx.restore();

            roundedPath(ctx, x, y, barWidth, barHeight, radius);
            ctx.lineWidth = 1;
            ctx.strokeStyle = root.borderColor;
            ctx.stroke();

            if (root.hovered) {
                roundedPath(ctx, x, y, barWidth, barHeight, radius);
                ctx.fillStyle = "#18ffffff";
                ctx.fill();
            }
        }

        Connections {
            target: root
            function onAnimatedProgressChanged() { barCanvas.requestPaint(); }
            function onTrackColorChanged() { barCanvas.requestPaint(); }
            function onFillColorChanged() { barCanvas.requestPaint(); }
            function onBorderColorChanged() { barCanvas.requestPaint(); }
            function onHoveredChanged() { barCanvas.requestPaint(); }
            function onWidthChanged() { barCanvas.requestPaint(); }
            function onHeightChanged() { barCanvas.requestPaint(); }
        }
    }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: 7
        anchors.verticalCenter: parent.verticalCenter
        text: root.icon
        color: root.textColor
        font.family: "SauceCodePro Nerd Font Mono"
        font.pixelSize: 15
        font.weight: Font.Medium
    }

    Text {
        anchors.right: parent.right
        anchors.rightMargin: 7
        anchors.verticalCenter: parent.verticalCenter
        text: root.label
        color: root.textColor
        font.family: "Noto Sans"
        font.pixelSize: 12
        font.weight: Font.DemiBold
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
