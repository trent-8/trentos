import QtQuick 2.15

Item {
    id: root

    default property alias content: contentHost.data

    property color fillColor: "#80303030"
    property color borderColor: "#80505050"
    property color highlightColor: "#80505050"
    property real borderWidth: 1
    property real radius: 16
    property real exponent: 4.6
    property int horizontalPadding: 8
    property int verticalPadding: 8

    Canvas {
        id: canvas

        anchors.fill: parent
        antialiasing: true

        function addCorner(context, centerX, centerY, cornerRadius, startAngle, endAngle) {
            const samples = 16;
            for (let index = 1; index <= samples; index++) {
                const theta = startAngle + (endAngle - startAngle) * index / samples;
                const cosine = Math.cos(theta);
                const sine = Math.sin(theta);
                const pointX = centerX + cornerRadius * Math.sign(cosine)
                    * Math.pow(Math.abs(cosine), 2 / root.exponent);
                const pointY = centerY + cornerRadius * Math.sign(sine)
                    * Math.pow(Math.abs(sine), 2 / root.exponent);
                context.lineTo(pointX, pointY);
            }
        }

        function addPath(context, x, y, pathWidth, pathHeight, cornerRadius) {
            const right = x + pathWidth;
            const bottom = y + pathHeight;
            const radius = Math.max(0, Math.min(cornerRadius, pathWidth / 2, pathHeight / 2));

            context.beginPath();
            context.moveTo(x + radius, y);
            context.lineTo(right - radius, y);
            addCorner(context, right - radius, y + radius, radius, -Math.PI / 2, 0);
            context.lineTo(right, bottom - radius);
            addCorner(context, right - radius, bottom - radius, radius, 0, Math.PI / 2);
            context.lineTo(x + radius, bottom);
            addCorner(context, x + radius, bottom - radius, radius, Math.PI / 2, Math.PI);
            context.lineTo(x, y + radius);
            addCorner(context, x + radius, y + radius, radius, Math.PI, Math.PI * 1.5);
            context.closePath();
        }

        onPaint: {
            const context = getContext("2d");
            const inset = root.borderWidth / 2 + 0.5;

            context.reset();
            context.clearRect(0, 0, width, height);
            addPath(context, inset, inset, width - inset * 2, height - inset * 2,
                Math.max(0, root.radius - inset));
            context.fillStyle = root.fillColor;
            context.fill();

            if (root.borderWidth > 0) {
                context.lineWidth = root.borderWidth;
                context.strokeStyle = root.borderColor;
                context.stroke();
            }

            const highlightInset = inset + 1;
            addPath(context, highlightInset, highlightInset,
                Math.max(0, width - highlightInset * 2),
                Math.max(0, height - highlightInset * 2),
                Math.max(0, root.radius - highlightInset));
            context.lineWidth = 1;
            context.strokeStyle = root.highlightColor;
            context.stroke();
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
