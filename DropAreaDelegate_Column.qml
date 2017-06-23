import QtQuick 2.0


Column{
    property int p_ind: 6+index
    property int fiska_size: 106
//    height: 106
//    width: 1438
    //spacing: 2
    z:1

    Rectangle{
        id:rec_shift
        height: 20+(gameLogic.get_count(p_ind)-(gameLogic.drag_row_index==p_ind?1:0))*fiska_size;
        width: fiska_size;
        color: "transparent"
    }
    DropArea {
        height: fiska_size*2; width: fiska_size
        enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,p_ind)
        visible:enabled
        Rectangle {
            radius: 50
            //anchors.topMargin: -4
            //anchors.rightMargin: -6
            opacity: parent.containsDrag?0.5:0.2
            anchors.fill: parent
            color: "green"
        }
        onDropped: {
            gameLogic.make_turn(drop.source.pindex,p_ind);
            //updateAfterDrop(drop.source.pindex,p_ind)
            return Qt.MoveAction;
        }
//        Connections{
//            target: main_form
//            onGamestateChanged:{ enabled=gameLogic.can_drop_fishka(gameLogic.drag_row_index,p_ind);}
//        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: parent.enabled&&main_form.drag_need_resume
            onClicked: {
                gameLogic.make_turn(gameLogic.drag_row_index,p_ind);
            }
//            onPositionChanged: {
//                if(main_form.drag_item!=null&&main_form.drag_need_resume==true){
//                    var frommouse=main_form.mapFromItem(this,mouse.x,mouse.y)
//                    var point=main_form.mapToItem(main_form.drag_item.parent,frommouse.x,frommouse.y)
//                    main_form.drag_item.x=point.x-48
//                    main_form.drag_item.y=point.y-48
//                }
//            }
        }
    }
    function updateModel(src, dst){
//        rec_shift.width = 50+gameLogic.get_count(p_ind)*99;
    }
    Component.onCompleted: {
        //main_form.updateAfterDrop.connect(updateModel)
    }
}
