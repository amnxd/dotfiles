import QtQuick 2.0
import SddmComponents 2.0
import "./components"

Rectangle {
    id: root

    readonly property color ink: "#282828"
    readonly property color panel: "#1d2021e8"
    readonly property color paper: "#ebdbb2"
    readonly property color muted: "#a89984"
    readonly property color green: "#a7c080"
    readonly property color yellow: "#d8a657"
    readonly property color red: "#e67e80"
    readonly property int panelWidth: Math.min(430, root.width - 64)
    readonly property int panelHeight: 460

    color: ink

    TextConstants { id: textConstants }

    Repeater {
        model: screenModel

        Image {
            x: geometry.x
            y: geometry.y
            width: geometry.width
            height: geometry.height
            source: "wallpaper.png"
            fillMode: Image.PreserveAspectCrop
            smooth: true
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#10101099"
    }

    Rectangle {
        id: loginPanel
        anchors.centerIn: parent
        width: root.panelWidth
        height: root.panelHeight
        color: root.panel
        border.color: "#ebdbb226"
        border.width: 1

        Rectangle {
            width: parent.width
            height: 3
            color: root.green
        }

        Column {
            anchors.fill: parent
            anchors.margins: 38
            spacing: 0

            Text {
                text: "EVERGREEN"
                color: root.green
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 12
                font.letterSpacing: 2
            }

            Text {
                width: parent.width
                text: "Welcome back, " + sddm.hostName
                color: root.paper
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 25
                font.weight: Font.DemiBold
                elide: Text.ElideRight
            }

            Text {
                text: Qt.formatDateTime(new Date(), "dddd, d MMMM")
                color: root.muted
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 11
            }

            Text {
                text: textConstants.userName
                color: root.muted
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 11
            }

            TextBox {
                id: username
                width: parent.width
                height: 48
                color: "#282828cc"
                borderColor: "#ebdbb226"
                focusColor: root.green
                hoverColor: "#ebdbb238"
                textColor: root.paper
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                KeyNavigation.tab: password
            }

            Text {
                text: textConstants.password
                color: root.muted
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 11
            }

            PasswordBox {
                id: password
                width: parent.width
                height: 48
                color: "#282828cc"
                borderColor: "#ebdbb226"
                focusColor: root.green
                hoverColor: "#ebdbb238"
                textColor: root.paper
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                tooltipEnabled: true
                tooltipText: textConstants.capslockWarning
                tooltipFG: root.paper
                tooltipBG: root.ink
                KeyNavigation.tab: login
                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        root.tryLogin()
                        event.accepted = true
                    }
                }
            }

            Button {
                id: login
                width: parent.width
                height: 50
                text: textConstants.login
                color: root.green
                textColor: root.ink
                borderColor: root.green
                pressedColor: root.yellow
                activeColor: root.yellow
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                font.weight: Font.DemiBold
                onClicked: root.tryLogin()
                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        root.tryLogin()
                        event.accepted = true
                    }
                }
            }

            Row {
                width: parent.width
                height: 38
                spacing: 10

                ComboBox {
                    id: session
                    width: parent.width - layout.width - 10
                    height: 32
                    model: sessionModel
                    index: sessionModel.lastIndex
                    color: "transparent"
                    borderColor: "#ebdbb226"
                    focusColor: root.green
                    hoverColor: "#ebdbb238"
                    textColor: root.muted
                    menuColor: root.ink
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 10
                }

                LayoutBox {
                    id: layout
                    width: 74
                    height: 32
                    color: "transparent"
                    borderColor: "#ebdbb226"
                    focusColor: root.green
                    hoverColor: "#ebdbb238"
                    textColor: root.muted
                    menuColor: root.ink
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 10
                }
            }
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 26
        text: "  " + Qt.formatTime(new Date(), "HH:mm")
        color: root.paper
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 12
        opacity: 0.75
    }

    signal tryLogin()

    onTryLogin: {
        sddm.login(username.text, password.text, session.index)
    }

    Connections {
        target: sddm
        onLoginFailed: {
            password.text = ""
            password.focus = true
        }
    }

    Component.onCompleted: {
        username.focus = true
    }
}