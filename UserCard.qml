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
                color: "#9b6835"
            }

            GradientStop {
                position: 1
                color: "#623113"
            }
        }
        anchors.fill: parent
        Text {
            width: 440
            height: 40
            color: "#c69c6d"
            text: "ИГРОК_321"
            fontSizeMode: Text.Fit
            font.pixelSize: 25
            renderType: Text.NativeRendering
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Myriad Pro"
        }

    }

}
