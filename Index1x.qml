import QtQuick 2.0

Item {
    id:main_form
    property int main_spacing: 17
    property int fiska_size: 61
    property QtObject gameLogic: gameLogic
    property int fishka_count: 0
    property var drag_item: null
    property variant drop_areas: [
        {x: 1119 ,y: 601 ,width: 71 ,height: 407 ,rotation: 0 ,p_ind: 0 ,img: "img/33.png"},
        {x: 1041 ,y: 702 ,width: 71 ,height: 307 ,rotation: 0 ,p_ind: 1 ,img: "img/22.png"},
        {x: 964  ,y: 801 ,width: 71 ,height: 209 ,rotation: 0 ,p_ind: 2 ,img: "img/11.png"},
        {x: 886  ,y: 802 ,width: 71 ,height: 209 ,rotation: 0 ,p_ind: 3 ,img: "img/11.png"},
        {x: 808  ,y: 702 ,width: 71 ,height: 307 ,rotation: 0 ,p_ind: 4 ,img: "img/22.png"},
        {x: 731  ,y: 602 ,width: 71 ,height: 407 ,rotation: 0 ,p_ind: 5 ,img: "img/33.png"},
        {x: 479  ,y: 601 ,width: 71 ,height: 407 ,rotation: 0 ,p_ind: 6 ,img: "img/33.png"},
        {x: 401  ,y: 702 ,width: 71 ,height: 307 ,rotation: 0 ,p_ind: 7 ,img: "img/22.png"},
        {x: 324  ,y: 801 ,width: 71 ,height: 209 ,rotation: 0 ,p_ind: 8 ,img: "img/11.png"},
        {x: 246  ,y: 801 ,width: 71 ,height: 209 ,rotation: 0 ,p_ind: 9 ,img: "img/11.png"},
        {x: 168  ,y: 702 ,width: 71 ,height: 307 ,rotation: 0 ,p_ind: 10 ,img: "img/22.png"},
        {x: 91   ,y: 601 ,width: 71 ,height: 407 ,rotation: 0 ,p_ind: 11 ,img: "img/33.png"},

        {x: 91   ,y: 17 ,width: 71 ,height: 407 ,rotation: 180 ,p_ind: 12 ,img: "img/33.png"},
        {x: 168  ,y: 16 ,width: 71 ,height: 307 ,rotation: 180 ,p_ind: 13 ,img: "img/22.png"},
        {x: 246  ,y: 15 ,width: 71 ,height: 209 ,rotation: 180 ,p_ind: 14 ,img: "img/11.png"},
        {x: 324  ,y: 15 ,width: 71 ,height: 209 ,rotation: 180 ,p_ind: 15 ,img: "img/11.png"},
        {x: 402  ,y: 16 ,width: 71 ,height: 307 ,rotation: 180 ,p_ind: 16 ,img: "img/22.png"},
        {x: 479  ,y: 17 ,width: 71 ,height: 407 ,rotation: 180 ,p_ind: 17 ,img: "img/33.png"},
        {x: 730  ,y: 17 ,width: 71 ,height: 407 ,rotation: 180 ,p_ind: 18 ,img: "img/33.png"},
        {x: 808  ,y: 16 ,width: 71 ,height: 307 ,rotation: 180 ,p_ind: 19 ,img: "img/22.png"},
        {x: 885  ,y: 15 ,width: 71 ,height: 209 ,rotation: 180 ,p_ind: 20 ,img: "img/11.png"},
        {x: 964  ,y: 15 ,width: 71 ,height: 209 ,rotation: 180 ,p_ind: 21 ,img: "img/11.png"},
        {x: 1041 ,y: 16 ,width: 71 ,height: 307 ,rotation: 180 ,p_ind: 22 ,img: "img/22.png"},
        {x: 1119 ,y: 17 ,width: 71 ,height: 407 ,rotation: 180 ,p_ind: 23 ,img: "img/33.png"}]
    property variant drag_fishkas: []
    property variant fishka_c: null
    property variant drop_c: null
    property int gamestate: gameLogic.logic_state
    property alias nowplayer: gameLogic.now_player
    property bool drag_need_resume: false
    signal updateAfterDrop(int src, int dst)
    signal newgamestate(int state)
    width: 1920
    height: 1080
    Image {
        id: background
        width: 1280
        height: 1024
        fillMode: Image.PreserveAspectFit
        source:"./img/fone1280x1024.png"

        MouseArea{
            id:global_area
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent
            enabled: gameLogic.get_state()!=3
            onPositionChanged: {
                if(main_form.drag_item!=null&&main_form.drag_need_resume==true){
                    var point=main_form.mapToItem(main_form.drag_item.parent,mouse.x,mouse.y)
                    main_form.drag_item.x=point.x-fiska_size*.5
                    main_form.drag_item.y=point.y-fiska_size*.5
                }
                //gameLogic.setFishkaPos(gameLogic.translateToCanvas(mouse.x,mouse.y),0);
            }
            onClicked: {
                if(gameLogic.get_state()==5){
                    //console.log(main_form.childAt(main_form.drag_item.x+48,main_form.drag_item.y+48))
                }
            }
        }

        ImageCube {
            id: gameLogic
            //width: 1090
            width: 1280
            height: 1024
            //height: 970
            z:1
            orientation: true
            anchors.centerIn: parent
            //anchors.horizontalCenterOffset: gameLogic.now_player==1?-320:320
            //        anchors.horizontalCenterOffset: 320

            visible: true
            onLogic_stateChanged: {
                console.log("onLogic_stateChanged");
                main_form.gamestate=gameLogic.logic_state
                newgamestate(main_form.gamestate)
            }
            onLogicInited: {
                //createFishkas();
                if(drop_c==null)Qt.quit();

                var tmp=drop_areas;
                for(var i=0;i<drop_areas.length;i++){
                    var drop = drop_c.createObject(background, drop_areas[i]);
                    if (drop == null)
                        console.log("Error creating object");
                    else
                        tmp.drop_obj=drop;
                    createFishkas(i,drop);
                }
                drop_areas=tmp;
            }
            gl_axis_y:4.38
            gl_axis_x:3.5
            phy_axis_x:3.1
            phy_axis_y1:0.55
            phy_axis_y2:3.8
            function translateToCanvas(x,y){
                var newY=(x/background.width)*gl_axis_y*2-gl_axis_y
                var newX=(y/background.height)*gl_axis_x*2-gl_axis_x
                //console.log("translateToCanvas",x,y,newX,newY)
                var vector = { x: newX, y: newY };
                return vector;
            }
        }

    }
    Component.onCompleted: {
        fishka_c = Qt.createComponent("Fishka.qml");
        if (fishka_c.status != Component.Ready)fishka_c=null;
        drop_c = Qt.createComponent("Drop.qml");
        if (drop_c.status != Component.Ready)drop_c=null;
    }
    function createFishkas(index,lnk){
        if(fishka_c==null)return;
        var tmp=drag_fishkas;
        for(var j=0;j<gameLogic.get_count(index);j++){
            var fishka = fishka_c.createObject(background, {
                                                   "drop_link":lnk,
                                                   "dddindex":main_form.fishka_count++,
                                                   "index": j,
                                                   "fiska_size": fiska_size,
                                                   "image_white": "1w_+++.png",
                                                   "image_black": "1b_+++.png"});
            if (fishka == null)
                console.log("Error creating object");
            else
                tmp.push(fishka);
        }
        drag_fishkas=tmp;
    }
}
