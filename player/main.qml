import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtMultimedia 5.5
import QtWebSockets 1.1


/*

TODO: copy resource to temporary file for Linux/desktop at all
- settings to save folder, file, IP
- try loading large wav files
- starter to the same project?? How? Different main.cpp-s?
- android - keep awake
!Test, test
- have a look at the Avanti score!
  */


ApplicationWindow {
    visible: true
    width: 640
    height: 280
    title: qsTr("Clicktrack player")

    WebSocket {
        id: socket
        property string serverIP: "192.168.1.199"
        url: "ws://"+serverIP+":7007/ws"//"ws://192.168.1.199:6006/ws"

        onTextMessageReceived: {
            console.log(message)
            var messageParts = message.split(" ");
            if (messageParts[0]==="play") {
                sound.play()
            }

            if (messageParts[0] === "stop") {
                  console.log("stop");
                  sound.stop();
                  sound.seek(sound.seekPosition); // in ms

             }

            if (messageParts[0] === "seek") {
                if (!sound.seekable) {
                    console.log("This media is not seekable!")
                }

                if (messageParts.length>=2) {
                    sound.seekPosition = parseFloat(messageParts[1])*1000;
                    console.log("seek to: ", sound.seekPosition, sound.seekable)

                    sound.seek(sound.seekPosition)
                }


            }
        }


        onStatusChanged: if (socket.status == WebSocket.Error) {
                             console.log("Error: " + socket.errorString)
                             socket.active = false;

                         } else if (socket.status == WebSocket.Open) {
                             console.log("Socket open")
                             page.connectButton.text = "Connected"
                             page.connectButton.enabled = false
                         } else if (socket.status == WebSocket.Closed) {
                             console.log("Socket closed")
                             socket.active = false;
                             page.connectButton.text = "Connect"
                             page.connectButton.enabled = true
                         }
                         else if (socket.status == WebSocket.Connecting) {
                             console.log("Socket connecting")
                             page.connectButton.text = "Connecting"
                             //page.connectButton.enabled = false
                         }



    }

    Component.onCompleted: socket.active = true

    FileDialog {
        id: fileDialog
        title: qsTr("Please choose sound file to play")
        //nameFilters: [ "Sound file (*.sco)", "All files (*)" ]
        //folder: "file://"
        onAccepted: {
            page.fileNameField.text = fileUrl
            sound.source = fileUrl
            var basename = fileUrl.toString()
            basename = basename.slice(0, basename.lastIndexOf("/")+1)
            folder = basename
            console.log("You chose: " + fileUrl + " in folder: " + basename)
        }
        onRejected: {
            console.log("Canceled")
            visible = false;
        }
    }

    Audio {
        id: sound
        property int seekPosition: 0 // in ms
        source: "qrc:///sound1.mp3"
        onStatusChanged: {
            console.log("sound status: ",status)
            if (status == Audio.Loading || status == Audio.Buffering) {
                console.log("Loading")
                page.statusLabel.text = "Loading";
            }
            if (status == Audio.Loaded) {
                console.log("Loaded")
                page.statusLabel.text = "Loaded";
            }

            if (status == Audio.EndOfMedia) {
                console.log("End of Media")
                page.statusLabel.text = "End of media";
            }

        }

        onPlaybackStateChanged:  {
            if (playbackState==Audio.PlayingState)
                page.statusLabel.text = "Playing"
            if (playbackState==Audio.PausedState)
                page.statusLabel.text = "Paused"
            if (playbackState==Audio.StoppedState)
                page.statusLabel.text = "Stopped"
        }

        onPositionChanged: {
            var seconds = Math.round(position/1000.0)
            var timeString = Math.floor(seconds/60) +":" + (seconds%60).toString() // TODO: preceding 0-s? Date type? Javascript?
            page.timeLabel.text = timeString
            console.log("Position: ", position)
        }

    }

    Page1Form {
        id: page;
        anchors.fill: parent
        loadButton.onClicked:  {
            fileDialog.open()
        }
        playButton.onClicked: {
            sound.play()
        }
        stopButton.onClicked: {
            sound.stop()
        }

        connectButton.onClicked: {
            if (!socket.active) {
                if (page.serverAddressField.text==socket.serverIP) {
                    socket.active = true
                } else {
                    socket.serverIP = page.serverAddressField.text // this should activate the socket as well, since server.url is bound to serverIP
                }
                //console.log("Connecting to ",serverAddress.text, "Socket status: ", socket.status)
            }
        }
    }

}
