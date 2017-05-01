import QtQuick 2.0
import "./GameLogic.js" as Game_Logic


Row{
    property int p_ind: 6+index
    layoutDirection: Qt.RightToLeft
    height: 97
    width: 1438
    spacing: 2
    z:1

    Rectangle{
        id:rec_shift
        width: 50+Game_Logic.get_count(p_ind)*99;
        height: 97;
        color: "transparent"
    }
    DropArea {
        width: 141; height: 100
        enabled: Game_Logic.can_drop_fishka(drag_row_index,p_ind)//drag_row_index!=p_ind&&drag_row_index>=0
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
            Game_Logic.make_turn(drop.source.pindex,p_ind);
            updateAfterDrop(drop.source.pindex,p_ind)
            return Qt.MoveAction;
        }
        Connections{
            target: main_form
            onGamestateChanged:{ enabled=Game_Logic.can_drop_fishka(drag_row_index,p_ind);}
        }
    }
    function updateModel(src, dst){
        rec_shift.width = 50+Game_Logic.get_count(p_ind)*99;
    }
    Component.onCompleted: {
        main_form.updateAfterDrop.connect(updateModel)
    }
}
