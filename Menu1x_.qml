import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    property string user_name: ""
    property int index: 0
    width: 640
    height: 1024
    id: player_menu
    state: "menu1"
    Image {
        id: player_menu_img
        source: "img/menu/fon_.png"
    }
    Image {
        id: image1
        x: 494
        y: 823
        width: 109
        height: 110
        opacity: 0
        source: "img/menu/seleát_1.png"

        MouseArea {
            id: mouseArea5
            anchors.fill: parent
        }
    }

    Image {
        id: image5
        x: 205
        y: 823
        width: 233
        height: 110
        opacity: 0
        source: "img/menu/image14.png"

        Text {
            id: text7
            color: "#ed0000"
            text: "500р Нажми  для пополнения"
            wrapMode: Text.WordWrap
            fontSizeMode: Text.Fit
            font.pixelSize: 25
            renderType: Text.NativeRendering
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            font.family: "Myriad Pro"
        }

        MouseArea {
            id: mouseArea6
            x: -9
            y: -4
            anchors.fill: parent
        }
    }

    Image {
        id: image3
        x: 34
        y: 858
        width: 148
        height: 75
        opacity: 0
        source: "img/menu/image14.png"

        Text {
            id: text6
            color: "#ed0000"
            text: "ВЫХОД"
            anchors.fill: parent
            fontSizeMode: Text.Fit
            font.pixelSize: 25
            renderType: Text.NativeRendering
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Myriad Pro"
        }

        MouseArea {
            id: mouseArea4
            anchors.fill: parent
            onClicked: {
                leave_player(player_menu.index);
                player_menu.state="menu1"
            }
        }
    }

    Timer{
        id:login_timer
        running: false
        interval: 30000
        onTriggered: {
            leave_player(player_menu.index);
            player_menu.state="menu1"
        }
    }

    Item {
        id: player_menu1
        opacity: 0
        anchors.fill: parent

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            enabled: player_menu1.opacity==1
            Image {
                id: image2
                x: 100
                y: 314
                visible: mouseArea.pressed
                source: "img/menu/seleát_00.png"
            }

            MouseArea {
                id: mouseArea1
                x: 260
                y: 797
                width: 120
                height: 120
                enabled: player_menu1.opacity==1
                Image {
                    id: image4
                    visible: mouseArea1.pressed
                    source: "img/menu/seleát_0.png"
                }
            }
            onClicked: {
                have_player(player_menu.index);
                player_menu.state="menu2"
                login_timer.start();
            }
        }
    }

    Item {
        id: player_menu2
        opacity: 0
        anchors.fill: parent

        Text {
            id: text1
            x: 99
            y: 155
            width: 440
            height: 100
            color: "#c69c6d"
            text: qsTr("ПРИВЕДСТВУЕМ")
            font.pixelSize: 45
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Myriad Pro"
            fontSizeMode: Text.Fit
            renderType: Text.NativeRendering
        }

        Rectangle {
            id: rectangle
            x: 99
            y: 405
            width: 440
            height: 115
            radius: 20
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#623113"
                }

                GradientStop {
                    position: 1
                    color: "#321405"
                }
            }
            border.width: 0

            Text {
                id: text2
                color: "#c69c6d"
                text: qsTr("ВОЙТИ ПОЛЬЗОВАТЕЛЕМ")
                font.bold: true
                font.family: "Myriad Pro"
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                renderType: Text.NativeRendering
                font.pixelSize: 28
            }

            MouseArea {
                id: mouseArea2
                anchors.fill: parent
                enabled: player_menu2.opacity==1
                onClicked: {
                    user_name="МИХА"
                    player_menu.state="menu3"
                    login_timer.stop();
                }
            }
        }

        Rectangle {
            id: rectangle1
            x: 119
            y: 698
            width: 400
            height: 80
            radius: 20
            Text {
                id: text3
                color: "#c69c6d"
                text: qsTr("ГОСТЕВОЙ ВХОД")
                anchors.fill: parent
                font.pixelSize: 28
                renderType: Text.NativeRendering
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Myriad Pro"
            }

            MouseArea {
                id: mouseArea3
                anchors.fill: parent
                enabled: player_menu2.opacity==1
                onClicked: {
                    user_name="ГОСТЬ"
                    player_menu.state="menu3"
                    login_timer.stop();
                }
            }
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#623113"
                }

                GradientStop {
                    position: 1
                    color: "#321405"
                }
            }
            border.width: 0
        }

        Image {
            id: image
            x: 151
            y: 518
            source: "img/menu/social_btn.png"
        }
    }


    Item {
        id: player_menu3
        opacity: 0
        anchors.fill: parent
        enabled: opacity==1
        Text {
            id: text4
            x: 99
            y: 155
            width: 440
            height: 100
            color: "#c69c6d"
            text: "ПРИВЕДСТВУЕМ\n" + user_name
            anchors.horizontalCenter: parent.horizontalCenter
            fontSizeMode: Text.Fit
            font.pixelSize: 45
            renderType: Text.NativeRendering
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Myriad Pro"
        }

        Text {
            id: text5
            x: 99
            y: 255
            width: 440
            height: 40
            color: "#c69c6d"
            text: "ВЫБЕРИТЕ ИГРЫ"
            fontSizeMode: Text.Fit
            font.pixelSize: 25
            renderType: Text.NativeRendering
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Myriad Pro"
        }

        Flow {
            id: gameGridView
            x: 99
            width: 440
            height: 128
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text5.bottom
            anchors.topMargin: 0
            Repeater{
                id:gameRepView
                model: getGameList(player_menu.index);
                delegate:ListsDelegate{
                    parentmodel: getGameList(player_menu.index);
                }
            }
        }

        Flow {
            id: typeGridView
            x: 99
            width: 440
            height: 64
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text9.bottom
            anchors.topMargin: 0
            Repeater{
                id:typeRepView
                model: getTypeList(player_menu.index);
                delegate:ListsDelegate{
                    parentmodel: getTypeList(player_menu.index);
                }
            }
        }

        Rectangle {
            id: rectangle2
            x: 119
            y: 737
            width: 400
            height: 80
            radius: 20
            Text {
                id: text8
                color: "#c69c6d"
                text: qsTr("ДОП ОПЦИИ >")
                font.pixelSize: 28
                renderType: Text.NativeRendering
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                font.family: "Myriad Pro"
            }

            MouseArea {
                id: mouseArea7
                anchors.fill: parent
                enabled: player_menu3.opacity==1
                onClicked: {
                    if(player_menu.state=="menu3")
                        player_menu.state="menu4"
                    else
                        player_menu.state="menu3"
                }
            }
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#623113"
                }

                GradientStop {
                    position: 1
                    color: "#321405"
                }
            }
            border.width: 0
        }

        Text {
            id: text9
            x: 99
            width: 440
            height: 40
            color: "#c69c6d"
            text: "РЕЖИМЫ И СТОИМОСТЬ ИГР"
            anchors.top: gameGridView.bottom
            anchors.topMargin: 0
            fontSizeMode: Text.Fit
            font.pixelSize: 25
            renderType: Text.NativeRendering
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Myriad Pro"
        }

        Flow {
            id: timeGridView
            enabled: opacity==1
            width: 440
            height: 130
            Repeater {
                id: timeRepView
                model: getTimeList(player_menu.index)
                ListsDelegate {
                    parentmodel: getTimeList(player_menu.index)
                }
            }
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            anchors.top: typeGridView.bottom
        }
        TabView {
            id: options
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            anchors.top: typeGridView.bottom
            width: 440
            height: 194
            enabled: opacity==1
            Tab {
                title: "ОФОРМЛЕНИЕ"

                Flow {
                    id: styleGridView
                    width: 440
                    height: 64
                    Repeater {
                        id: styleRepView
                        model: getStyleList(player_menu.index)
                        ListsDelegate {
                            parentmodel: getStyleList(player_menu.index)
                        }
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 10
                }
            }
            Tab {
                title: "ПРАВИЛА"
            }
            Tab {
                title: "МОЙ КАБИНЕТ"
            }
            style: TabViewStyle {
                frameOverlap: 5
                frame: Rectangle {
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#623113"
                        }

                        GradientStop {
                            position: 1
                            color: "#321405"
                        }
                    }
                    radius: 15
                }
                tab: Rectangle {
                    color: "transparent"//styleData.selected ? "steelblue" :"lightsteelblue"
                    //border.color:  "steelblue"
                    implicitWidth: 146
                    implicitHeight: 45
                    Rectangle{
                        //color: "#e6e7e8"
                        opacity: styleData.selected ? 1.0 :0.5
                        radius: 10
                        anchors.fill: parent
                        gradient: Gradient {
                            GradientStop {
                                position: 0
                                color: "#623113"
                            }

                            GradientStop {
                                position: 1
                                color: "#321405"
                            }
                        }
                    }
                    Text {
                        text: styleData.title
                        font.bold: true
                        color: "#c69c6d"
                        fontSizeMode: Text.Fit
                        font.pixelSize: 25
                        anchors.fill: parent
                        renderType: Text.NativeRendering
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        font.family: "Myriad Pro"
                        //color: styleData.selected ? "white" : "black"
                    }
                }
            }
        }
    }

    Item {
        id: player_menu4
        anchors.fill: parent
        opacity: 1
    }



    states: [
        State {
            name: "menu1"

            PropertyChanges {
                target: player_menu1
                opacity: 1
            }

            PropertyChanges {
                target: player_menu2
                opacity: 0
            }

            PropertyChanges {
                target: player_menu_img
                source: "img/menu/fon_0_2.png"
            }

            PropertyChanges {
                target: player_menu3
                opacity: 0
            }

            PropertyChanges {
                target: image1
                opacity: 0
            }

            PropertyChanges {
                target: image3
                opacity: 0
            }

            PropertyChanges {
                target: image5
                opacity: 0
            }

            PropertyChanges {
                target: player_menu4
                opacity: 0
            }
        },
        State {
            name: "menu2"

            PropertyChanges {
                target: player_menu1
                opacity: 0
            }

            PropertyChanges {
                target: player_menu_img
                source: "img/menu/fon_.png"
            }

            PropertyChanges {
                target: text1
                opacity: 1
            }

            PropertyChanges {
                target: player_menu2
                opacity: 1
            }

            PropertyChanges {
                target: player_menu3
                opacity: 0
            }

            PropertyChanges {
                target: image1
                opacity: 0
            }

            PropertyChanges {
                target: image3
                opacity: 0
            }

            PropertyChanges {
                target: image5
                opacity: 0
            }

            PropertyChanges {
                target: player_menu4
                opacity: 0
            }
        },
        State {
            name: "menu3"
            PropertyChanges {
                target: player_menu1
                opacity: 0
            }

            PropertyChanges {
                target: player_menu_img
                source: "img/menu/fon_.png"
            }

            PropertyChanges {
                target: text1
                opacity: 1
            }

            PropertyChanges {
                target: player_menu2
                opacity: 0
            }

            PropertyChanges {
                target: player_menu3
                opacity: 1
            }

            PropertyChanges {
                target: image1
                opacity: 1
            }

            PropertyChanges {
                target: image3
                opacity: 1
            }

            PropertyChanges {
                target: mouseArea4
                opacity: 1
            }

            PropertyChanges {
                target: image5
                opacity: 1
            }

            PropertyChanges {
                target: options
                opacity: 0
            }

            PropertyChanges {
                target: player_menu4
                opacity: 0
            }

        },
        State {
            name: "menu4"
            PropertyChanges {
                target: player_menu1
                opacity: 0
            }

            PropertyChanges {
                target: player_menu_img
                source: "img/menu/fon_.png"
            }

            PropertyChanges {
                target: text1
                opacity: 1
            }

            PropertyChanges {
                target: player_menu2
                opacity: 0
            }

            PropertyChanges {
                target: player_menu3
                opacity: 1
            }

            PropertyChanges {
                target: image1
                opacity: 1
            }

            PropertyChanges {
                target: image3
                opacity: 1
            }

            PropertyChanges {
                target: mouseArea4
                opacity: 1
            }

            PropertyChanges {
                target: image5
                opacity: 1
            }

            PropertyChanges {
                target: timeGridView
                opacity: 0
            }

            PropertyChanges {
                target: text8
                text: qsTr("< ВРЕМЯ ИГРЫ")
            }

            PropertyChanges {
                target: options
                opacity: 1
            }

            PropertyChanges {
                target: player_menu4
                opacity: 0
            }
        },
        State {
            name: "menu5"
            PropertyChanges {
                target: player_menu1
                opacity: 0
            }

            PropertyChanges {
                target: player_menu_img
                source: "img/menu/fon_.png"
            }

            PropertyChanges {
                target: text1
                opacity: 1
            }

            PropertyChanges {
                target: player_menu2
                opacity: 0
            }

            PropertyChanges {
                target: player_menu3
                opacity: 0
            }

            PropertyChanges {
                target: image1
                opacity: 0
            }

            PropertyChanges {
                target: image3
                opacity: 0
            }

            PropertyChanges {
                target: image5
                opacity: 0
            }

            PropertyChanges {
                target: player_menu4
                opacity: 1
            }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation { properties: "opacity"; easing.type: Easing.Linear; duration: 250 }
        }
    ]
    function updateList(){
        gameRepView.update();
        typeRepView.update();
    }
}
