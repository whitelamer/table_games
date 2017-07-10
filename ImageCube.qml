import QtQuick 2.0
import QtCanvas3D 1.0
import BulletSim 1.0
import "imagecube.js" as GLCode
//import "cannon.js" as Cannon
Canvas3D {
    id: cube
    property bool showdrop: false
    property int now_player:0;
    property var game_fild_array: [];
    property var dice_rol:[];
    property int logic_state:0;
    property int drag_row_index: -1;
    property int turn: 0;
    property bool take_head: false
    property bool twice: false
    property bool orientation: false
    property double gl_axis_y: 1.8
    property double gl_axis_x: 1.8

    property bool gl_ready: false
    property bool logic_ready: false
    property bool dice_ready: false
    property bool fiska_ready: false

    signal logicInited;

    onInitializeGL: {
        GLCode.initializeGL(cube);
        init();
    }

    onPaintGL: {
        GLCode.paintGL(cube);
    }

    onResizeGL: {
        GLCode.resizeGL(cube);
    }

    MouseArea{
        property var drop_start: null
        anchors.fill: parent
        enabled: logic_state==3
        onClicked: {
            //if(!showdrop)GLCode.dropDice();
            //            showdrop=!showdrop
        }
        onPressed: {
            console.log("Game state:",logic_state);
            if(showdrop)return;
            drop_start = {x:mouseX,y:mouseY};
            op_dice1=1;
            op_dice2=1;
        }
        onReleased: {
            if(showdrop)return;
            if(!drop_start)return;
            var vector = { x: mouseX - drop_start.x, y: mouseY - drop_start.y };
            var vector_start = { x: drop_start.x/width, y: drop_start.y/height };
            drop_start = null;
            var dist = Math.sqrt(vector.x * vector.x + vector.y * vector.y);
            vector.x /= dist; vector.y /= dist;
            //console.log("vector",vector.x,vector.y);
            GLCode.dropDice(vector,vector_start);

            drop_finish_chk_timer.start();
        }
    }
    Timer{
        id:drop_finish_chk_timer
        running: false
        repeat: true
        interval: 1500
        onTriggered: {
            showdrop=running=!GLCode.is_throw_finished();
            if(showdrop)
                interval/=2.0
            else
                interval=1500;
            if(interval<100)interval=150;
            console.log("vector",running,interval);
        }
    }

//    Component.onCompleted: {
//        init();
//        logicInited();
//    }
//    Text {
//        id: dice3_num
//        color:"white"
//        font.bold:true
//        font.pointSize:0
//        renderType: Text.NativeRendering
//        text: "now_player:"+now_player+" "
//    }
//    Text {
//        id: dice1_num
//        color:"white"
//        anchors.left: dice3_num.right
//        font.bold:true
//        font.pointSize:24
//        renderType: Text.NativeRendering
//        text: dice_rol[0]>0?dice_rol[0]:" "
//    }
//    Text {
//        id: dice2_num
//        color:"white"
//        anchors.left: dice1_num.right
//        font.bold:true
//        font.pointSize:24
//        renderType: Text.NativeRendering
//        text: dice_rol[1]>0?":"+dice_rol[1]:" "
//    }
    function setFishkaPos(vec,index){
        //console.log("setFishka",index,"Pos:",vec.x,vec.y);
        GLCode.fishkas_obj[index].position.set(vec.x,vec.y,0);
    }

    function init() {
        now_player=0;
        var tmp=[];
        for (var i = 0; i < 23; i++)
            if(i!=11)
                tmp.push({count:0,color:0})
            else
                tmp.push({count:15,color:1})
        tmp.push({count:15,color:0})
        game_fild_array=tmp
        logic_state=2;
        logic_ready=true;
        chk_ready();
    }

    function chk_ready(){
        if(gl_ready&&logic_ready&&dice_ready&&fiska_ready)
            logicInited();
    }

    function get_count(index){
        //console.log("get_count:",index);
        return game_fild_array[index].count;
    }
    function get_color(index){
        return game_fild_array[index].color;
    }

    function make_turn(src, dst){
        console.log("Game make_turn logic_state:",logic_state,src,"->",dst);
        if(logic_state!=5&&logic_state!=6)return;
        console.log("Game make_turn:",src,"->",dst,now_player==0?"white[0]":"black[1]");
        var tmp=game_fild_array
        tmp[src].count=tmp[src].count-1
        game_fild_array=tmp
        tmp[dst].count=tmp[dst].count+1
        tmp[dst].color=now_player
        game_fild_array=tmp
        drag_row_index=-1;
        tmp=dice_rol

        if(src==23&&now_player==0&&(tmp[0]!=tmp[1]||(tmp[0]==tmp[1]&&turn!=0))&&src!=dst){
            take_head=true;
            console.log("Game make_turn reset white head:",src,dst,turn,tmp[0],tmp[1]);
        }
        if(src==11&&now_player==1&&(tmp[0]!=tmp[1]||(tmp[0]==tmp[1]&&turn!=0))&&src!=dst){
            take_head=true;
            console.log("Game make_turn reset black head:",src,dst,turn,tmp[0],tmp[1]);
        }
        if(Math.abs(src-dst)==tmp[0]||((tmp[0]+dst)%24==src&&now_player==1)){
            tmp[0]=0;
            if(logic_state==5)
                op_dice1_anim.start();
            else
                GLCode.hide_dice1();
            logic_state=6;
        }else
            if(Math.abs(src-dst)==tmp[1]||((tmp[1]+dst)%24==src&&now_player==1)){
                tmp[1]=0;
                if(logic_state==5)
                    op_dice2_anim.start();
                else
                    GLCode.hide_dice2();
                logic_state=6;
            }else
                if(Math.abs(src-dst)==(tmp[0]+tmp[1])||(((tmp[0]+tmp[1])+dst)%24==src&&now_player==1)){
                    tmp[0]=0;
                    tmp[1]=0;
                    op_dice1=0
                    op_dice2=0
                    GLCode.hide_dice1();
                    GLCode.hide_dice2();
                    logic_state=6;
                }
        dice_rol=tmp
        if(tmp[0]+tmp[1]==0){
            now_player=!now_player
            if(now_player==1)turn++;
            logic_state=3;
        }
    }

    //    function drop_dice(){
    //        if(state!=3)return;
    //        var i=0;
    //        dice_first=[];
    //        dice_second=[];
    //        do{
    //            var a=dice_first[dice_first.length-1];
    //            dice_first.push(Math.floor(Math.random()*6)+1);
    //            dice_second.push(Math.floor(Math.random()*6)+1);
    //            i++;
    //        }while(i<6)
    //        console.log(dice_first,dice_second);
    //        state=4;
    //    }
    function get_state(){
        return logic_state;
    }
    function can_drag_fishka(index){
        console.log("can_drag_fishka:",index,game_fild_array[index].color,now_player==0?"white[0]":"black[1]",take_head);
        //console.log("Game state:",logic_state);
        if(logic_state!=5&&logic_state!=6)return false;

        if(game_fild_array[index].color==now_player&&index==11&&now_player==1&&!take_head){console.log("can_drag_fishka true");return true;}

        if(game_fild_array[index].color==now_player&&index==23&&now_player==0&&!take_head){console.log("can_drag_fishka true");return true;}

        if(index!=23&&index!=11)
        {
            console.log("can_drag_fishka",game_fild_array[index].color==now_player);
            return game_fild_array[index].color==now_player;
        }else{
            console.log("can_drag_fishka false");
            return false;
        }
    }
    function can_drop_fishka(src, dst){
        return true;
        //console.log("can_drop_fishka:",src,dst);
        if(logic_state!=5&&logic_state!=6)return false;
        if(src<0)return false;
        if(get_count(dst)>0&&get_color(src)!=get_color(dst))return false;
        var res=false;
        if(src-dst==0)res=true;
        if(src-dst==dice_rol[0])res=true;

        if(src-dst==dice_rol[1])res=true;
        if(src-dst==(dice_rol[0]+dice_rol[1]))res=true;
        if(now_player==1){
            if(src==(dice_rol[0]+dst)%24)res=true;
            if(src==(dice_rol[1]+dst)%24)res=true;
            if(src==((dice_rol[0]+dice_rol[1])+dst)%24)res=true;
        }

        //console.log("can_drop_fishka:"+src+"->"+dst+" dice:"+dice_rol+" result:"+res);
        return res;
    }

    function get_dice(ind){
        if(logic_state==5||logic_state==6){
            return dice_rol[ind]
        }
        return 0;
        //        var tmp=[]
        //        if(dice_first.length==1&&dice_second.length==1&&state==4){
        //            tmp.push(dice_first[0]);
        //            tmp.push(dice_second[0]);
        //            dice_rol=tmp;
        //            state=5;
        //        }
        //        tmp=ind==0?dice_first:dice_second;
        //        if(tmp.length==1)return tmp[0];
        //        var i=Math.floor(Math.random()*tmp.length);
        //        var d=tmp[i];
        //        tmp.splice(i,1);
        //        return d;
    }
    function set_dice(a,b){
        var tmp=dice_rol
        if(a>0){
            tmp[0]=a
        }
        if(b>0){
            tmp[1]=b
        }
        if(tmp[0]>0&&tmp[1]>0){
            take_head=false;
            logic_state=5
        }
        dice_rol=tmp;
    }
    property double op_dice1: 1
    property double op_dice2: 1

    NumberAnimation {
        id:op_dice1_anim
        target: cube
        property: "op_dice1"
        duration: 500
        from:1
        to:0
        easing.type: Easing.InOutQuad
        onStopped: {
            GLCode.hide_dice1();
        }
    }
    NumberAnimation {
        id:op_dice2_anim
        target: cube
        property: "op_dice2"
        duration: 500
        from:1
        to:0
        easing.type: Easing.InOutQuad
        onStopped: {
            GLCode.hide_dice2();
        }
    }
//    Behavior on op_dice1{
//        NumberAnimation { from:1;to:0;duration: 500 }
//        NumberAnimation { from:0;to:1;duration: 0 }
//    }
//    Behavior on op_dice2{
//        NumberAnimation { from:1;to:0;duration: 500 }
//        NumberAnimation { from:0;to:1;duration: 0 }
//    }
}
