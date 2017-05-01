import QtQuick 2.0
import "./GameLogic.js" as Game_Logic

Row{
    property int p_ind: 6+index
    layoutDirection: Qt.RightToLeft
    height: 97
    width: 1438
    spacing: 2
    z:1
    Text{
        rotation: -90
        width: 50
        height: 97
        font.bold:true
        font.pointSize:24
        text:p_ind+1
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color:"white"
    }
    Repeater{
        model:Game_Logic.get_count(p_ind);//game_fild_array[p_ind].count
        id:row_repeater
        delegate:Image {
            property int pindex: p_ind
            id:delegateRoot
            width: 97
            height: 97
            //anchors.verticalCenter: parent.verticalCenter
            source: Game_Logic.get_color(p_ind)==0?"./img/1w.png":"./img/1b.png"
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
                enabled: Game_Logic.get_count(p_ind)-1==index//&&Game_Logic.can_drag_fishka(p_ind)
                onPressed: {
                    //console.log(parent.Drag.hotSpot.x+"x"+parent.Drag.hotSpot.y)
//                    drag_image.x=parent.x
//                    drag_image.y=parent.y
                    global_area.hoverEnabled=false
                    main_form.drag_row_index=p_ind;
                    main_form.drag_item=drag.target;
                    main_form.drag_need_resume=false;
                }
                onReleased: {
                    if(parent.Drag.target==null){
                        //drag.active=true;
                        global_area.hoverEnabled=true
                        main_form.drag_need_resume=true
                        console.log("drop reseted")
                        return;
                    }
                    global_area.hoverEnabled=false
                    main_form.drag_item=null;
                    main_form.drag_need_resume=false
                    main_form.drag_row_index=-1;
                    console.log("parent.Drag.target:"+ parent.Drag.target)
                    var ret = parent.Drag.drop()
                    console.log("drop result:" + ret)
                    //row_repeater.updateModel();

                }
                Connections{
                    target: main_form
                    onGamestateChanged:{ enabled=Game_Logic.get_count(p_ind)-1==index&&Game_Logic.can_drag_fishka(p_ind);}
                }
            }
            states: [State {
                    when: dragArea.drag.active
                    //ParentChange { target: delegateRoot; parent: main_form }
                    AnchorChanges { target: delegateRoot; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
                }]
            layer.enabled: true
            layer.effect: ShaderEffect {
                      fragmentShader: "
                          uniform lowp sampler2D source; // this item
                          uniform lowp float qt_Opacity; // inherited opacity of this item
                          varying highp vec2 qt_TexCoord0;
                          void main() {
                              lowp vec4 p = texture2D(source, qt_TexCoord0);
                              lowp float g = dot(p.xyz, vec3(0.344, 0.5, 0.156));
                              gl_FragColor = vec4(g, g, g, p.a) * qt_Opacity;
                          }"
                  }
        }
        function updateModel(src, dst){
            if(src==p_ind||dst==p_ind){
                model=Game_Logic.get_count(p_ind);
            }
        }
        Component.onCompleted: {
            main_form.updateAfterDrop.connect(updateModel)
        }
    }
}
