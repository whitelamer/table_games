import QtQuick 2.0

Rectangle {
    property string caption: ""
    signal clicked
    id: bnt_rec
    x: 119
    y: 737
    width: 400
    height: 80
    radius: 20
    Text {
        id: text8
        color: "#c69c6d"
        text: caption
        font.pixelSize: 28
        renderType: Text.NativeRendering
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        font.family: "Myriad Pro"
    }
    MouseArea {
        anchors.fill: parent
        enabled: bnt_rec.enabled
        onClicked: {
            bnt_rec.clicked(mouse);
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
