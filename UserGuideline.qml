import QtQuick 2.7
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

Item {
    property double xBtn
    property double yBtn
    property double widthBtn
    property double heightBtn
    property string contentPopup
    property bool showcase
    signal overlayClick

    anchors.fill: parent

    Item {
        id: mask
        visible: false
        anchors.fill: parent

        Item {
            id: buttonGeometry
            x: xBtn
            y: yBtn
            width: widthBtn
            height: heightBtn
        }

        Repeater {
            id: repeater
            property real startDiameter: Math.max(widthBtn, heightBtn) + 20
            property real diameterStep: 10
            property real opacityStep: 0.8
            model: 2
            Rectangle {
                anchors.centerIn: buttonGeometry
                property real diameter: repeater.startDiameter + repeater.diameterStep * index
                width: diameter
                height: diameter
                radius: diameter / 2
                opacity: 1 - repeater.opacityStep * index
            }
        }
    }

    Rectangle {
        id: overlayRectangle
        visible: false
        anchors.fill: parent
        color: "#888"
    }

    OpacityMask {
        id: opacityMask
        visible: opacity
        enabled: visible
        anchors.fill: parent
        maskSource: mask
        source: overlayRectangle
        invert: true
        opacity: showcase ? 0.8 : 0

        MouseArea {
            anchors.fill: parent

            propagateComposedEvents: true
            onClicked: mouse => {
                           mouse.accepted = false
                           overlayClick()
                       }
        }

        Behavior on opacity {
            NumberAnimation {
                easing.type: Easing.InOutCubic
            }
        }
    }

    Popup {
        id: popup
        visible: showcase

        anchors.centerIn: parent

        contentItem: Text {
            text: contentPopup
        }

        Row {
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.top
                bottomMargin: 10
            }

            Button {
                text: "Next"
                onClicked: {
                    overlayClick()
                }
            }

            Button {
                text: "Skip"
                onClicked: {
                    showcase = false
                }
            }
        }
    }
}
