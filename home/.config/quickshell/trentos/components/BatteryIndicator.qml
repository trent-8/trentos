import QtQuick

Item {
    id: root

    signal clicked

    property real value: -1
    property bool charging: false
    property bool fullPlugged: false
    property string label: value >= 0 ? Math.round(value).toString() : "--"
    property color trackColor: "#40202020"
    property color borderColor: "#77ffffff"
    property color textColor: "#ffffff"
    property color fillColor: charging || fullPlugged
        ? "#a07ee787"
        : value >= 0 && value <= 15 ? "#b0ff7b72" : "#80ffffff"

    readonly property real progress: Math.max(0, Math.min(value / 100, 1))
    readonly property string stateIcon: charging ? "" : fullPlugged ? "" : ""
    readonly property bool hovered: mouseArea.containsMouse
    property real animatedProgress: progress

    implicitWidth: 72
    implicitHeight: 22

    Behavior on animatedProgress {
        NumberAnimation {
            duration: 180
            easing.type: Easing.OutCubic
        }
    }

    Canvas {
        id: batteryCanvas

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
            const terminalWidth = 4;
            const terminalGap = 2;
            const bodyX = inset;
            const bodyY = inset;
            const bodyWidth = Math.max(0, width - terminalWidth - terminalGap - inset * 2);
            const bodyHeight = Math.max(0, height - inset * 2);
            const bodyRadius = 5;
            const innerInset = 2;
            const innerX = bodyX + innerInset;
            const innerY = bodyY + innerInset;
            const innerWidth = Math.max(0, bodyWidth - innerInset * 2);
            const innerHeight = Math.max(0, bodyHeight - innerInset * 2);

            ctx.reset();
            ctx.clearRect(0, 0, width, height);

            roundedPath(ctx, bodyX, bodyY, bodyWidth, bodyHeight, bodyRadius);
            ctx.fillStyle = root.trackColor;
            ctx.fill();

            ctx.save();
            roundedPath(ctx, innerX, innerY, innerWidth, innerHeight, Math.max(0, bodyRadius - innerInset));
            ctx.clip();
            ctx.fillStyle = root.fillColor;
            ctx.fillRect(innerX, innerY, innerWidth * root.animatedProgress, innerHeight);
            ctx.restore();

            roundedPath(ctx, bodyX, bodyY, bodyWidth, bodyHeight, bodyRadius);
            ctx.lineWidth = 1;
            ctx.strokeStyle = root.borderColor;
            ctx.stroke();

            if (root.hovered) {
                roundedPath(ctx, bodyX, bodyY, bodyWidth, bodyHeight, bodyRadius);
                ctx.fillStyle = "#18ffffff";
                ctx.fill();
            }

            const terminalX = bodyX + bodyWidth + terminalGap;
            const terminalHeight = Math.max(6, bodyHeight * 0.36);
            const terminalY = bodyY + (bodyHeight - terminalHeight) / 2;
            roundedPath(ctx, terminalX, terminalY, terminalWidth, terminalHeight, 1.5);
            ctx.fillStyle = root.borderColor;
            ctx.fill();
        }

        Connections {
            target: root
            function onAnimatedProgressChanged() { batteryCanvas.requestPaint(); }
            function onTrackColorChanged() { batteryCanvas.requestPaint(); }
            function onFillColorChanged() { batteryCanvas.requestPaint(); }
            function onBorderColorChanged() { batteryCanvas.requestPaint(); }
            function onHoveredChanged() { batteryCanvas.requestPaint(); }
            function onWidthChanged() { batteryCanvas.requestPaint(); }
            function onHeightChanged() { batteryCanvas.requestPaint(); }
        }
    }

    Item {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width - 6

        Text {
            anchors.centerIn: parent
            text: root.stateIcon.length > 0 ? `${root.stateIcon} ${root.label}` : root.label
            color: root.textColor
            font.family: "SauceCodePro Nerd Font Mono"
            font.pixelSize: 13
            font.weight: Font.DemiBold
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
