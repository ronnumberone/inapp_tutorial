import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt5Compat.GraphicalEffects

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Button {
        id: button1
        text: "Press me 1"
        x: 50
        y: 90

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("press1")
            }
        }
    }

    Button {
        id: button2
        text: "Press me 2"
        x: 150
        y: 90

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("press2")
            }
        }
    }

    Button {
        id: button3
        text: "Press me 3"
        x: 250
        y: 90

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("press3")
            }
        }
    }

    UserGuideline {
        id: guideStep1
        xBtn: button1.x
        yBtn: button1.y
        widthBtn: button1.width
        heightBtn: button1.height
        contentPopup: "Step 1"
        showcase: true
        onOverlayClick: guideStep2.showcase = true
    }

    UserGuideline {
        id: guideStep2
        xBtn: button2.x
        yBtn: button2.y
        widthBtn: button2.width
        heightBtn: button2.height
        contentPopup: "Step 2"
        onOverlayClick: guideStep3.showcase = true
    }

    UserGuideline {
        id: guideStep3
        xBtn: button3.x
        yBtn: button3.y
        widthBtn: button3.width
        heightBtn: button3.height
        contentPopup: "Step 3vsfdvsdvsvsvsdf"
    }
}
