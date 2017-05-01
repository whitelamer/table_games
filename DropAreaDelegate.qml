import QtQuick 2.0


Row{
    property int p_ind: 6+index
    layoutDirection: Qt.RightToLeft
    height: 97
    width: 1438
    spacing: 2
    z:1

    Rectangle{
        id:rec_shift
        width: 50+(gameLogic.get_count(p_ind)-(gameLogic.drag_row_index==p_ind?1:0))*99;
        height: 97;
        color: "transparent"
    }
    DropArea {
        width: 141; height: 100
        enabled: gameLogic.can_drop_fishka(gameLogic.drag_row_index,p_ind)
        visible:enabled
        Rectangle {
            radius: 50
            anchors.topMargin: -5
            anchors.rightMargin: -5
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
