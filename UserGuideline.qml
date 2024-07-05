import QtQuick 2.7
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

Item {
    required property double xBtn
    required property double yBtn
    required property double widthBtn
    required property double heightBtn
    required property string contentPopup
    property bool showcase
    signal overlayClick

    anchors.fill: parent

    Popup {
        id: popup
        visible: opacityMask.visible

        anchors.centerIn: parent

        contentItem: Text {
            text: contentPopup
        }
    }

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
                           showcase = false
                       }
        }

        Behavior on opacity {
            NumberAnimation {
                easing.type: Easing.InOutCubic
            }
        }
    }
}
