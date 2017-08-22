import QtQuick 2.0

Item {
    width: 450
    height: 200

    Rectangle {
        id: rectangle
        radius: 15
        border.color: "#c69c6d"
        border.width: 3
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
            }

            GradientStop {
                position: 1
                color: "#623113"
            }
        }
        anchors.fill: parent
        Text {
            id: name_label
            height: 40
            color: "#c69c6d"
            text: "ИГРОК_321"
            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 0
            fontSizeMode: Text.Fit
            font.pixelSize: 25
            renderType: Text.NativeRendering
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Myriad Pro"
        }

        Text {
            id: rank_label
            x: 5
            y: -8
            height: 40
            color: "#c69c6d"
            text: "рейтинг\n777"
            anchors.left: name_label.right
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            renderType: Text.NativeRendering
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.right: parent.right
            font.family: "Myriad Pro"
            anchors.top: parent.top
            font.bold: true
            font.pixelSize: 25
            anchors.rightMargin: 10
        }

        Image {
            id: image
            width: 100
            height: 100
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: name_label.bottom
            anchors.topMargin: 0
            source: "img/menu/player.png"
        }


        Grid {
            id: grid
            x: 116
            y: 40
            width: 329
            height: 100
            anchors.right: parent.right
            anchors.rightMargin: 10
            spacing: 10
            columns: 2

            Text {
                id: game_label
                width: parent.width*0.3
                height: 20
                color: "#000000"
                text: "игра:"
                fontSizeMode: Text.Fit
                font.family: "Myriad Pro"
                font.bold: true
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: game_names
                width: parent.width*0.65
                height: 20
                color: "#000000"
                text: "нарды,шашки"
                fontSizeMode: Text.Fit
                font.family: "Myriad Pro"
                font.bold: true
                horizontalAlignment: Text.AlignLeft
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
            }

            Text {
                id: style_label
                width: parent.width*0.3
                height: 20
                color: "#000000"
                text: "оформление:"
                fontSizeMode: Text.Fit
                font.family: "Myriad Pro"
                font.bold: true
                horizontalAlignment: Text.AlignRight
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
            }

            Text {
                id: style_names
                width: parent.width*0.65
                height: 20
                color: "#000000"
                text: "дерево, камень, метал"
                fontSizeMode: Text.Fit
                font.family: "Myriad Pro"
                font.bold: true
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: rules_label
                width: parent.width*0.3
                height: 20
                color: "#000000"
                text: "правила:"
                fontSizeMode: Text.Fit
                font.family: "Myriad Pro"
                font.bold: true
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: rules_names
                width: parent.width*0.65
                height: 20
                color: "#000000"
                text: "длинные нарды"
                fontSizeMode: Text.Fit
                font.family: "Myriad Pro"
                font.bold: true
                horizontalAlignment: Text.AlignLeft
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
            }
        }



        TableButton {
            id: tableButton
            x: 10
            y: 146
            width: 155
            height: 46
            opacity: 0
            caption: "ПРЕДЛОЖИТЬ ТРЕНИРОВКУ"
        }

        TableButton {
            id: tableButton1
            x: 285
            y: 146
            width: 155
            height: 46
            opacity: 0
            caption: "ПРЕДЛОЖИТЬ МАТЧ"
        }

        TableButton {
            id: tableButton2
            x: 148
            y: 146
            width: 155
            height: 46
            opacity: 0
            caption: "НАЧАТЬ ИГРУ"
        }
    }
    states: [
        State {
            name: "self_info"

            PropertyChanges {
                target: tableButton2
                opacity: 0
            }

            PropertyChanges {
                target: tableButton1
                opacity: 0
            }

            PropertyChanges {
                target: tableButton
                opacity: 0
            }
        },
        State {
            name: "user_info"

            PropertyChanges {
                target: tableButton1
                opacity: 1
            }

            PropertyChanges {
                target: tableButton
                opacity: 1
            }
        },
        State {
            name: "user_reqest"

            PropertyChanges {
                target: tableButton2
                opacity: 1
            }

            PropertyChanges {
                target: tableButton1
                opacity: 0
            }

            PropertyChanges {
                target: tableButton
                opacity: 0
            }
        }
    ]

}
