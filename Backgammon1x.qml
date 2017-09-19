import QtQuick 2.0
import QtQuick.Particles 2.0
import "backgammon_logic.js" as Game
import "gl_logic.js" as GLCode
Item {
    id:main_form
    property int main_spacing: 17
    property int fiska_size: 61
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
        {x: 1119 ,y: 17 ,width: 71 ,p_height: 407 ,p_rotation: 180 ,p_ind: 23 ,img: "img/backgammon/33.png"},
        {x: 10 ,y: 625 ,width: 51, height: 330 ,p_height: 330 ,p_rotation: 180 ,p_ind: 25 ,img: "img/backgammon/44.png"},
        {x: 1220 ,y: 70 ,width: 51, height: 330 ,p_height: 330 ,p_rotation: 0 ,p_ind: 24 ,img: "img/backgammon/44.png"}]

    property variant drag_fishkas: []
    property variant fishka_c: null
    property variant drop_c: null
    //    property alias gamestate: Game.logic_state
    //    property alias nowplayer: Game.now_player
    property bool drag_need_resume: false
    property int now_player:0;
    property variant game_coins:[];
    //var game_first_step=[true,true];
    property variant game_rol:[0,0];
    property variant ways:[
        [23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0,24],
        [11,10,9,8,7,6,5,4,3,2,1,0,23,22,21,20,19,18,17,16,15,14,13,12,25]
    ];
    property variant dice_rol:[];
    property int dice1_val:0;
    property int dice2_val:0;
    property int logic_state:0;
    //var white_home:0;
    //var black_home:0;
    //    property int drag_row_index: -1;
    property variant available_turns:[];
    property int game_turn:0;
    property int take_head:0;

    property double op_dice1: 1
    property double op_dice2: 1

    property double gl_axis_y:4.38
    property double gl_axis_x:3.5

    property double phy_axis_x:3.1
    property double phy_axis_y1:0.55
    property double phy_axis_y2:3.8

    signal updateAfterDrop(int src, int dst)
    signal newgamestate(int state)
    width: 1280
    height: 1024
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
            property var drop_start: null
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent
            //enabled: Game.get_state()!=3
            onPressed: {
                console.log("Game state:",logic_state,mouse.x,mouse.y,width/2,now_player);
                if(Game.get_state()!=3&&Game.get_state()!=1)return;
                if(gl_canvas.showdrop)return;
                drop_start=null;
                if(now_player){
                    if(mouse.x>width/2)return;
                }else{
                    if(mouse.x<=width/2)return;
                }
                if(now_player==0){
                    GLCode.barriers["top"].position.set(0,phy_axis_y2, 0);
                    GLCode.barriers["bottom"].position.set(0,phy_axis_y1, 0);
                }else{
                    GLCode.barriers["top"].position.set(0,-phy_axis_y1, 0);
                    GLCode.barriers["bottom"].position.set(0,-phy_axis_y2, 0);
                }

                //drop_start = {x:mouseX,y:mouseY};
                drop_start = translateToCanvas(mouse.x,mouse.y);
                if(drop_start.y<0&&drop_start.y>-phy_axis_y1)
                    drop_start.y=-phy_axis_y1;
                if(drop_start.y>0&&drop_start.y<phy_axis_y1)
                    drop_start.y=phy_axis_y1;
                op_dice1_anim.stop();
                op_dice2_anim.stop();
                op_dice1=1;
                op_dice2=1;
            }
            onReleased: {
                if(Game.get_state()!=3&&Game.get_state()!=1)return;
                if(gl_canvas.showdrop)return;
                if(!drop_start)return;
                var vector = { x: mouseX - drop_start.x, y: mouseY - drop_start.y };
                vector = translateToCanvas(mouse.x,mouse.y);
                var vector_start = drop_start;//{ x: drop_start.x/width, y: drop_start.y/height };
                drop_start = null;
                var dist = Math.sqrt(vector.x * vector.x + vector.y * vector.y);
                //vector.x /= dist; vector.y /= dist;
                console.log("Game state:",logic_state,mouse.x,mouse.y);
                console.log("vector",vector.x,vector.y);
                console.log("vector_start",vector_start.x,vector_start.y);
                dice_rol=[0,0];
                GLCode.dropDice(vector,vector_start,0,1);

                drop_finish_chk_timer.start();
            }
            onPositionChanged: {
                if(Game.get_state()!=3){
                    if(main_form.drag_item!=null&&main_form.drag_need_resume==true){
                        var point=main_form.mapToItem(main_form.drag_item.parent,mouse.x,mouse.y)
                        main_form.drag_item.x=point.x-fiska_size*.5
                        main_form.drag_item.y=point.y-fiska_size*.5
                    }
                }else{

                }

                //gameLogic.setFishkaPos(gameLogic.translateToCanvas(mouse.x,mouse.y),0);
            }
            //            onClicked: {
            //                if(Game.get_state()==5){
            //                    //console.log(main_form.childAt(main_form.drag_item.x+48,main_form.drag_item.y+48))
            //                }
            //            }


        }
        AnimatedImage{
            id:white_home_anim
            source: "./img/backgammon/01.gif"
            playing:false
            anchors.centerIn: getDropArea(24)
            onCurrentFrameChanged: {
                if(currentFrame==frameCount-1)paused=true;
            }
        }
        AnimatedImage{
            id:black_home_anim
            source: "./img/backgammon/01.gif"
            playing:false
            anchors.centerIn: getDropArea(25)
            rotation: 180
            onCurrentFrameChanged: {
                if(currentFrame==frameCount-1)paused=true;
            }
        }
        //        Drop {
        //            id: drop_black_home
        //            x: 10
        //            y: 625
        //            width: 51
        //            height: 330
        //            p_height: 330
        //            p_rotation: 180
        //            p_ind: 25
        //            img:"./img/backgammon/44.png"
        //        }
        //        Drop {
        //            id: drop_white_home
        //            x: 1220
        //            y: 70
        //            width: 51
        //            height: 330
        //            p_height: 330
        //            p_ind: 24
        //            img:"./img/backgammon/44.png"
        //        }

        //        ImageCube {
        //            id: gameLogic
        //            //width: 1090
        //            width: 1280
        //            height: 1024
        //            //height: 970
        //            z:1
        //            orientation: true
        //            anchors.centerIn: parent
        //            //anchors.horizontalCenterOffset: gameLogic.now_player==1?-320:320
        //            //        anchors.horizontalCenterOffset: 320

        //            visible: true
        //            /*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //            onLogic_stateChanged: {
        //                console.log("onLogic_stateChanged");
        //                //main_form.gamestate=gameLogic.logic_state
        //                newgamestate(main_form.gamestate)
        //                if(Game.chkIsAtHome()){
        //                    console.log("Anim:",white_home_anim.paused,white_home_anim.playing,white_home_anim.currentFrame,white_home_anim.frameCount);
        //                   if(!white_home_anim.paused&&gameLogic.now_player==0)
        //                        white_home_anim.playing=true;
        //                   if(!black_home_anim.paused&&gameLogic.now_player==1)
        //                        black_home_anim.playing=true;
        //                }
        //            }
        //            /*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
        //        }


    }

    Text{
        id:label_drop
        text: "PRESS FOR DROP DICE"
        font.bold:true
        font.pointSize:24
        visible: logic_state==3&&!gl_canvas.showdrop
        opacity: 0
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: (1-now_player*2)*parent.width/4
        SequentialAnimation{

            loops: Animation.Infinite
            running: label_drop.visible
            NumberAnimation {
                target: label_drop
                property: "opacity"
                duration: 1500
                to:1
                easing.type: Easing.Linear
                alwaysRunToEnd:true
            }
            NumberAnimation {
                target: label_drop
                property: "opacity"
                duration: 1500
                to:0
                easing.type: Easing.Linear
                alwaysRunToEnd:true
            }
        }
    }

    Text {
        id: text1
        x: 1302
        y: 27
        width: 219
        height: 33
        text: "turn:"+game_turn
        font.pixelSize: 12
        color: "white"
    }

    Text {
        id: text2
        x: 1302
        y: 72
        width: 219
        height: 33
        text: "now_player:"+now_player
        font.pixelSize: 12
        color: "white"
    }

    Text {
        id: text3
        x: 1302
        y: 117
        width: 219
        height: 33
        text: "white_home:"+Game.get_count(24)
        font.pixelSize: 12
        color: "white"
    }

    Text {
        id: text4
        x: 1302
        y: 162
        width: 219
        height: 33
        text: "black_home:"+Game.get_count(25)
        font.pixelSize: 12
        color: "white"
    }

    Text {
        id: text5
        x: 1302
        y: 201
        width: 219
        height: 33
        text: "dice_rol:"+dice_rol
        font.pixelSize: 12
        color: "white"
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
        color: "white"
    }

    //    AnimatedImage {
    //        id: animation;
    //        source: "123.gif"
    //        width: fiska_size
    //        height: fiska_size
    //    }
    function print_game_movies(){
        var str=""
        for(var i=0;i<available_turns.length;i++){
            str+="move:"+i+" "+available_turns[i].pos1+"->"+available_turns[i].pos2+" \n";
        }
        return str;
    }
    WorkerScript{
        id:calc_worck
        source: "calc_script.js"
        onMessage: {
            available_turns=messageObject.tree
            dice1_val=dice_rol[0];
            dice2_val=dice_rol[1];
            if(dice_rol[0]==dice_rol[1])dice_rol[2]=dice_rol[3]=dice_rol[0];
            logic_state=5;
        }
    }
    Timer{
        id:drop_finish_chk_timer
        running: false
        repeat: true
        interval: 1500
        onTriggered: {
            gl_canvas.showdrop=running=!GLCode.is_throw_finished();
            if(gl_canvas.showdrop)
                interval/=2.0
            else{
                interval=1500;
                dice_rol=GLCode.get_dice();
                var board = [];  for(var coin=0;coin<game_coins.length;coin++) board.push({player:game_coins[coin].player,pos:game_coins[coin].pos,coin:game_coins[coin].ind});
                calc_worck.sendMessage({'roll':dice_rol,'game_turn':game_turn,'board':board,'player':now_player});
                //Game.set_dice(GLCode.get_dice());
            }
            if(interval<100)interval=150;
            console.log("drop_finish_chk_timer",running,interval);
        }
    }
    Component.onCompleted: {
        fishka_c = Qt.createComponent("Fishka.qml");
        if (fishka_c.status != Component.Ready)fishka_c=null;
        drop_c = Qt.createComponent("Drop.qml");
        if (drop_c.status != Component.Ready)drop_c=null;


        Game.init(main_form);
        var tmp=[];//drop_areas;
        for(var i=0;i<drop_areas.length;i++){
            var drop = drop_c.createObject(background, drop_areas[i]);
            if (drop == null)
                console.log("Error creating object");
            else
                tmp.push(drop);
        }
        //        tmp.push(drop_black_home);
        //        tmp.push(drop_white_home);
        drop_areas=tmp;
        createFishkas();
        GLCode.setOrientation(true);
        GLCode.initPhysics(); // need physics for dices
        GLCode.barriers["right"].position.set(phy_axis_x,0, 0);
        GLCode.barriers["left"].position.set(-phy_axis_x,0, 0);
    }
    onLogic_stateChanged: {
        //console.log("onLogic_stateChanged");
        //main_form.gamestate=gameLogic.logic_state
        newgamestate(main_form.gamestate)
        if(Game.chkIsAtHome()){
            if(!white_home_anim.paused&&now_player==0)
                white_home_anim.playing=true;
            if(!black_home_anim.paused&&now_player==1)
                black_home_anim.playing=true;
        }
    }
    function getDropArea(index){
        for(var i=0;i<drop_areas.length;i++)
            if(drop_areas[i].p_ind==index)return drop_areas[i];
    }

    function createFishkas(){
        if(fishka_c==null)return;
        var fishka=null;
        console.time('create fishka');
        for(var j=0;j<15;j++){
            fishka = fishka_c.createObject(background, {
                                               "player":1,
                                               "pos":14,
                                               "fiska_size": fiska_size,
                                               "dddobj": GLCode.get3dObj(1)
                                           });
            if (fishka == null)
                console.log("Error creating object");
            else
                Game.add_fishka(fishka);

            fishka = fishka_c.createObject(background, {
                                               "player":0,
                                               "pos":3,
                                               "fiska_size": fiska_size,
                                               "dddobj": GLCode.get3dObj(0)
                                           });
            if (fishka == null)
                console.log("Error creating object");
            else
                Game.add_fishka(fishka);
        }
        console.timeEnd('create fishka');
        //        fishka = fishka_c.createObject(background, {
        //                                               "player":1,
        //                                               "pos":18,
        //                                               "fiska_size": fiska_size});
        //            gameLogic.add_fishka(fishka);
        //        fishka = fishka_c.createObject(background, {
        //                                               "player":0,
        //                                               "pos":6,
        //                                               "fiska_size": fiska_size});
        //            gameLogic.add_fishka(fishka);

    }
    function translateToCanvas(x,y){
        var newY=(x/background.width)*gl_axis_y*2-gl_axis_y
        var newX=(y/background.height)*gl_axis_x*2-gl_axis_x
        //console.log("translateToCanvas",x,y,newX,newY)
        var vector = { x: newX, y: newY };
        return vector;
    }
    function get3dObj(player){
        return GLCode.get3dObj(player);
    }

    WinForm{
        id:left_win_form
        rotation: 180
        anchors.centerIn: background
        anchors.horizontalCenterOffset: -background.width/4
        visible: false
        opacity: 0
        Behavior on opacity {
            NumberAnimation {
                duration: 550
                easing.type: Easing.Linear
            }
        }
    }
    WinForm{
        id:right_win_form
        anchors.centerIn: background
        anchors.horizontalCenterOffset: background.width/4
        visible: false
        opacity: 0
        Behavior on opacity {
            NumberAnimation {
                duration: 550
                easing.type: Easing.Linear
            }
        }
    }
    function disable_dice(n){
        if(n==0)
            op_dice1_anim.start();
        else
            op_dice2_anim.start();
    }
    function hide_dice(){
        for(var i=0;i<arguments.length;i++){
            if(arguments[i]==0)
                GLCode.hide_dice1();
            if(arguments[i]==1)
                GLCode.hide_dice2();
        }
    }
    onOp_dice1Changed: {GLCode.opacity_dice1(op_dice1)}
    onOp_dice2Changed: {GLCode.opacity_dice2(op_dice2)}
    NumberAnimation {
        id:op_dice1_anim
        target: main_form
        property: "op_dice1"
        duration: 500
        from:1
        to:0.5
        easing.type: Easing.Linear
        onStopped: {
            //GLCode.hide_dice1();
        }
    }
    NumberAnimation {
        id:op_dice2_anim
        target: main_form
        property: "op_dice2"
        duration: 500
        from:1
        to:0.5
        easing.type: Easing.Linear
        onStopped: {
            //GLCode.hide_dice2();
        }
    }
    function showWhiteWin(){
        left_win_form.setWiner(0,null);
        right_win_form.setWiner(0,null);
        left_win_form.opacity=1
        right_win_form.opacity=1
        left_win_form.visible=true
        right_win_form.visible=true
    }
    function showBlackWin(){
        left_win_form.setWiner(1,null);
        right_win_form.setWiner(1,null);
        left_win_form.opacity=1
        right_win_form.opacity=1
        left_win_form.visible=true
        right_win_form.visible=true
    }
}
