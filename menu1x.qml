import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    property int player_b_state_match: 0;
    property int player_b_state_game: 0;
    property int player_b_state_decor: 0;
    property int player_b_state_style: 0;
    //{"match":0, "game":0, "decor":0, "style":0}
    //property var player_a_state: {"match":0, "game":0, "decor":0, "style":0}
    property int player_a_state_match: 0;
    property int player_a_state_game: 0;
    property int player_a_state_decor: 0;
    property int player_a_state_style: 0;
    id: item3
    width: 1280
    height: 1024

    Image {
        id: player_b_menu
        x: 0
        y: 0
        width: 640
        height: 1024
        source: "img/menu/fon_0_1.png"
        state:"menu1"

        Item {
            id: player_b_menu1
            anchors.fill: parent

            MouseArea {
                id: mouseArea
                anchors.fill: parent

                Image {
                    id: image2
                    x: 101
                    y: 398
                    visible: mouseArea.pressed
                    rotation: 180
                    source: "img/menu/seleát_00.png"
                }

                MouseArea {
                    id: mouseArea1
                    x: 260
                    y: 107
                    width: 120
                    height: 120
                    Image {
                        id: image4
                        visible: mouseArea1.pressed
                        rotation: 180
                        source: "img/menu/seleát_0.png"
                    }
                }
                enabled: player_a_menu.state=="menu1"||player_a_menu.state=="menu4"
                onClicked: {
                    player_b_menu.state="menu2"
                }
            }
        }

        Item {
            id: player_b_menu2
            anchors.fill: parent

            Image {
                id: image8
                x: 113
                y: 407
                rotation: 180
                visible: (player_b_state_game==2&&player_b_state_match==1)||(player_a_state_game==2&&player_a_state_match==1)
                source: "img/menu/sh.png"
            }
            Desaturate{
                anchors.fill: image8
                source: image8
                cached: true
                rotation: source.rotation
                visible: source.visible
                desaturation: player_a_state_game==0&&player_a_state_match==0?0:0.75
            }

            Image {
                id: image9
                x: 328
                y: 407
                visible: (player_b_state_game==1&&player_b_state_match==1)||(player_a_state_game==1&&player_a_state_match==1)
                source: "img/menu/n.png"
                rotation: 180
            }
            Desaturate{
                anchors.fill: image9
                source: image9
                cached: true
                rotation: source.rotation
                visible: source.visible
                desaturation: player_a_state_game==0&&player_a_state_match==0?0:0.75
            }

            Image {
                id: image10
                x: 221
                y: 517
                visible: (player_b_state_game==3&&player_b_state_match==2)||(player_a_state_game==3&&player_a_state_match==2)
                source: "img/menu/shs.png"
                rotation: 180
            }
            Desaturate{
                anchors.fill: image10
                source: image10
                cached: true
                rotation: source.rotation
                visible: source.visible
                desaturation: player_a_state_game==0&&player_a_state_match==0?0:0.75
            }
            Image {
                id: image11
                x: 113
                y: 590
                visible: (player_b_state_game==2&&player_b_state_match==2)||(player_a_state_game==2&&player_a_state_match==2)
                source: "img/menu/sh.png"
                rotation: 180
            }
            Desaturate{
                anchors.fill: image11
                source: image11
                cached: true
                rotation: source.rotation
                visible: source.visible
                desaturation: player_a_state_game==0&&player_a_state_match==0?0:0.75
            }

            Image {
                id: image12
                x: 328
                y: 591
                visible: (player_b_state_game==1&&player_b_state_match==2)||(player_a_state_game==1&&player_a_state_match==2)
                source: "img/menu/n.png"
                rotation: 180
            }
            Desaturate{
                anchors.fill: image12
                source: image12
                cached: true
                rotation: source.rotation
                visible: source.visible
                desaturation: player_a_state_game==0&&player_a_state_match==0?0:0.75
            }


            Image {
                id: image13
                x: 221
                y: 334
                visible: (player_b_state_game==3&&player_b_state_match==1)||(player_a_state_game==3&&player_a_state_match==1)
                source: "img/menu/shs.png"
                rotation: 180
            }
            Desaturate{
                anchors.fill: image13
                source: image13
                cached: true
                rotation: source.rotation
                visible: source.visible
                desaturation: player_a_state_game==0&&player_a_state_match==0?0:0.75
            }

            Image {
                id: image
                x: 113
                y: 754
                rotation: 180
                source: "img/menu/sel.png"
            }

            MouseArea {
                id: mouseArea4
                x: 86
                y: 154
                width: 145
                height: 145

                Image {
                    id: image5
                    x: 0
                    y: 0
                    visible: parent.pressed
                    rotation: 180
                    source: "img/menu/seleát_1.png"
                }
                onClicked: {
                    player_b_menu.state="menu3"
                }
            }

            MouseArea {
                id: mouseArea5
                x: 221
                y: 334
                width: 196
                height: 64
                enabled: player_a_state_game==0&&player_a_state_match==0
                onClicked: {
                    player_b_state_game=3;
                    player_b_state_match=1;
                }
            }

            MouseArea {
                id: mouseArea6
                x: 113
                y: 407
                width: 196
                height: 64
                enabled: player_a_state_game==0&&player_a_state_match==0
                onClicked: {
                    player_b_state_game=2;
                    player_b_state_match=1;
                }
            }

            MouseArea {
                id: mouseArea7
                x: 328
                y: 407
                width: 196
                height: 64
                enabled: player_a_state_game==0&&player_a_state_match==0
                onClicked: {
                    player_b_state_game=1;
                    player_b_state_match=1;
                }
            }

            MouseArea {
                id: mouseArea8
                x: 222
                y: 517
                width: 196
                height: 64
                enabled: player_a_state_game==0&&player_a_state_match==0
                onClicked: {
                    player_b_state_game=3;
                    player_b_state_match=2;
                }
            }

            MouseArea {
                id: mouseArea9
                x: 113
                y: 590
                width: 196
                height: 64
                enabled: player_a_state_game==0&&player_a_state_match==0
                onClicked: {
                    player_b_state_game=2;
                    player_b_state_match=2;
                }
            }

            MouseArea {
                id: mouseArea10
                x: 328
                y: 590
                width: 196
                height: 64
                enabled: player_a_state_game==0&&player_b_state_match==0
                onClicked: {
                    player_b_state_game=1;
                    player_b_state_match=2;
                }
            }

        }

        Item {
            id: player_b_menu3
            anchors.fill: parent

            Image {
                id: image21
                x: 113
                y: 754
                source: "img/menu/sel.png"
                rotation: 180
            }

            Image {
                id: image22
                x: 129
                y: 335
                rotation: 180
                source: "img/menu/e.png"
                visible: player_b_state_style==2||player_a_state_style==2
            }
            Desaturate{
                anchors.fill: image22
                source: image22
                cached: true
                rotation: source.rotation
                visible: source.visible
                desaturation: player_a_state_style==0?0:0.75
            }

            Image {
                id: image23
                x: 324
                y: 335
                source: "img/menu/a.png"
                rotation: 180
                visible: player_b_state_style==1||player_a_state_style==1
            }
            Desaturate{
                anchors.fill: image23
                source: image23
                cached: true
                rotation: source.rotation
                visible: source.visible
                desaturation: player_a_state_style==0?0:0.75
            }

            Image {
                id: image24
                x: 394
                y: 408
                source: "img/menu/d.png"
                rotation: 180
                visible: player_b_state_decor==1||player_a_state_decor==1
            }
            Desaturate{
                anchors.fill: image24
                source: image24
                cached: true
                rotation: source.rotation
                visible: source.visible
                desaturation: player_a_state_style==0?0:0.75
            }

            Image {
                id: image25
                x: 253
                y: 408
                source: "img/menu/k.png"
                rotation: 180
                visible: player_b_state_decor==2||player_a_state_decor==2
            }
            Desaturate{
                anchors.fill: image25
                source: image25
                cached: true
                rotation: source.rotation
                visible: source.visible
                desaturation: player_a_state_style==0?0:0.75
            }

            Image {
                id: image26
                x: 113
                y: 408
                source: "img/menu/m.png"
                rotation: 180
                visible: player_b_state_decor==3||player_a_state_decor==3
            }
            Desaturate{
                anchors.fill: image26
                source: image26
                cached: true
                rotation: source.rotation
                visible: source.visible
                desaturation: player_a_state_style==0?0:0.75
            }

            Image {
                id: image27
                x: 272
                y: 518
                source: "img/menu/00.png"
                rotation: 180
            }

            Image {
                id: image28
                x: 431
                y: 591
                source: "img/menu/15.png"
                rotation: 180
            }

            Image {
                id: image29
                x: 325
                y: 591
                source: "img/menu/30.png"
                rotation: 180
            }

            Image {
                id: image30
                x: 220
                y: 591
                source: "img/menu/45.png"
                rotation: 180
            }

            Image {
                id: image31
                x: 114
                y: 591
                source: "img/menu/60.png"
                rotation: 180
            }

            MouseArea {
                id: mouseArea18
                x: 81
                y: 155
                width: 145
                height: 145
                Image {
                    id: image7
                    x: 0
                    y: 0
                    rotation: 180
                    visible: parent.pressed
                    source: "img/menu/seleát_1.png"
                }
                onClicked: {
                    player_b_menu.state="menu4"
                }
            }

            MouseArea {
                id: mouseArea30
                x: 129
                y: 335
                width: 184
                height: 64
                enabled: player_a_state_style==0
                onClicked: {
                    player_b_state_style=2
                }
            }

            MouseArea {
                id: mouseArea31
                x: 324
                y: 335
                width: 184
                height: 64
                enabled: player_a_state_style==0
                onClicked: {
                    player_b_state_style=1
                }
            }

            MouseArea {
                id: mouseArea32
                x: 113
                y: 408
                width: 128
                height: 64
                enabled: player_a_state_decor==0
                onClicked: {
                    player_b_state_decor=3
                }
            }

            MouseArea {
                id: mouseArea33
                x: 253
                y: 408
                width: 128
                height: 64
                enabled: player_a_state_decor==0
                onClicked: {
                    player_b_state_decor=2
                }
            }

            MouseArea {
                id: mouseArea34
                x: 394
                y: 408
                width: 128
                height: 64
                enabled: player_a_state_decor==0
                onClicked: {
                    player_b_state_decor=1
                }
            }

            MouseArea {
                id: mouseArea35
                x: 431
                y: 591
                width: 92
                height: 64
            }

            MouseArea {
                id: mouseArea36
                x: 325
                y: 591
                width: 92
                height: 64
            }

            MouseArea {
                id: mouseArea37
                x: 220
                y: 591
                width: 92
                height: 64
            }

            MouseArea {
                id: mouseArea38
                x: 114
                y: 591
                width: 92
                height: 64
            }

            MouseArea {
                id: mouseArea39
                x: 272
                y: 518
                width: 92
                height: 64
            }
        }
        states: [
            State {
                name: "menu1"
                PropertyChanges {
                    target: player_b_menu
                    source: "img/menu/fon_0_1.png"
                }
                PropertyChanges {
                    target: player_b_menu1
                    visible:true
                }
                PropertyChanges {
                    target: player_b_menu2
                    visible:false
                }
                PropertyChanges {
                    target: player_b_menu3
                    visible:false
                }
            },
            State {
                name: "menu2"
                PropertyChanges {
                    target: player_b_menu
                    source: "img/menu/fon_11_1.png"
                }
                PropertyChanges {
                    target: player_b_menu1
                    visible:false
                }
                PropertyChanges {
                    target: player_b_menu2
                    visible:true
                }
                PropertyChanges {
                    target: player_b_menu3
                    visible:false
                }
            },
            State {
                name: "menu3"
                PropertyChanges {
                    target: player_b_menu
                    source: "img/menu/fon_22_1.png"
                }
                PropertyChanges {
                    target: player_b_menu1
                    visible:false
                }
                PropertyChanges {
                    target: player_b_menu2
                    visible:false
                }
                PropertyChanges {
                    target: player_b_menu3
                    visible:true
                }
            },
            State {
                name: "menu4"
                PropertyChanges {
                    target: player_b_menu
                    source: "img/menu/fon_33_1.png"
                }
                PropertyChanges {
                    target: player_b_menu1
                    visible:false
                }
                PropertyChanges {
                    target: player_b_menu2
                    visible:false
                }
                PropertyChanges {
                    target: player_b_menu3
                    visible:false
                }
            }
        ]
    }

    Image {
        id: player_a_menu
        width: 640
        height: 1024
        anchors.left: player_b_menu.right
        anchors.leftMargin: 0
        source: "img/menu/fon_0_2.png"
        state:"menu1"
        Item {
            id: player_a_menu1
            anchors.fill: parent

            MouseArea {
                id: mouseArea2
                anchors.fill: parent

                Image {
                    id: image1
                    x: 100
                    y: 314
                    visible: mouseArea2.pressed
                    source: "img/menu/seleát_00.png"
                }

                MouseArea {
                    id: mouseArea3
                    x: 260
                    y: 797
                    width: 120
                    height: 120

                    Image {
                        id: image3
                        visible: mouseArea3.pressed
                        source: "img/menu/seleát_0.png"
                    }
                }
                enabled: player_b_menu.state=="menu1"||player_b_menu.state=="menu4"
                onClicked: {
                    player_a_menu.state="menu2"
                }
            }
        }

        Item {
            id: player_a_menu2
            anchors.fill: parent

            Image {
                id: image14
                x: 223
                y: 443
                visible: player_a_state_game==3&&player_a_state_match==2
                source: "img/menu/shs.png"
            }

            Image {
                id: image15
                x: 330
                y: 369
                visible: player_a_state_game==2&&player_a_state_match==2
                source: "img/menu/sh.png"
            }

            Image {
                id: image16
                x: 115
                y: 369
                visible: player_a_state_game==1&&player_a_state_match==2
                source: "img/menu/n.png"
            }

            Image {
                id: image17
                x: 223
                y: 626
                visible: player_a_state_game==3&&player_a_state_match==1
                source: "img/menu/shs.png"
            }

            Image {
                id: image18
                x: 329
                y: 552
                visible: player_a_state_game==2&&player_a_state_match==1
                source: "img/menu/sh.png"
            }

            Image {
                id: image19
                x: 115
                y: 552
                visible: player_a_state_game==1&&player_a_state_match==1
                source: "img/menu/n.png"
            }

            Image {
                id: image6
                x: 447
                y: 196
                source: "img/menu/sel.png"
            }

            MouseArea {
                id: mouseArea11
                x: 223
                y: 626
                width: 196
                height: 64
                onClicked: {
                    player_a_state_game=3;
                    player_a_state_match=1;
                }
            }

            MouseArea {
                id: mouseArea12
                x: 330
                y: 552
                width: 196
                height: 64
                onClicked: {
                    player_a_state_game=2;
                    player_a_state_match=1;
                }

            }

            MouseArea {
                id: mouseArea13
                x: 115
                y: 552
                width: 196
                height: 64
                onClicked: {
                    player_a_state_game=1;
                    player_a_state_match=1;
                }

            }

            MouseArea {
                id: mouseArea14
                x: 223
                y: 443
                width: 196
                height: 64
                onClicked: {
                    player_a_state_game=3;
                    player_a_state_match=2;
                }

            }

            MouseArea {
                id: mouseArea15
                x: 330
                y: 369
                width: 196
                height: 64
                onClicked: {
                    player_a_state_game=2;
                    player_a_state_match=2;
                }

            }

            MouseArea {
                id: mouseArea16
                x: 115
                y: 369
                width: 196
                height: 64
                onClicked: {
                    player_a_state_game=1;
                    player_a_state_match=2;
                }

            }

            MouseArea {
                id: mouseArea17
                x: 413
                y: 725
                width: 145
                height: 145
                Image {
                    id: image44
                    x: 0
                    y: 0
                    visible: parent.pressed
                    source: "img/menu/seleát_1.png"
                }
                onClicked: {
                    player_a_menu.state="menu3"
                }
            }
        }

        Item {
            id: player_a_menu3
            anchors.fill: parent

            Image {
                id: image33
                x: 447
                y: 196
                source: "img/menu/sel.png"
            }

            Image {
                id: image34
                x: 326
                y: 625
                source: "img/menu/e.png"
                visible: player_a_state_style==2
            }

            Image {
                id: image35
                x: 131
                y: 625
                source: "img/menu/a.png"
                visible: player_a_state_style==1
            }

            Image {
                id: image36
                x: 117
                y: 552
                source: "img/menu/d.png"
                visible: player_a_state_decor==1
            }

            Image {
                id: image37
                x: 257
                y: 552
                source: "img/menu/k.png"
                visible: player_a_state_decor==2
            }

            Image {
                id: image38
                x: 397
                y: 552
                source: "img/menu/m.png"
                visible: player_a_state_decor==3
            }

            Image {
                id: image39
                x: 275
                y: 442
                source: "img/menu/00.png"
            }

            Image {
                id: image40
                x: 116
                y: 369
                source: "img/menu/15.png"
            }

            Image {
                id: image41
                x: 222
                y: 369
                source: "img/menu/30.png"
            }

            Image {
                id: image42
                x: 328
                y: 369
                source: "img/menu/45.png"
            }

            Image {
                id: image43
                x: 433
                y: 369
                source: "img/menu/60.png"
            }

            MouseArea {
                id: mouseArea19
                x: 413
                y: 725
                width: 145
                height: 145
                Image {
                    id: image45
                    x: 0
                    y: 0
                    visible: parent.pressed
                    source: "img/menu/seleát_1.png"
                }
                onClicked: {
                    player_a_menu.state="menu4"
                }
            }

            MouseArea {
                id: mouseArea20
                x: 116
                y: 369
                width: 92
                height: 64
            }

            MouseArea {
                id: mouseArea21
                x: 222
                y: 369
                width: 92
                height: 64
            }

            MouseArea {
                id: mouseArea22
                x: 328
                y: 369
                width: 92
                height: 64
            }

            MouseArea {
                id: mouseArea23
                x: 433
                y: 369
                width: 92
                height: 64
            }

            MouseArea {
                id: mouseArea24
                x: 275
                y: 442
                width: 92
                height: 64
            }

            MouseArea {
                id: mouseArea25
                x: 117
                y: 552
                width: 128
                height: 64
                onClicked: {
                    player_a_state_decor=1
                }
            }

            MouseArea {
                id: mouseArea26
                x: 257
                y: 552
                width: 128
                height: 64
                onClicked: {
                    player_a_state_decor=2
                }
            }

            MouseArea {
                id: mouseArea27
                x: 397
                y: 552
                width: 128
                height: 64
                onClicked: {
                    player_a_state_decor=3
                }
            }

            MouseArea {
                id: mouseArea28
                x: 131
                y: 625
                width: 184
                height: 64
                onClicked: {
                    player_a_state_style=1
                }
            }

            MouseArea {
                id: mouseArea29
                x: 326
                y: 625
                width: 184
                height: 64
                onClicked: {
                    player_a_state_style=2
                }
            }
        }
        states: [
            State {
                name: "menu1"
                PropertyChanges {
                    target: player_a_menu
                    source: "img/menu/fon_0_2.png"
                }
                PropertyChanges {
                    target: player_a_menu1
                    visible:true
                }
                PropertyChanges {
                    target: player_a_menu2
                    visible:false
                }
                PropertyChanges {
                    target: player_a_menu3
                    visible:false
                }
            },
            State {
                name: "menu2"
                PropertyChanges {
                    target: player_a_menu
                    source: "img/menu/fon_11_2.png"
                }
                PropertyChanges {
                    target: player_a_menu1
                    visible:false
                }
                PropertyChanges {
                    target: player_a_menu2
                    visible:true
                }
                PropertyChanges {
                    target: player_a_menu3
                    visible:false
                }
            },
            State {
                name: "menu3"
                PropertyChanges {
                    target: player_a_menu
                    source: "img/menu/fon_22_2.png"
                }
                PropertyChanges {
                    target: player_a_menu1
                    visible:false
                }
                PropertyChanges {
                    target: player_a_menu2
                    visible:false
                }
                PropertyChanges {
                    target: player_a_menu3
                    visible:true
                }
            },
            State {
                name: "menu4"
                PropertyChanges {
                    target: player_a_menu
                    source: "img/menu/fon_33_2.png"
                }
                PropertyChanges {
                    target: player_a_menu1
                    visible:false
                }
                PropertyChanges {
                    target: player_a_menu2
                    visible:false
                }
                PropertyChanges {
                    target: player_a_menu3
                    visible:false
                }
            }
        ]
    }
    Desaturate {
        id: effect_b_menu
        anchors.fill: player_b_menu
        source: player_b_menu
        //cached: true
        desaturation:player_a_menu.state=="menu1"||player_a_menu.state=="menu4"?0:0.75
    }
    Desaturate {
        id: effect_a_menu
        anchors.fill: player_a_menu
        source: player_a_menu
        //cached: true
        desaturation:player_b_menu.state=="menu1"||player_b_menu.state=="menu4"?0:0.75
    }
}
