import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "main.js" as JS

ApplicationWindow {
    id: mainWindow
    visible: true
    minimumWidth: 300
    minimumHeight: 440
    maximumWidth: minimumWidth
    maximumHeight: minimumHeight
    title: qsTr("jvaTest")
    color: "#292929"
    function statusCallback(status) {title.text = status;}
    function validateAndConnect(username, password) {
        if(username.length > 3 && password.length > 3)
            JS.connAndAuth(username, password, statusCallback);
        else title.text = "Username/Password too short!";
        revertTitle();
    }
    Timer {id: timer}
    function revertTitle() {
        timer.interval = 2000;
        timer.repeat = false;
        timer.triggered.connect(function() {
            title.text = "jvaTest";
        });
        timer.start();
    }

    /* odlučio sam se za "anchor" pozicioniranje umjesto "layout-a"
    jer je bilo premalo elemenata da bi potreba za scaling-om
    UI-a imala smisla te sam stoga i isključio resize*/
    Label {
        id: title
        text: "jvaTest"
        font.pointSize: 13
        color: "#A9A9A9"
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 20
        }
        Behavior on text {
            PropertyAnimation {
                id: animateColor;
                target: title;
                properties: "opacity";
                from: 0
                to: 1
                duration: 2000
            }
        }
    }
    Image {
        id: userImg
        source: "images/user64.png"
        sourceSize.width: 48
        sourceSize.height: 48
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: title.bottom
            topMargin: 40
        }
    }
    Item {
        width: 200
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: userImg.bottom
            topMargin: 50
        }

        Label {
            id: usernameLabel
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Username"
            color: "#A9A9A9"
        }
        TextField {
            id: usernameInput
            width: parent.width
            anchors {
                top: usernameLabel.bottom
                topMargin: 6
            }
            maximumLength: 30
            onAccepted: {
                validateAndConnect(usernameInput.text, passwordInput.text);
            }
        }
        Label {
            id: passwordLabel
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: usernameInput.bottom
                topMargin: 20
            }
            text: "Password"
            color: "#A9A9A9"
        }
        TextField {
            id: passwordInput
            width: parent.width
            anchors {
                top: passwordLabel.bottom
                topMargin: 6
            }
            maximumLength: 30
            echoMode: TextInput.Password
            onAccepted: {
                validateAndConnect(usernameInput.text, passwordInput.text);
            }
        }
        Button {
            text: "Login"
            anchors {
                top: passwordInput.bottom
                topMargin: 60
                horizontalCenter: parent.horizontalCenter
            }
            onClicked: {
                validateAndConnect(usernameInput.text, passwordInput.text);
            }
            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#a9a9a9" : "#fefefe" }
                    }
                }
            }
        }
    }
}
