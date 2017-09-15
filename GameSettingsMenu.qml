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
            id: rectangle3
            x: 101
            y: 490
            width: 137
            height: 50
            color: "#00000000"
            radius: 10
            visible: true
            opacity: mainGameTimeList.get(0).enable&&enable?1:0.5
            border.color: mainGameTimeList.get(0).selected?"#ffbd09":"#00000000"
            border.width: mainGameTimeList.get(0).selected?3:0
            Text {
                id: text4
                color: mainGameTimeList.get(0).selected?"#ffbd09":"#c69c6d"
                text: mainGameTimeList.get(0).caption
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                anchors.top: parent.top
                fontSizeMode: Text.Fit
                anchors.bottomMargin: 0
                renderType: Text.NativeRendering
                font.bold: true
                anchors.right: parent.right
                font.family: "Myriad Pro"
                anchors.rightMargin: 7
                font.pixelSize: 20
                anchors.topMargin: 4
            }
            MouseArea{
                anchors.fill: parent
                enabled: parent.opacity==1
                onClicked: {
                    mainGameTimeList.setSelected(0);
                }
            }
        }

        Rectangle {
            id: rectangle4
            x: 251
            y: 490
            width: 137
            height: 50
            color: "#00000000"
            radius: 10
            visible: true
            opacity: mainGameTimeList.get(1).enable&&enable?1:0.5
            border.color: mainGameTimeList.get(1).selected?"#ffbd09":"#00000000"
            border.width: mainGameTimeList.get(1).selected?3:0
            Text {
                id: text5
                color: mainGameTimeList.get(1).selected?"#ffbd09":"#c69c6d"
                text: mainGameTimeList.get(1).caption
                anchors.bottom: parent.bottom
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.top
                fontSizeMode: Text.Fit
                renderType: Text.NativeRendering
                anchors.bottomMargin: 0
                font.bold: true
                anchors.right: parent.right
                font.family: "Myriad Pro"
                anchors.rightMargin: 7
                font.pixelSize: 20
                anchors.topMargin: 4
            }
            MouseArea{
                anchors.fill: parent
                enabled: parent.opacity==1
                onClicked: {
                    mainGameTimeList.setSelected(1);
                }
            }
        }

        Rectangle {
            id: rectangle5
            x: 401
            y: 490
            width: 137
            height: 50
            color: "#00000000"
            radius: 10
            visible: true
            opacity: mainGameTimeList.get(2).enable&&enable?1:0.5
            border.color: mainGameTimeList.get(2).selected?"#ffbd09":"#00000000"
            border.width: mainGameTimeList.get(2).selected?3:0
            Text {
                id: text6
                color: mainGameTimeList.get(2).selected?"#ffbd09":"#c69c6d"
                text: mainGameTimeList.get(2).caption
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                anchors.top: parent.top
                fontSizeMode: Text.Fit
                anchors.bottomMargin: 0
                renderType: Text.NativeRendering
                font.bold: true
                anchors.right: parent.right
                font.family: "Myriad Pro"
                anchors.rightMargin: 7
                font.pixelSize: 20
                anchors.topMargin: 4
            }
            MouseArea{
                anchors.fill: parent
                enabled: parent.opacity==1
                onClicked: {
                    mainGameTimeList.setSelected(2);
                }
            }
        }

        Rectangle {
            id: rectangle6
            x: 101
            y: 552
            width: 137
            height: 50
            color: "#00000000"
            radius: 10
            visible: true
            opacity: mainGameTimeList.get(3).enable&&enable?1:0.5
            border.color: mainGameTimeList.get(3).selected?"#ffbd09":"#00000000"
            border.width: mainGameTimeList.get(3).selected?3:0
            Text {
                id: text7
                color: mainGameTimeList.get(3).selected?"#ffbd09":"#c69c6d"
                text: mainGameTimeList.get(3).caption
                anchors.bottom: parent.bottom
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.top
                fontSizeMode: Text.Fit
                renderType: Text.NativeRendering
                anchors.bottomMargin: 0
                font.bold: true
                anchors.right: parent.right
                font.family: "Myriad Pro"
                anchors.rightMargin: 7
                font.pixelSize: 20
                anchors.topMargin: 4
            }
            MouseArea{
                anchors.fill: parent
                enabled: parent.opacity==1
                onClicked: {
                    mainGameTimeList.setSelected(3);
                }
            }
        }

        Rectangle {
            id: rectangle7
            x: 251
            y: 552
            width: 137
            height: 50
            color: "#00000000"
            radius: 10
            visible: true
            opacity: mainGameTimeList.get(4).enable&&enable?1:0.5
            border.color: mainGameTimeList.get(4).selected?"#ffbd09":"#00000000"
            border.width: mainGameTimeList.get(4).selected?3:0
            Text {
                id: text8
                color: mainGameTimeList.get(4).selected?"#ffbd09":"#c69c6d"
                text: mainGameTimeList.get(4).caption
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                anchors.top: parent.top
                fontSizeMode: Text.Fit
                anchors.bottomMargin: 0
                renderType: Text.NativeRendering
                font.bold: true
                anchors.right: parent.right
                font.family: "Myriad Pro"
                anchors.rightMargin: 7
                font.pixelSize: 20
                anchors.topMargin: 4
            }
            MouseArea{
                anchors.fill: parent
                enabled: parent.opacity==1
                onClicked: {
                    mainGameTimeList.setSelected(4);
                }
            }
        }

        Rectangle {
            id: rectangle8
            x: 401
            y: 552
            width: 137
            height: 50
            color: "#00000000"
            radius: 10
            visible: true
            opacity: enable?1:0.5
            border.color: "#ffbd09"
            border.width: 3
            Text {
                id: text9
                color: "#c69c6d"
                text: "ОПЦИИ"
                anchors.bottom: parent.bottom
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.top
                fontSizeMode: Text.Fit
                renderType: Text.NativeRendering
                anchors.bottomMargin: 0
                font.bold: true
                anchors.right: parent.right
                font.family: "Myriad Pro"
                anchors.rightMargin: 7
                font.pixelSize: 20
                anchors.topMargin: 4
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    //mainGameList.setSelected(0);
                }
            }
        }

        Rectangle {
            id: rectangle9
            x: 101
            y: 659
            width: 137
            height: 50
            color: "#00000000"
            radius: 10
            visible: true
            opacity: enable?1:0.5
            border.color: mainGameStyleList.get(0).selected?"#ffbd09":"#00000000"
            border.width: mainGameStyleList.get(0).selected?3:0
            Text {
                id: text10
                color: mainGameStyleList.get(0).selected?"#ffbd09":"#c69c6d"
                text: mainGameStyleList.get(0).caption
                anchors.bottom: parent.bottom
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.top
                fontSizeMode: Text.Fit
                renderType: Text.NativeRendering
                anchors.bottomMargin: 0
                font.bold: true
                anchors.right: parent.right
                font.family: "Myriad Pro"
                anchors.rightMargin: 7
                font.pixelSize: 20
                anchors.topMargin: 4
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainGameStyleList.setSelected(0);
                }
            }
        }

        Rectangle {
            id: rectangle10
            x: 251
            y: 659
            width: 137
            height: 50
            color: "#00000000"
            radius: 10
            visible: true
            opacity: enable?1:0.5
            border.color: mainGameStyleList.get(1).selected?"#ffbd09":"#00000000"
            border.width: mainGameStyleList.get(1).selected?3:0
            Text {
                id: text11
                color: mainGameStyleList.get(1).selected?"#ffbd09":"#c69c6d"
                text: mainGameStyleList.get(1).caption
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
                anchors.topMargin: 4
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainGameStyleList.setSelected(1);
                }
            }
        }

        Rectangle {
            id: rectangle11
            x: 401
            y: 659
            width: 137
            height: 50
            color: "#00000000"
            radius: 10
            visible: true
            opacity: enable?1:0.5
            border.color: mainGameStyleList.get(2).selected?"#ffbd09":"#00000000"
            border.width: mainGameStyleList.get(2).selected?3:0
            Text {
                id: text12
                color: mainGameStyleList.get(2).selected?"#ffbd09":"#c69c6d"
                text: mainGameStyleList.get(2).caption
                anchors.bottom: parent.bottom
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.top
                fontSizeMode: Text.Fit
                renderType: Text.NativeRendering
                anchors.bottomMargin: 0
                font.bold: true
                anchors.right: parent.right
                font.family: "Myriad Pro"
                anchors.rightMargin: 7
                font.pixelSize: 20
                anchors.topMargin: 4
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainGameStyleList.setSelected(2);
                }
            }
        }

        Rectangle {
            id: rectangle14
            x: 101
            y: 719
            width: 214
            height: 52
            color: "#00000000"
            radius: 0
            visible: true
            opacity: enable?1:0.5
            Image {
                fillMode: Image.PreserveAspectFit
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 1
                anchors.left: parent.left
                anchors.leftMargin: 0
                source: "img/menu/Chek.png"
                visible: mainGameHerroStyleList.get(0).selected;
            }
            Rectangle {
                id: rectangle16
                width: 164
                height: 58
                color: "#00000000"
                radius: 10
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 54
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                visible: true
                border.color: mainGameHerroStyleList.get(0).selected?"#ffbd09":"#00000000"
                border.width: mainGameHerroStyleList.get(0).selected?3:0

                Text {
                    id: text14
                    color: mainGameHerroStyleList.get(0).selected?"#ffbd09":"#c69c6d"
                    text: mainGameHerroStyleList.get(0).caption
                    anchors.left: parent.left
                    anchors.leftMargin: 7
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.bottomMargin: 0
                    renderType: Text.NativeRendering
                    font.bold: true
                    anchors.right: parent.right
                    font.family: "Myriad Pro"
                    anchors.rightMargin: 7
                    font.pixelSize: 20
                    anchors.topMargin: 4
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainGameHerroStyleList.setSelected(0);
                }
            }
        }

        Rectangle {
            id: rectangle15
            x: 324
            y: 719
            width: 214
            height: 52
            color: "#00000000"
            radius: 0
            visible: true
            opacity: enable?1:0.5
            Image {
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 1
                fillMode: Image.PreserveAspectFit
                source: "img/menu/Chek.png"
                visible: mainGameHerroStyleList.get(1).selected;
            }
            Rectangle {
                id: rectangle17
                width: 164
                height: 58
                color: "#00000000"
                radius: 10
                visible: true
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.bottomMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 54
                border.color: mainGameHerroStyleList.get(1).selected?"#ffbd09":"#00000000"
                border.width: mainGameHerroStyleList.get(1).selected?3:0
                anchors.topMargin: 0
                Text {
                    id: text16
                    color: mainGameHerroStyleList.get(1).selected?"#ffbd09":"#c69c6d"
                    text: mainGameHerroStyleList.get(1).caption
                    renderType: Text.NativeRendering
                    anchors.rightMargin: 7
                    anchors.leftMargin: 7
                    anchors.bottom: parent.bottom
                    font.bold: true
                    anchors.topMargin: 4
                    anchors.left: parent.left
                    horizontalAlignment: Text.AlignHCenter
                    anchors.right: parent.right
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Myriad Pro"
                    anchors.bottomMargin: 0
                    anchors.top: parent.top
                    font.pixelSize: 20
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainGameHerroStyleList.setSelected(1);
                }
            }
        }
    //}

}
