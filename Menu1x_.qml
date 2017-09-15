import QtQuick 2.0
//import QtQuick.Controls 1.4
//import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Item {
    property string user_name: ""
    property int index: 0
    width: 640
    height: 1024
    id: player_menu
    state: "menu1"
    Image {
        id: player_menu_img
        source: "img/menu/Back-1.png"
    }

    Image {
        id: start_image_disable
        x: 400
        y: 784
        source: "img/menu/sel_d_0.png"
    }
    Image {
        id: start_image_hover
        x: 400
        y: 784
        visible: mouseArea5.pressed
        source: "img/menu/sel_d_000.png"
    }
    Image {
        id: start_button
        x: 400
        y: 784
        visible: player_menu.state!="menu1"&&player_menu.state!="menu2"&&checkCanStart();
        opacity: 0
        source: "img/menu/sel_d_00.png"
        MouseArea {
            id: mouseArea5
            anchors.fill: parent
            onClicked: {
                if(board_mode==1){
                    if(!canStartGame()){
                        player_menu.state="menu6"
                    }
                }else{
                    player_menu.state="menu5"
                }
            }
        }

        SequentialAnimation{
            running: start_button.visible&&!mouseArea5.pressed
            NumberAnimation {
                target: start_button
                property: "opacity"
                duration: 1000
                from: 0.1
                to:1
                easing.type: Easing.Linear
            }
            NumberAnimation {
                target: start_button
                property: "opacity"
                duration: 1000
                from: 1
                to:0.1
                easing.type: Easing.Linear
            }
            loops: Animation.Infinite
        }
    }

    MouseArea {
        id: back_button
        x: 69
        y: 47
        width: 172
        height: 172
        onClicked: {
            leave_player(player_menu.index);
            //player_menu.state="menu1"
            login_timer.stop();
        }

        Image {
            id: back_image
            visible: parent.pressed
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "img/menu/sel_000.png"
        }
    }

    Timer{
        id:login_timer
        running: false
        interval: 30000
        onTriggered: {
            leave_player(player_menu.index);
            //player_menu.state="menu1"
        }
    }

    Item {
        id: player_menu1
        opacity: 0
        anchors.fill: parent

        //        MouseArea {
        //            id: mouseArea
        //            anchors.fill: parent
        //            enabled: player_menu1.opacity==1
        //            Image {
        //                id: image2
        //                x: 100
        //                y: 314
        //                visible: mouseArea.pressed
        //                source: "img/menu/seleát_00.png"
        //            }
        //            onClicked: {
        //                have_player(player_menu.index);
        //                if(board_mode==0)
        //                    player_menu.state="menu1_2"
        //                else
        //                    if(board_mode==1)
        //                        player_menu.state="menu2"
        //                login_timer.start();
        //            }
        //        }

        MouseArea {
            id: mouseArea1
            x: 166
            y: 394
            width: 308
            height: 241
            enabled: player_menu1.opacity==1
            Image {
                id: image4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: mouseArea1.pressed
                source: "img/menu/sel_0.png"
            }
        }

        MouseArea {
            id: mouseArea8
            x: 88
            y: 89
            width: 250
            height: 250
            enabled: parent.opacity==1
            onClicked: {
                have_player(player_menu.index);
                login_timer.stop;
                setGemeboardMode(1);
                player_menu.state="menu_offline"
            }

            Image {
                id: image6
                x: 239
                y: 344
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: mouseArea8.pressed
                source: "img/menu/sel_02.png"
            }
        }

        MouseArea {
            id: mouseArea9
            x: 301
            y: 89
            width: 250
            height: 250
            enabled: parent.opacity==1
            onClicked: {
                have_player(player_menu.index);
                login_timer.start();
                setGemeboardMode(2);
                player_menu.state="menu2"
            }

            Image {
                id: image7
                x: 239
                y: 579
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                visible: mouseArea9.pressed
                source: "img/menu/sel_01.png"
            }
        }

        Image {
            id: image2
            x: 67
            y: 688
            source: "img/menu/sel_00.png"
        }

        Image {
            id: image8
            x: 550
            y: 688
            source: "img/menu/sel_00.png"
        }

        Image {
            id: image9
            x: 67
            y: 50
            rotation: 180
            source: "img/menu/sel_00.png"
        }

        Image {
            id: image10
            x: 550
            y: 50
            rotation: 180
            source: "img/menu/sel_00.png"
        }
        SequentialAnimation{
            running: parent.opacity==1
            NumberAnimation {
                targets: [image10,image9,image8,image2]
                property: "opacity"
                duration: 1000
                from: 0
                to:1
                easing.type: Easing.Linear
            }
            NumberAnimation {
                targets: [image10,image9,image8,image2]
                property: "opacity"
                duration: 1000
                from: 1
                to:0
                easing.type: Easing.Linear
            }
            loops: Animation.Infinite
        }
    }

    Item {
        id: player_menu2
        opacity: 0
        anchors.fill: parent

        Text {
            id: text1
            x: 99
            y: 267
            width: 440
            height: 52
            color: "#42210b"
            text: qsTr("ПРИВЕТСТВУЕМ")
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
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
            x: 100
            y: 366
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
                    userLogin(player_menu.index,"МИХА")
                    player_menu.state="menu3"
                    login_timer.stop();
                }
            }
        }

        Rectangle {
            id: rectangle1
            x: 121
            y: 651
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
                    userLogin(player_menu.index,"ГОСТЬ")
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
            x: 152
            y: 480
            source: "img/menu/social_btn.png"
        }
    }


    Item {
        id: player_menu3
        opacity: 0
        anchors.fill: parent
        enabled: opacity==1
        GameSelectMenu{
            id:gameselectmenu
            anchors.fill: parent
            index: player_menu.index
            enable:main_user==player_menu.index
        }
        GameSettingsMenu{
            id:gamesettingsmenu
            anchors.fill: parent
            index: player_menu.index
            enable:main_user==player_menu.index
        }
        Text {
            id: text_user_need_pay
            x: 264
            y: 848
            width: 100
            height: 27
            color: "#ffbd09"
            text: user_pay_selected
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            fontSizeMode: Text.Fit
            renderType: Text.NativeRendering
            font.bold: true
            font.family: "Myriad Pro"
            font.pixelSize: 30
        }

        Text {
            id: text_user_balance
            x: 264
            y: 885
            width: 100
            height: 27
            color: "#ffbd09"
            text: user_balance
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.Fit
            renderType: Text.NativeRendering
            font.bold: true
            font.family: "Myriad Pro"
            font.pixelSize: 30
        }
    }

    Image {
        id: game_mode_image
        x: 421
        y: 45
        source: {
            switch(board_mode){
            case 1:
                return "img/menu/3_+.png";
            case 2:
                return "img/menu/2_+.png";
            case 3:
                return "img/menu/1_+.png";
            }
            return "";
        }

        //source: "img/menu/3_+.png"
    }

    Item {
        id: player_menu4
        anchors.fill: parent
        opacity: 1
        enabled: opacity==1

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
                source: "img/menu/fon_0_1-19.png"
            }

            PropertyChanges {
                target: player_menu3
                opacity: 0
            }

            PropertyChanges {
                target: back_image
                opacity: 0
            }

            PropertyChanges {
                target: player_menu4
                opacity: 0
            }

            PropertyChanges {
                target: game_mode_image
                opacity: 0
            }

            PropertyChanges {
                target: start_image_disable
                opacity: 0
                visible: false
            }
        },
        State {
            name: "menu_login"

            PropertyChanges {
                target: player_menu1
                opacity: 0
            }

            PropertyChanges {
                target: player_menu_img
                source: "img/menu/fon_0_1-19-19copy_+.png"
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
                target: player_menu4
                opacity: 0
            }

            PropertyChanges {
                target: image6
                opacity: 0
            }

            PropertyChanges {
                target: image7
                opacity: 0
            }

            PropertyChanges {
                target: rectangle
                opacity: 1
            }

            PropertyChanges {
                target: rectangle1
                opacity: 1
            }

            PropertyChanges {
                target: image
                opacity: 1
            }

            PropertyChanges {
                target: start_image_disable
                opacity: 1
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
                source: "img/menu/fon_0_1-19-19copy_+.png"
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
                target: back_button
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
                source: "img/menu/fon_0_1-19-19copy_+.png"
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
                target: back_button
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

            PropertyChanges {
                target: typeGridView
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
                source: "img/menu/fon_0_1-19-19copy_+.png"
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
                target: player_menu4
                opacity: 1
            }
        },
        State {
            name: "menu6"
            PropertyChanges {
                target: player_menu1
                opacity: 0
            }

            PropertyChanges {
                target: player_menu_img
                source: "img/menu/fon_0_1-19-19copy_+.png"
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
                target: player_menu4
                opacity: 1
            }
        },
        State {
            name: "menu_offline"
            PropertyChanges {
                target: player_menu1
                opacity: 0
            }

            PropertyChanges {
                target: player_menu_img
                x: 0
                y: 0
                source: "img/menu/Back-1.png"
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
                target: back_button
                opacity: 1
            }

            PropertyChanges {
                target: player_menu4
                opacity: 0
            }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation { properties: "opacity,x,y"; easing.type: Easing.Linear; duration: 250 }
        }
    ]
}
