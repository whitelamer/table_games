import QtQuick 2.0


Item {
    property int p_ind: drop_link.p_ind
    property int index: 0
    property int dddindex: 0
    property var dddobj: null
    property int fiska_size: 106
    property var drop_link: null
    property string image_white: "1w.png"
    property string image_black: "1b.png"

    id:delegateRoot
    width: fiska_size
    height: fiska_size


    anchors.horizontalCenter: drop_link.horizontalCenter
    anchors.top: drop_link.rotation!=0?drop_link.top:undefined
    anchors.bottom: drop_link.rotation==0?drop_link.bottom:undefined
    //rotation: drop_link.rotation
    anchors.topMargin: drop_link.rotation!=0?fiska_size*index+5:0
    anchors.bottomMargin: drop_link.rotation==0?fiska_size*index+5:0
    //anchors.verticalCenter: parent.verticalCenter
    Image{
        id:image_select
//        visible: main_form.drag_item==parent
//        height: 90
//        width: 90
        anchors.centerIn: parent
        source: main_form.drag_item!=parent?"./img/shadow_+.png":"./img/select_me.png"

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
        enabled: false
        onPressed: {
            global_area.hoverEnabled=false
            gameLogic.drag_row_index=p_ind;
            main_form.drag_item=drag.target;
            main_form.drag_need_resume=false;
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
        //console.log("Component.onCompleted",p_ind,index,dddindex);
        this.objectName=p_ind+"x"+index
        dddobj=gameLogic.get3dObj(dddindex);
        main_form.newgamestate.connect(delegateRoot.updateDrag)
        //dddindex=main_form.fishka_count++
        //main_form.fishka_count++
    }

    function updateDrag(state) {
//        try {
//            if(!(index)||null)return;
//        } catch (e) {
//            console.log(e)
//            return
//        }
        //if(!(index)||null)return;
        //console.log("onGamestateChanged",p_ind,index,gameLogic.get_count(p_ind));
        dragArea.enabled=gameLogic.get_count(p_ind)-1==index&&gameLogic.can_drag_fishka(p_ind);

        //delegate_image.source=gameLogic.get_color(p_ind)==0?"./img/"+image_white:"./img/"+image_black
        //console.log("onGamestateChanged",state,index,gameLogic.get_count(p_ind),enabled);
    }
    onIndexChanged: {
        //console.log("onIndexChanged",p_ind,index,gameLogic.get_count(p_ind));
        //dragArea.enabled=gameLogic.get_count(p_ind)-1==index&&gameLogic.can_drag_fishka(p_ind);
        //delegate_image.source=gameLogic.get_color(p_ind)==0?"./img/"+image_white:"./img/"+image_black
        delegateRoot.updateDrag(gameLogic.logic_state)
    }
    onDrop_linkChanged: {
        //dragArea.enabled=gameLogic.get_count(p_ind)-1==index&&gameLogic.can_drag_fishka(p_ind);
        //delegate_image.source=gameLogic.get_color(p_ind)==0?"./img/"+image_white:"./img/"+image_black
        delegateRoot.updateDrag(gameLogic.logic_state)
    }
    onXChanged: {
        if(!dddobj)dddobj=gameLogic.get3dObj(dddindex);
        var vec=gameLogic.translateToCanvas(x+fiska_size*0.5,y+fiska_size*0.5)
        dddobj.position.set(vec.x,vec.y,0);
        //gameLogic.setFishkaPos(gameLogic.translateToCanvas(x+fiska_size*0.5,y+fiska_size*0.5),dddindex);
    }
    onYChanged: {
        if(!dddobj)dddobj=gameLogic.get3dObj(dddindex);
        var vec=gameLogic.translateToCanvas(x+fiska_size*0.5,y+fiska_size*0.5)
        dddobj.position.set(vec.x,vec.y,0);
        //gameLogic.setFishkaPos(gameLogic.translateToCanvas(x+fiska_size*0.5,y+fiska_size*0.5),dddindex);
    }
}
