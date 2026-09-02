import QtQuick

Item {
    id: root

    default property alias content: contentHost.data

    property color fillColor: "#80303030"
    property color borderColor: "#80505050"
    property color highlightColor: "#80505050"
    property real borderWidth: 0
    property real radius: 16
    property real power: 4.6
    property real exponent: power
    property int horizontalPadding: 8
    property int verticalPadding: 8

    readonly property Item contentItem: contentHost.children.length > 0 ? contentHost.children[0] : null

    implicitWidth: Math.max((contentItem ? contentItem.implicitWidth : 0) + horizontalPadding * 2, 34)
    implicitHeight: Math.max((contentItem ? contentItem.implicitHeight : 0) + verticalPadding * 2, 30)

    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true

        onPaint: {
            const ctx = getContext("2d");
            const w = width;
            const h = height;
            const inset = root.borderWidth / 2 + 0.5;

            ctx.reset();
            ctx.clearRect(0, 0, w, h);

            function addCorner(cx, cy, radius, startAngle, endAngle, power, samples) {
                for (let i = 1; i <= samples; i++) {
                    const theta = startAngle + (endAngle - startAngle) * i / samples;
                    const cos = Math.cos(theta);
                    const sin = Math.sin(theta);
                    const px = cx + radius * Math.sign(cos) * Math.pow(Math.abs(cos), 2 / power);
                    const py = cy + radius * Math.sign(sin) * Math.pow(Math.abs(sin), 2 / power);

                    ctx.lineTo(px, py);
                }
            }

            function path(x, y, width, height, radius, power, samples) {
                const right = x + width;
                const bottom = y + height;
                const r = Math.max(0, Math.min(radius, width / 2, height / 2));

                ctx.beginPath();
                ctx.moveTo(x + r, y);
                ctx.lineTo(right - r, y);
                addCorner(right - r, y + r, r, -Math.PI / 2, 0, power, samples);
                ctx.lineTo(right, bottom - r);
                addCorner(right - r, bottom - r, r, 0, Math.PI / 2, power, samples);
                ctx.lineTo(x + r, bottom);
                addCorner(x + r, bottom - r, r, Math.PI / 2, Math.PI, power, samples);
                ctx.lineTo(x, y + r);
                addCorner(x + r, y + r, r, Math.PI, Math.PI * 1.5, power, samples);
                ctx.closePath();
            }

            const panelRadius = Math.max(0, root.radius - inset);
            const panelPower = Math.max(0.1, root.exponent);
            path(inset, inset, w - inset * 2, h - inset * 2, panelRadius, panelPower, 12);
            ctx.fillStyle = root.fillColor;
            ctx.fill();
            if (root.borderWidth > 0) {
                ctx.lineWidth = root.borderWidth;
                ctx.strokeStyle = root.borderColor;
                ctx.stroke();
            }

            const highlightInset = inset + 1;
            const highlightWidth = Math.max(0, w - highlightInset * 2);
            const highlightHeight = Math.max(0, h - highlightInset * 2);
            const highlightRadius = Math.max(0, root.radius - highlightInset);
            path(highlightInset, highlightInset, highlightWidth, highlightHeight, highlightRadius, panelPower, 12);
            ctx.strokeStyle = root.highlightColor;
            ctx.lineWidth = 1;
            ctx.stroke();
        }

        Connections {
            target: root
            function onWidthChanged() { canvas.requestPaint(); }
            function onHeightChanged() { canvas.requestPaint(); }
            function onFillColorChanged() { canvas.requestPaint(); }
            function onBorderColorChanged() { canvas.requestPaint(); }
            function onHighlightColorChanged() { canvas.requestPaint(); }
            function onBorderWidthChanged() { canvas.requestPaint(); }
            function onRadiusChanged() { canvas.requestPaint(); }
            function onPowerChanged() { canvas.requestPaint(); }
            function onExponentChanged() { canvas.requestPaint(); }
        }
    }

    Item {
        id: contentHost
        anchors.fill: parent
        anchors.leftMargin: root.horizontalPadding
        anchors.rightMargin: root.horizontalPadding
        anchors.topMargin: root.verticalPadding
        anchors.bottomMargin: root.verticalPadding
    }
}
