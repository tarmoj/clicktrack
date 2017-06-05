import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Rectangle {
    id: ui
    property alias connectButton: connectButton
    property alias loadButton: loadButton
    property alias serverAddressField: serverAddressField
    property alias  fileNameField: fileNameField
    property alias timeLabel: timeLabel
    property alias statusLabel: statusLabel
    property alias playButton: playButton
    property alias stopButton: stopButton
    width: 660
    height: 280
    gradient: Gradient {
        GradientStop {
            position: 1
            color: "#ffffff"
        }
        GradientStop {
            position: 0
            color: "#45a916"
        }
    }

    ColumnLayout {
        id: columnLayout
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        spacing: 20
        anchors.fill: parent

        Row {
            id: row1
            x: 0
            //width: parent.width
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            anchors.right: parent.right
            anchors.rightMargin: 6
            anchors.left: parent.left
            anchors.leftMargin: 6
            spacing: 6

            Label {
                id: label
                text: qsTr("Server:")
            }

            TextField {
                id: serverAddressField
                x: 43
                y: 0
                text: qsTr("127.0.0.1")
                z: 1
            }

            Button {
                id: connectButton
                text: qsTr("Connect")
            }
        }
    }

    Row {
        id: row
        x: 10
        y: 51
        width: 620
        height: 46
        spacing: 6
        clip: false

        Label {
            id: label1
            text: qsTr("Clicktrack file:")
            anchors.verticalCenter: parent.verticalCenter
        }

        TextField {
            id: fileNameField
            x: 106
            y: 3
            text: qsTr("qrc:/test.wav")
        }

        Button {
            id: loadButton
            x: 309
            y: 6
            text: qsTr("Load")
        }

        BusyIndicator {
            id: busyIndicator
            x: 412
            y: 0
            width: 38
            height: 51
            visible: false
            running: false
        }

        Button {
            id: playButton
            x: 444
            y: 6
            text: qsTr("Play")
        }

        Button {
            id: stopButton
            x: 506
            y: 6
            text: qsTr("Stop")
        }
    }

    Row {
        id: row2
        x: 10
        y: 103
        width: 619
        height: 45

        Label {
            id: label2
            text: qsTr("Status:")
        }

        Label {
            id: statusLabel
            x: 48
            y: 0
            text: qsTr("Not loaded")
        }
    }

    Row {
        id: row3
        x: 10
        y: 154
        width: 618
        height: 49
        spacing: 6

        Label {
            id: label4
            text: qsTr("Time:")
        }

        Label {
            id: timeLabel
            text: qsTr("00:00")
            font.bold: true
            font.pointSize: 20
        }
    }
}
