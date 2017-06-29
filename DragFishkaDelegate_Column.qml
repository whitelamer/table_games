import QtQuick 2.0
import QtGraphicalEffects 1.0

Column{
    id:drag_fishka
    property int p_ind: 6+index
    property string image_white: "1w.png"
    property string image_black: "1b.png"
    //property int gamestate: 0
    //property int fiska_size: 106
    //layoutDirection: Qt.RightToLeft
//    height: 106
//    width: 1438
    //spacing: 2
    z:1
    Text{
        //rotation: -90
        rotation: parent.rotation
        width: fiska_size
        height: 20
        font.bold:true
        font.pointSize:12
        text:p_ind+1
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color:"white"
    }
    Repeater{
        model:gameLogic.get_count(p_ind);//game_fild_array[p_ind].count
        id:row_repeater
        delegate:Item {
            property int pindex: p_ind
            id:delegateRoot
            width: fiska_size
            height: fiska_size
            //anchors.verticalCenter: parent.verticalCenter
            Image{
                id:delegate_image
                anchors.fill: parent
                source: gameLogic.get_color(p_ind)==0?"./img/"+image_white:"./img/"+image_black
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
                enabled: false//gameLogic.get_count(p_ind)-1==index//&&gameLogic.can_drag_fishka(p_ind)
                onPressed: {
                    //console.log(parent.Drag.hotSpot.x+"x"+parent.Drag.hotSpot.y)
                    //                    drag_image.x=parent.x
                    //                    drag_image.y=parent.y
                    //enabled=gameLogic.get_count(p_ind)-1==index&&gameLogic.can_drag_fishka(p_ind);

                    global_area.hoverEnabled=false
                    gameLogic.drag_row_index=p_ind;
                    main_form.drag_item=drag.target;
                    main_form.drag_need_resume=false;
                }
                onReleased: {
                    if(parent.Drag.target==null){
                        //drag.active=true;
                        console.log("draging:"+main_form.drag_item)
                        var obj=main_form;
                        while(obj!=null){
                            obj=obj.childAt(main_form.drag_item.x+(delegateRoot.width/2),main_form.drag_item.y+(delegateRoot.height/2));
                            console.log("child:"+obj)
                        }
                        global_area.hoverEnabled=true
                        main_form.drag_need_resume=true
                        console.log("drop reseted")
                        return;
                    }
                    global_area.hoverEnabled=false
                    main_form.drag_item=null;
                    main_form.drag_need_resume=false
                    console.log("parent.Drag.target:"+ parent.Drag.target)
                    var ret = parent.Drag.drop()
                    console.log("drop result:" + ret)
                    //row_repeater.updateModel();

                }
                Component.onCompleted: {
                    console.log("Component.onCompleted",p_ind,index,gameLogic.get_count(p_ind));
                    this.objectName=p_ind+"x"+index
                }
            }
            states: [State {
                    when: dragArea.drag.active
                    //ParentChange { target: delegateRoot; parent: main_form }
                    AnchorChanges { target: delegateRoot; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
                }]
            function updateDrag(state) {
                try {
                     if(!(index)||null)return;
                } catch (e) {
                    return
                }
                //if(!(index)||null)return;
                console.log("onGamestateChanged",p_ind,index,gameLogic.get_count(p_ind),row_repeater.model);
                dragArea.enabled=gameLogic.get_count(p_ind)-1==index&&gameLogic.can_drag_fishka(p_ind);
                //console.log("onGamestateChanged",state,index,gameLogic.get_count(p_ind),enabled);
            }
        }
        function updateModel(src, dst){
            //            if(src==p_ind||dst==p_ind){
            //                model=gameLogic.get_count(p_ind);
            //            }
        }
        Component.onCompleted: {
            main_form.newgamestate.connect(this.updateGameState)
            //main_form.updateAfterDrop.connect(updateModel)
        }
        onModelChanged: {
            console.log("onModelChanged",p_ind);
        }
        onItemAdded: {
            console.log("onItemAdded",index,item);
            main_form.newgamestate.connect(item.updateDrag)
        }

        onItemRemoved: {
            console.log("onItemRemoved",index,item);
            main_form.newgamestate.disconnect(item.updateDrag)
        }

        function updateGameState(state) {
            console.log("updateGameState",p_ind,"to state",state,"count",gameLogic.get_count(p_ind),"model",row_repeater.model);

        }
    }
}
