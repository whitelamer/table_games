import QtQuick 2.0

Rectangle{
    id: drop_rect
    color:"transparent"
    property int p_ind: 12
    property string img: ""
    DropArea {
        id:drop_area
        anchors.fill: parent
        enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
        visible:enabled
        Image {
            id:area_img
            opacity: drop_area.containsDrag?1.0:1.0
            anchors.fill: parent
            source: img
            SequentialAnimation{
                NumberAnimation {
                    target: area_img
                    property: "opacity"
                    duration: 1000
                    from: 0
                    to:1
                    easing.type: Easing.Linear
                }
                NumberAnimation {
                    target: area_img
                    property: "opacity"
                    duration: 1000
                    from: 1
                    to:0
                    easing.type: Easing.Linear
                }
                loops: Animation.Infinite
                running: parent.visible&&!drop_area.containsDrag
            }
        }
        onDropped: {
            console.log("onDropped:"+main_form.drag_item)
            gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
            drop.source.drop_link=parent;
            drop.source.index=gameLogic.get_count(parent.p_ind)-1;
            return Qt.MoveAction;
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: parent.enabled&&main_form.drag_need_resume
            onClicked: {
                console.log("onClicked:",main_form.drag_item,parent.parent)
                gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                main_form.drag_item.drop_link=parent.parent;
                main_form.drag_item.index=gameLogic.get_count(parent.parent.p_ind)-1;
                gameLogic.setFishkaShadow(true,main_form.drag_item.dddindex);
                main_form.drag_item=null;
            }
        }
    }
    //    Component.onCompleted: {
    //        var tmp=drop_areas;
    //        tmp[p_ind]=this;
    //        drop_areas=tmp;
    //        console.log("{x:",this.x,",y:",this.y,",width:",this.width,",height:",this.height,",rotation:",this.rotation,"}")
    //        createFishkas(p_ind);
    //    }
}
