import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    id:main_form
    property int main_spacing: 17
    property int fiska_size: 61
    property QtObject gameLogic: gameLogic
    property int fishka_count: 0
    property var drag_item: null
    property variant drop_areas: [
        {x: 1119 ,y: 498 ,width: 71 ,p_height: 407 ,p_rotation: 0 ,p_ind: 0 ,img: "img/backgammon/33.png"},
        {x: 1041 ,y: 499 ,width: 71 ,p_height: 307 ,p_rotation: 0 ,p_ind: 1 ,img: "img/backgammon/22.png"},
        {x: 963  ,y: 500 ,width: 71 ,p_height: 209 ,p_rotation: 0 ,p_ind: 2 ,img: "img/backgammon/11.png"},
        {x: 886  ,y: 500 ,width: 71 ,p_height: 209 ,p_rotation: 0 ,p_ind: 3 ,img: "img/backgammon/11.png"},
        {x: 807  ,y: 499 ,width: 71 ,p_height: 307 ,p_rotation: 0 ,p_ind: 4 ,img: "img/backgammon/22.png"},
        {x: 731  ,y: 498 ,width: 71 ,p_height: 407 ,p_rotation: 0 ,p_ind: 5 ,img: "img/backgammon/33.png"},
        {x: 479  ,y: 498 ,width: 71 ,p_height: 407 ,p_rotation: 0 ,p_ind: 6 ,img: "img/backgammon/33.png"},
        {x: 401  ,y: 499 ,width: 71 ,p_height: 307 ,p_rotation: 0 ,p_ind: 7 ,img: "img/backgammon/22.png"},
        {x: 324  ,y: 500 ,width: 71 ,p_height: 209 ,p_rotation: 0 ,p_ind: 8 ,img: "img/backgammon/11.png"},
        {x: 246  ,y: 500 ,width: 71 ,p_height: 209 ,p_rotation: 0 ,p_ind: 9 ,img: "img/backgammon/11.png"},
        {x: 168  ,y: 499 ,width: 71 ,p_height: 307 ,p_rotation: 0 ,p_ind: 10 ,img: "img/backgammon/22.png"},
        {x: 91   ,y: 498 ,width: 71 ,p_height: 407 ,p_rotation: 0 ,p_ind: 11 ,img: "img/backgammon/33.png"},

        {x: 91   ,y: 17 ,width: 71 ,p_height: 407 ,p_rotation: 180 ,p_ind: 12 ,img: "img/backgammon/33.png"},
        {x: 168  ,y: 16 ,width: 71 ,p_height: 307 ,p_rotation: 180 ,p_ind: 13 ,img: "img/backgammon/22.png"},
        {x: 246  ,y: 15 ,width: 71 ,p_height: 209 ,p_rotation: 180 ,p_ind: 14 ,img: "img/backgammon/11.png"},
        {x: 324  ,y: 15 ,width: 71 ,p_height: 209 ,p_rotation: 180 ,p_ind: 15 ,img: "img/backgammon/11.png"},
        {x: 402  ,y: 16 ,width: 71 ,p_height: 307 ,p_rotation: 180 ,p_ind: 16 ,img: "img/backgammon/22.png"},
        {x: 479  ,y: 17 ,width: 71 ,p_height: 407 ,p_rotation: 180 ,p_ind: 17 ,img: "img/backgammon/33.png"},
        {x: 730  ,y: 17 ,width: 71 ,p_height: 407 ,p_rotation: 180 ,p_ind: 18 ,img: "img/backgammon/33.png"},
        {x: 808  ,y: 16 ,width: 71 ,p_height: 307 ,p_rotation: 180 ,p_ind: 19 ,img: "img/backgammon/22.png"},
        {x: 885  ,y: 15 ,width: 71 ,p_height: 209 ,p_rotation: 180 ,p_ind: 20 ,img: "img/backgammon/11.png"},
        {x: 963  ,y: 15 ,width: 71 ,p_height: 209 ,p_rotation: 180 ,p_ind: 21 ,img: "img/backgammon/11.png"},
        {x: 1041 ,y: 16 ,width: 71 ,p_height: 307 ,p_rotation: 180 ,p_ind: 22 ,img: "img/backgammon/22.png"},
        {x: 1119 ,y: 17 ,width: 71 ,p_height: 407 ,p_rotation: 180 ,p_ind: 23 ,img: "img/backgammon/33.png"}]
    property variant drag_fishkas: []
    property variant fishka_c: null
    property variant drop_c: null
    property alias gamestate: gameLogic.logic_state
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
        source:"img/backgammon/fone1280x1024.png"
        ParticleSystem{
            anchors.fill: parent
            ImageParticle{
                source: "./img/star.png"
            }
            Emitter{
                height: fiska_size
                width: fiska_size
                enabled: drag_item!=null
                x:drag_item!=null?drag_item.x:0
                y:drag_item!=null?drag_item.y:0
                emitRate:130
                //anchors.centerIn: drag_item
                size:30
                endSize:10
            }
        }
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

        Drop {
            id: drop_black_home
            x: 12
            y: 628
            width: 45
            height: 324
            p_height: 324
            p_ind: 25
            img:"./img/backgammon/44.png"
//            function dropping(source){
//                var turn_dst=0;
//                for(var i=6;i<12;i++){
//                    if(gameLogic.can_drop_fishka(gameLogic.drag_row_index,i))turn_dst=i;
//                }
//                gameLogic.make_turn(gameLogic.drag_row_index,turn_dst);
//                source.drop_link=drop_black_home;
//                source.index=gameLogic.get_count(p_ind)-1;
//                //main_form.drag_item=null;
//            }
//            function isEnable(){
//                if(nowplayer==1&&gameLogic.chk_at_home()){
//                    var can_drop=false;
//                    for(var k=12;k>=6;k--){
//                        //can_drop=can_drop||gameLogic.can_drop_fishka(gameLogic.drag_row_index,i);
//                        for(var i=0;i<4;i++){
//                            if(gameLogic.available_turns[i])
//                                for(var j=0;j<gameLogic.available_turns[i].length;j++){
//                                    if(gameLogic.available_turns[i][j].src==gameLogic.drag_row_index&&gameLogic.available_turns[i][j].dst==k)can_drop=true;
//                                }
//                        }
//                    }
//                    return can_drop;
//                }
//                return false;
//            }
        }
        Drop {
            id: drop_white_home
            x: 1218
            y: 64
            width: 45
            height: 324
            p_height: 324
            p_ind: 24
            img:"./img/backgammon/44.png"
//            function dropping(source){
//                var turn_dst=0;
//                for(var i=18;i<24;i++){
//                    if(gameLogic.can_drop_fishka(gameLogic.drag_row_index,i))turn_dst=i;
//                }
//                gameLogic.make_turn(gameLogic.drag_row_index,turn_dst);
//                source.drop_link=drop_white_home;
//                source.index=gameLogic.get_count(p_ind)-1;
//                //main_form.drag_item=null;
//            }
//            function isEnable(){
//                if(nowplayer==0&&gameLogic.chk_at_home()){
//                    var can_drop=false;
//                    for(var k=23;k>=18;k--){
////                        can_drop=can_drop||gameLogic.can_drop_fishka(gameLogic.drag_row_index,i);
//                        for(var i=0;i<4;i++){
//                            if(gameLogic.available_turns[i])
//                                for(var j=0;j<gameLogic.available_turns[i].length;j++){
//                                    if(gameLogic.available_turns[i][j].src==gameLogic.drag_row_index&&gameLogic.available_turns[i][j].dst==k)can_drop=true;
//                                }
//                        }
//                    }
//                    return can_drop;
//                }
//                return false;
//            }
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
                //main_form.gamestate=gameLogic.logic_state
                newgamestate(main_form.gamestate)
            }
            onLogicInited: {
                //createFishkas();
                if(drop_c===null)
                    drop_c = Qt.createComponent("Drop.qml");
                //Qt.quit();
                console.log("onLogicInited",drop_c)
                var tmp=[];//drop_areas;
                for(var i=0;i<drop_areas.length;i++){
                    var drop = drop_c.createObject(background, drop_areas[i]);
                    if (drop == null)
                        console.log("Error creating object");
                    else
                        tmp.push(drop);
                }
                tmp.push(drop_black_home);
                tmp.push(drop_white_home);
                drop_areas=tmp;
                createFishkas();
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
    Text {
        id: text1
        x: 1302
        y: 27
        width: 219
        height: 33
        text: "turn:"+gameLogic.game_turn
        font.pixelSize: 12
    }

    Text {
        id: text2
        x: 1302
        y: 72
        width: 219
        height: 33
        text: "now_player:"+gameLogic.now_player
        font.pixelSize: 12
    }

    Text {
        id: text3
        x: 1302
        y: 117
        width: 219
        height: 33
        text: "white_home:"+gameLogic.get_count(24)
        font.pixelSize: 12
    }

    Text {
        id: text4
        x: 1302
        y: 162
        width: 219
        height: 33
        text: "black_home:"+gameLogic.get_count(25)
        font.pixelSize: 12
    }

    Text {
        id: text5
        x: 1302
        y: 201
        width: 219
        height: 33
        text: "dice_rol:"+gameLogic.dice_rol
        font.pixelSize: 12
    }

    Text {
        id: text7
        x: 1302
        y: 256
        width: 219
        height: 768
        text: "movies_fild_array:\n"+print_game_movies()
        font.pixelSize: 12
        wrapMode: Text.WrapAnywhere
    }

//    AnimatedImage {
//        id: animation;
//        source: "123.gif"
//        width: fiska_size
//        height: fiska_size
//    }
    function print_game_movies(){
        var str=""
        for(var i=0;i<gameLogic.available_turns.length;i++){
           str+="move:"+i+" "+gameLogic.available_turns[i].coin.pos+"->"+gameLogic.available_turns[i].pos2+" \n";
        }
        return str;
    }
    Component.onCompleted: {
        fishka_c = Qt.createComponent("Fishka.qml");
        if (fishka_c.status != Component.Ready)fishka_c=null;
        drop_c = Qt.createComponent("Drop.qml");
        if (drop_c.status != Component.Ready)drop_c=null;
    }
    function getDropArea(index){
        for(var i=0;i<drop_areas.length;i++)
            if(drop_areas[i].p_ind==index)return drop_areas[i];
    }

    function createFishkas(){
        console.log("createFishkas");
        if(fishka_c==null)return;
        //var tmp=drag_fishkas;

        //for(var j=0;j<gameLogic.get_count(index);j++){
        for(var j=0;j<15;j++){
            var fishka = fishka_c.createObject(background, {
//                                                   "drop_link":lnk,
                                                   //"dddindex":main_form.fishka_count++,
                                                   //"index": j,
                                                   "player":1,
                                                   "pos":11,
                                                   "fiska_size": fiska_size});
            if (fishka == null)
                console.log("Error creating object");
            else
                gameLogic.add_fishka(fishka);

            fishka = fishka_c.createObject(background, {
//                                                   "drop_link":lnk,
                                                   //"dddindex":main_form.fishka_count++,
                                                   //"index": j,
                                                   "player":0,
                                                   "pos":23,
                                                   "fiska_size": fiska_size});
            if (fishka == null)
                console.log("Error creating object");
            else
                gameLogic.add_fishka(fishka);
        }
        console.log("createFishkas create:"+main_form.fishka_count);
        //drag_fishkas=tmp;
    }
}
