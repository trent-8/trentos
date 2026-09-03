import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import SddmComponents 2.0
import "components"

Rectangle {
    id: root

    width: 1920
    height: 1080
    color: "#111111"

    property bool authenticating: false
    property string statusMessage: ""
    property bool loginFailed: false

    function submitLogin() {
        if (usernameField.text.length === 0 || passwordField.text.length === 0) {
            loginFailed = true;
            statusMessage = "Enter your username and password";
            return;
        }

        authenticating = true;
        loginFailed = false;
        statusMessage = "Signing in…";
        sddm.login(usernameField.text, passwordField.text, sessionBox.currentIndex);
    }

    Image {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
    }

    Rectangle {
        anchors.fill: parent
        color: "#38000000"
    }

    SquirclePanel {
        id: brandPanel

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 22
        anchors.topMargin: 18
        width: 112
        height: 36
        radius: 14
        horizontalPadding: 12
        verticalPadding: 4

        Text {
            anchors.centerIn: parent
            text: "trentos"
            color: "#ffffff"
            font.family: config.font
            font.pixelSize: 16
            font.weight: Font.DemiBold
        }
    }

    SquirclePanel {
        id: clockPanel

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 18
        width: Math.max(250, clockText.implicitWidth + 24)
        height: 36
        radius: 14
        horizontalPadding: 12
        verticalPadding: 4

        Text {
            id: clockText

            anchors.centerIn: parent
            color: "#ffffff"
            font.family: config.font
            font.pixelSize: 16
            font.weight: Font.Medium
            text: Qt.formatDateTime(clock.now, "M/d/yyyy h:mm AP").toLowerCase()
        }

        Timer {
            id: clock

            property date now: new Date()
            interval: 1000
            repeat: true
            running: true
            onTriggered: now = new Date()
        }
    }

    SquirclePanel {
        id: loginPanel

        anchors.centerIn: parent
        width: Math.min(430, root.width - 48)
        height: 480
        radius: 34
        exponent: 4.6
        fillColor: "#b8303030"
        borderColor: "#995f5f5f"
        highlightColor: "#55ffffff"
        horizontalPadding: 34
        verticalPadding: 30

        ColumnLayout {
            anchors.fill: parent
            spacing: 14

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 66

                Rectangle {
                    anchors.centerIn: parent
                    width: 58
                    height: 58
                    radius: 29
                    color: "#ccffffff"
                    border.color: "#ffffffff"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "T"
                        color: "#202020"
                        font.family: config.font
                        font.pixelSize: 27
                        font.weight: Font.Bold
                    }
                }
            }

            Text {
                Layout.fillWidth: true
                text: "Welcome back"
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                font.family: config.font
                font.pixelSize: 24
                font.weight: Font.DemiBold
            }

            Text {
                Layout.fillWidth: true
                text: "Sign in to continue"
                color: "#cfcfcf"
                horizontalAlignment: Text.AlignHCenter
                font.family: config.font
                font.pixelSize: 13
            }

            Item { Layout.preferredHeight: 2 }

            QQC2.TextField {
                id: usernameField

                Layout.fillWidth: true
                Layout.preferredHeight: 46
                text: userModel.lastUser
                placeholderText: "Username"
                color: "#ffffff"
                placeholderTextColor: "#a8a8a8"
                selectByMouse: true
                font.family: config.font
                font.pixelSize: 14
                KeyNavigation.tab: passwordField
                KeyNavigation.down: passwordField
                onAccepted: passwordField.forceActiveFocus()

                background: Rectangle {
                    radius: 12
                    color: "#66323232"
                    border.color: usernameField.activeFocus ? config.accentColor : "#66707070"
                    border.width: usernameField.activeFocus ? 2 : 1
                }
            }

            QQC2.TextField {
                id: passwordField

                Layout.fillWidth: true
                Layout.preferredHeight: 46
                placeholderText: "Password"
                color: "#ffffff"
                placeholderTextColor: "#a8a8a8"
                echoMode: TextInput.Password
                selectByMouse: true
                enabled: !root.authenticating
                font.family: config.font
                font.pixelSize: 14
                KeyNavigation.backtab: usernameField
                KeyNavigation.up: usernameField
                KeyNavigation.tab: sessionBox
                KeyNavigation.down: sessionBox
                onAccepted: root.submitLogin()

                background: Rectangle {
                    radius: 12
                    color: "#66323232"
                    border.color: passwordField.activeFocus ? config.accentColor : "#66707070"
                    border.width: passwordField.activeFocus ? 2 : 1
                }
            }

            QQC2.ComboBox {
                id: sessionBox

                Layout.fillWidth: true
                Layout.preferredHeight: 42
                model: sessionModel
                textRole: "name"
                currentIndex: sessionModel.lastIndex
                font.family: config.font
                font.pixelSize: 13
                KeyNavigation.backtab: passwordField
                KeyNavigation.up: passwordField
                KeyNavigation.tab: loginButton
                KeyNavigation.down: loginButton

                contentItem: Text {
                    leftPadding: 13
                    rightPadding: 32
                    text: sessionBox.displayText
                    color: "#ffffff"
                    font: sessionBox.font
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    radius: 11
                    color: "#66323232"
                    border.color: sessionBox.activeFocus ? config.accentColor : "#66707070"
                    border.width: sessionBox.activeFocus ? 2 : 1
                }
            }

            QQC2.Button {
                id: loginButton

                Layout.fillWidth: true
                Layout.preferredHeight: 46
                enabled: !root.authenticating
                KeyNavigation.backtab: sessionBox
                KeyNavigation.up: sessionBox
                text: root.authenticating ? "Signing in…" : "Sign in"
                onClicked: root.submitLogin()

                contentItem: Text {
                    text: loginButton.text
                    color: "#181818"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: config.font
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                }

                background: Rectangle {
                    radius: 12
                    color: loginButton.down ? "#b8dfff"
                        : loginButton.hovered ? "#e5f4ff" : config.accentColor
                    border.color: "#ddffffff"
                    border.width: 1
                }
            }

            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 20
                text: root.statusMessage
                visible: text.length > 0
                color: root.loginFailed ? config.errorColor : "#d8d8d8"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: config.font
                font.pixelSize: 12
                wrapMode: Text.WordWrap
            }
        }
    }

    SquirclePanel {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 22
        anchors.bottomMargin: 18
        width: powerRow.implicitWidth + 20
        height: 38
        radius: 14
        horizontalPadding: 10
        verticalPadding: 3

        RowLayout {
            id: powerRow

            anchors.centerIn: parent
            spacing: 4

            QQC2.Button {
                id: rebootButton

                text: "Restart"
                flat: true
                onClicked: sddm.reboot()

                contentItem: Text {
                    text: rebootButton.text
                    color: rebootButton.hovered ? "#ffffff" : "#d5d5d5"
                    font.family: config.font
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                Layout.preferredWidth: 1
                Layout.preferredHeight: 16
                color: "#55ffffff"
            }

            QQC2.Button {
                id: powerButton

                text: "Shut down"
                flat: true
                onClicked: sddm.powerOff()

                contentItem: Text {
                    text: powerButton.text
                    color: powerButton.hovered ? "#ffffff" : "#d5d5d5"
                    font.family: config.font
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }

    Connections {
        target: sddm

        function onLoginFailed() {
            root.authenticating = false;
            root.loginFailed = true;
            root.statusMessage = textConstants.loginFailed;
            passwordField.text = "";
            passwordField.forceActiveFocus();
        }

        function onLoginSucceeded() {
            root.statusMessage = textConstants.loginSucceeded;
        }
    }

    Component.onCompleted: {
        if (usernameField.text.length > 0)
            passwordField.forceActiveFocus();
        else
            usernameField.forceActiveFocus();
    }
}
