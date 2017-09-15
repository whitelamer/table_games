import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    property int index: 0
    property variant model: null
    property bool selected: model.get(index).selected
    property bool enable: model.get(index).enable
    property string caption: model.get(index).caption
    id: delegate_item
    width: model.get(index).width
    height: model.get(index).height
    //Rectangle {
    //id:delegate_image
    color: "transparent"
    //color: "white"
    border.width: selected?3:0
    border.color: selected?"#ffbd09":"transparent"
    //source: selected?img:img_
    opacity: enable?1:0.25
    //anchors.centerIn: parent
    radius: 20
    //anchors.fill: parent
    //width: parent.GridView.view.idealCellWidth
    //visible: enable

    Text {
        anchors.fill:parent
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        color: selected?"#ffbd09":"#c69c6d"
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
            model.setSelected(index);
            listUpdated();
        }
    }
    //}
    //    Desaturate{
    //        anchors.fill: delegate_image
    //        source: delegate_image
    //        cached: true
    //        opacity: enable?1:0.25
    //        visible: !enable
    //        desaturation: 0.75
    //    }
}

