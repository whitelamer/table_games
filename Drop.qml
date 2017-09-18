import QtQuick 2.0
import "backgammon_logic.js" as Game

Rectangle{
    id: drop_rect
    color:"transparent"
    property int p_ind: 12
    property int p_height: 12
    property int p_rotation: 0
    property string img: ""
    height:510
    DropArea {
        id:drop_area
        anchors.fill: parent
        enabled:isEnable()
        visible:enabled
        Image {
            id:area_img
            anchors.right: parent.right
            anchors.left: parent.left
            //anchors.top: parent.top
            anchors.top: p_rotation==0?undefined:parent.top
            anchors.bottom: p_rotation==0?parent.bottom:undefined
            height:p_height
            rotation: p_rotation
            opacity: drop_area.containsDrag?1.0:1.0 //DoNot remove this holy if
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
            console.log("onDropped:"+drop.source)
            dropping(drop.source);
//            gameLogic.make_turn(drop.source.p_ind,drop_rect.p_ind);
//            drop.source.drop_link=drop_rect;
//            drop.source.index=gameLogic.get_count(drop_rect.p_ind)-1;
            //main_form.drag_item=null;
            return Qt.MoveAction;
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: parent.enabled&&main_form.drag_need_resume
            onClicked: {
                dropping(main_form.drag_item);
                //console.log("onClicked:",main_form.drag_item,parent.parent)
                //gameLogic.make_turn(gameLogic.drag_row_index,drop_rect.p_ind);

                //main_form.drag_item.drop_link=drop_rect;
                //main_form.drag_item.index=gameLogic.get_count(drop_rect.p_ind)-1;

                //gameLogic.setFishkaShadow(true,main_form.drag_item.dddindex);
                main_form.drag_item=null;
            }
            onPositionChanged:{
                //console.log("Mose move in drop",mouse.x,mouse.y,drop_rect.mapToItem(main_form ,mouse.x,mouse.y));
                if(main_form.drag_item!=null&&main_form.drag_need_resume==true){
                    var point=drop_rect.mapToItem(main_form ,mouse.x,mouse.y)
                    main_form.drag_item.x=point.x-fiska_size*.5
                    main_form.drag_item.y=point.y-fiska_size*.5
                }
            }
        }
    }
    function dropping(source){
        if(source==null)return;
        Game.make_turn(source,p_ind);
        //source.drop_link=drop_rect;
        //
        //main_form.drag_item=null;
    }

    function isEnable(){
        if(main_form.drag_item==null)return false;
//        if(nowplayer==1){
//            if(gameLogic.drag_row_index>=12&&p_ind<12)return false;
//        }else{
//            if(gameLogic.drag_row_index<=12&&p_ind>12)return false;
//        }
        return Game.canDropFishka(main_form.drag_item,p_ind)
    }

    //    Component.onCompleted: {
    //        var tmp=drop_areas;
    //        tmp[p_ind]=this;
    //        drop_areas=tmp;
    //        console.log("{x:",this.x,",y:",this.y,",width:",this.width,",height:",this.height,",rotation:",this.rotation,"}")
    //        createFishkas(p_ind);
    //    }
}
