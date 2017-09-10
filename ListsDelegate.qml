import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    property variant parentmodel: null
    id: delegate_item
    width: 146
    height: 50
    Image {
        id:delegate_image
        source: selected?img:img_
        opacity: enable?1:0.25
        anchors.centerIn: parent
        //width: parent.GridView.view.idealCellWidth
        //visible: enable
        Text {
            anchors.fill:parent
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            color: "#c69c6d"
            text: caption!=undefined?caption:""
            fontSizeMode: Text.Fit
            font.pixelSize: 25
            renderType: Text.NativeRendering
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Myriad Pro"
        }
        MouseArea{
            anchors.fill: parent
            enabled: enable
            onClicked: {
                //parentmodel.set(index,{"selected":!selected});
                parentmodel.setSelected(index);
                listUpdated();
            }
        }
    }
    Desaturate{
        anchors.fill: delegate_image
        source: delegate_image
        cached: true
        opacity: enable?1:0.25
        visible: !enable
        desaturation: 0.75
    }
}

