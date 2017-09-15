import QtQuick 2.0

Item {
    height: 1024
    width: 640
    property int index: 0
    property bool enable: true
    enabled: enable
//    Image {
//        id: image
//        x: 0
//        y: 0
//        fillMode: Image.PreserveAspectFit
//        source: "img/menu/Back-1.png"

        Rectangle {
            id: rectangle
            x: 101
            y: 279
            width: 137
            height: 50
            color: "#00000000"
            radius: 10
            visible: true
            opacity: enable?1:0.5
            border.color: mainGameList.get(0).selected?"#ffbd09":"#00000000"
            border.width: mainGameList.get(0).selected?3:0

            Text {
                id: text1
                color: mainGameList.get(0).selected?"#ffbd09":"#c69c6d"
                text: mainGameList.get(0).caption
                font.bold: true
                fontSizeMode: Text.Fit
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 3
                anchors.right: parent.right
                anchors.rightMargin: 7
                font.family: "Myriad Pro"
                font.pixelSize: 20
                renderType: Text.NativeRendering
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainGameList.setSelected(0);
                }
            }
        }

        Rectangle {
            id: rectangle1
            x: 242
            y: 279
            width: 157
            height: 50
            color: "#00000000"
            radius: 9
            visible: true
            opacity: enable?1:0.5
            border.color: mainGameList.get(1).selected?"#ffbd09":"#00000000"
            border.width: mainGameList.get(1).selected?3:0
            Text {
                id: text2
                color: mainGameList.get(1).selected?"#ffbd09":"#c69c6d"
                text: mainGameList.get(1).caption
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                fontSizeMode: Text.Fit
                anchors.bottomMargin: 0
                renderType: Text.NativeRendering
                font.bold: true
                anchors.right: parent.right
                font.family: "Myriad Pro"
                anchors.rightMargin: 7
                font.pixelSize: 20
                anchors.topMargin: 3
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainGameList.setSelected(1);
                }
            }
        }

        Rectangle {
            id: rectangle2
            x: 401
            y: 279
            width: 137
            height: 50
            color: "#00000000"
            radius: 10
            visible: true
            opacity: enable?1:0.5
            border.color: mainGameList.get(2).selected?"#ffbd09":"#00000000"
            border.width: mainGameList.get(2).selected?3:0
            Text {
                id: text3
                color: mainGameList.get(2).selected?"#ffbd09":"#c69c6d"
                text: mainGameList.get(2).caption
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                fontSizeMode: Text.Fit
                anchors.bottomMargin: 0
                renderType: Text.NativeRendering
                font.bold: true
                anchors.right: parent.right
                font.family: "Myriad Pro"
                anchors.rightMargin: 7
                font.pixelSize: 20
                anchors.topMargin: 3
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainGameList.setSelected(2);
                }
            }
        }

        Rectangle {
            id: rectangle12
            x: 100
            y: 380
            width: 217
            height: 58
            color: "#00000000"
            radius: 0
            visible: true
            border.color: "#00000000"
            border.width: 0
            opacity: enable?1:0.5
            Image {
                id: image1
                anchors.right: parent.right
                anchors.rightMargin: 0
                source: "img/menu/butt-1-01.png"
                visible: mainGameTypeList.get(0).selected;
            }
            Image {
                id: image3
                fillMode: Image.PreserveAspectFit
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 1
                anchors.left: parent.left
                anchors.leftMargin: 0
                source: "img/menu/Chek.png"
                visible: mainGameTypeList.get(0).selected;
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainGameTypeList.setSelected(0);
                }
            }
        }

        Rectangle {
            id: rectangle13
            x: 322
            y: 380
            width: 218
            height: 58
            color: "#00000000"
            radius: 0
            visible: true
            border.color: "#00000000"
            border.width: 0
            opacity: enable?1:0.5
            Image {
                id: image2
                anchors.left: parent.left
                anchors.leftMargin: 0
                source: "img/menu/butt-1-01.png"
                visible: mainGameTypeList.get(1).selected;
            }
            Image {
                id: image4
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 1
                fillMode: Image.PreserveAspectFit
                source: "img/menu/Chek.png"
                visible: mainGameTypeList.get(1).selected;
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainGameTypeList.setSelected(1);
                }
            }
        }
    //}

}
