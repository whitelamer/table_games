import QtQuick 2.0
import "backgammon_logic.js" as Game

Item {
    //property int p_ind: drop_link.p_ind
    property int index: 0
    property int ind: 0
    property int dddindex: 0
    property var dddobj: null
    property int fiska_size: 106
    property var drop_link: null//getDropArea(pos)
    property string image_white: "1w.png"
    property string image_black: "1b.png"
    property int player:2
    property int pos:0
    property double dddk: 0.5

    id:delegateRoot
    width: fiska_size
    height: fiska_size


    anchors.horizontalCenter: drop_link.horizontalCenter
    anchors.top: drop_link.p_rotation!==0?drop_link.top:undefined
    anchors.bottom: drop_link.p_rotation===0?drop_link.bottom:undefined
    anchors.topMargin: drop_link.p_rotation!==0?delegateRoot.height*index+5:0
    anchors.bottomMargin: drop_link.p_rotation===0?delegateRoot.height*index+5:0
//    Rectangle{
//        anchors.fill: parent
//    }

    Image{
        id:image_select
//        visible: main_form.drag_item==parent
//        height: 90
//        width: 90
        visible: dddobj!=null
        anchors.centerIn: parent
        source: main_form.drag_item!=parent?"./img/backgammon/shadow_+.png":"./img/backgammon/select_me.png"

        NumberAnimation {
            target: image_select
            property: "rotation"
            duration: 3000
            from: 0
            to:360
            easing.type: Easing.Linear
            loops: Animation.Infinite
            running: main_form.drag_item==image_select.parent
        }
    }
    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: 35
    Drag.hotSpot.y: 35
    Drag.dragType: Drag.Internal
    //Drag.dragType: Drag.Automatic
    Drag.supportedActions: Qt.CopyAction
    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        drag.smoothed:true
        enabled: isEnable()&&(main_form.drag_item==null||dragArea.drag.active)
        onPressed: {
            global_area.hoverEnabled=false
//            gameLogic.drag_row_index=pos;
            main_form.drag_item=drag.target;
            main_form.drag_need_resume=false;
            //dragArea.enabled=false;
            //console.log("eiqwoiepoqwieopqwiepoqweipoqw");
            //gameLogic.setFishkaShadow(false,dddindex);
        }
        onReleased: {
            if(parent.Drag.target==null){
                //console.log("draging:"+main_form.drag_item)
                var obj=main_form;
                while(obj!=null){
                    obj=obj.childAt(main_form.drag_item.x+(delegateRoot.width/2),main_form.drag_item.y+(delegateRoot.height/2));
                    //console.log("child:"+obj)
                }
                global_area.hoverEnabled=true
                main_form.drag_need_resume=true
                //console.log("drop reseted")
                return;
            }
            global_area.hoverEnabled=false
            main_form.drag_item=null;
            main_form.drag_need_resume=false
            //dragArea.enabled=true;
            //gameLogic.setFishkaShadow(true,dddindex);
            //console.log("parent.Drag.target:"+ parent.Drag.target)
            var ret = parent.Drag.drop()
            //console.log("drop result:" + ret)
            //row_repeater.updateModel();

        }
        onEnabledChanged: {
//            if(!dddobj)dddobj=gameLogic.get3dObj(dddindex);
//            if(!dddobj)return;
//            //var dddobj=gameLogic.get3dObj(dddindex);
//            console.log("Fishka onEnabledChanged",dragArea.enabled,dddindex ,dddobj);
//            if(dragArea.enabled){
//                dddobj.material.materials[0].color.setHex(0xffffff);
//            }else{
//                dddobj.material.materials[0].color.setHex(0x000000);
//            }
        }
    }
    states: [State {
            when: dragArea.drag.active||main_form.drag_item==delegateRoot
            AnchorChanges {
                target: delegateRoot;
                anchors.verticalCenter: undefined;
                anchors.horizontalCenter: undefined;
                anchors.top:undefined;
                anchors.bottom: undefined;
            }
        }]
    Component.onCompleted: {
        //console.log("Component.onCompleted",pos,index,dddindex,anchors.topMargin,anchors.bottomMargin,x,y);
        //this.objectName=p_ind+"x"+index
        if(dddobj==null)
            dddobj=get3dObj(player);//dddindex);
        update3dObj();
        //drop_link=getDropArea(pos);

        main_form.newgamestate.connect(delegateRoot.updateDrag)

        //console.log("Component.onCompleted",drop_link.x,drop_link.y,drop_link.width,drop_link.height);
        //dddindex=main_form.fishka_count++
        //main_form.fishka_count++
    }
    function update3dObj(){
        if(dddobj==null)return;
        var vec=translateToCanvas(x+delegateRoot.width*dddk,y+delegateRoot.height*dddk)
        //var vec=gameLogic.translateToCanvas(x+fiska_size*0.5,y+fiska_size*0.5)
        dddobj.position.set(vec.x,vec.y,0);
    }

    function updateDrag(state) {
        //dragArea.enabled=gameLogic.canDragFishka(delegateRoot);
        //console.log("updateDrag",dragArea.enabled);
    }
    function isEnable(){
        return Game.canDragFishka(delegateRoot);
    }

//    onIndexChanged: {
//        //console.log("onIndexChanged",p_ind,index,gameLogic.get_count(p_ind));
//        delegateRoot.updateDrag(gameLogic.logic_state)
//    }
//    onDrop_linkChanged: {
//        //console.log("onDrop_linkChanged",p_ind,drop_link.p_ind,gameLogic.get_count(p_ind));
//        pos=drop_link.p_ind;
//        //dragArea.enabled=gameLogic.get_count(p_ind)-1==index&&gameLogic.can_drag_fishka(p_ind);
//        //delegate_image.source=gameLogic.get_color(p_ind)==0?"./img/"+image_white:"./img/"+image_black
//        delegateRoot.updateDrag(gameLogic.logic_state)
//    }
    onPosChanged: {
        //console.log("Fishka onPosChanged",pos);
        drop_link=getDropArea(pos);
        if(pos==24||pos==25){
            delegateRoot.height=fiska_size/4;
            delegateRoot.width=delegateRoot.width-10;
            dddobj.rotation.set(0,0,Math.PI*(0.5-player));
            dddk=0.55-0.1*player
            image_select.source="";
        }

        //index=gameLogic.get_count(pos)-1;
    }

    onXChanged: {
        if(!dddobj)dddobj=get3dObj(player);//dddindex);
        update3dObj();
        //gameLogic.setFishkaPos(gameLogic.translateToCanvas(x+fiska_size*0.5,y+fiska_size*0.5),dddindex);
    }
    onYChanged: {
        if(!dddobj)dddobj=get3dObj(player);//dddindex);
        update3dObj();
        //gameLogic.setFishkaPos(gameLogic.translateToCanvas(x+fiska_size*0.5,y+fiska_size*0.5),dddindex);
    }
}
