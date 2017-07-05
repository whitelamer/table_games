import QtQuick 2.0

Item {
    id: item1
    Rectangle {
        id: rectangle
        x: 156
        y: 40
        width: 84
        height: 160
        color: "#ffffff"
        rotation: 180
    }

    Rectangle {
        id: rectangle1
        x: 416
        width: 23
        height: 200
        color: "#ffffff"
        anchors.horizontalCenterOffset: 0
        rotation: 180
        anchors.top: rectangle.top
        anchors.topMargin: 0
        anchors.horizontalCenter: rectangle.horizontalCenter
    }

}
