import QtQuick 2.0
import QtCanvas3D 1.0
import BulletSim 1.0
import "imagecube.js" as GLCode
//import "cannon.js" as Cannon
Canvas3D {
    id: cube
    property bool showdrop: false
/*    Item{
        id:dice1
        property real xRotation: 0
        property real yRotation: 0
        property real zRotation: 0
        state: "image1"
        states: [
            State {
                name: "image1"
                PropertyChanges { target: dice1; xRotation: 0; }
                PropertyChanges { target: dice1; yRotation: 180 * 1.5; }
                PropertyChanges { target: dice1; zRotation: 0 }
            },
            State {
                name: "image5"
                PropertyChanges { target: dice1; xRotation: 0; }
                PropertyChanges { target: dice1; yRotation: 180 * 1.0; }
                PropertyChanges { target: dice1; zRotation: 0 }
            },
            State {
                name: "image6"
                PropertyChanges { target: dice1; xRotation: 0; }
                PropertyChanges { target: dice1; yRotation: 180 * 0.5; }
                PropertyChanges { target: dice1; zRotation: 0 }
            },
            State {
                name: "image2"
                PropertyChanges { target: dice1; xRotation: 0; }
                PropertyChanges { target: dice1; yRotation: 0; }
                PropertyChanges { target: dice1; zRotation: 0; }
            },
            State {
                name: "image3"
                PropertyChanges { target: dice1; xRotation: 180 / 2.0; }
                PropertyChanges { target: dice1; yRotation: 0; }
                PropertyChanges { target: dice1; zRotation: 0; }
            },
            State {
                name: "image4"
                PropertyChanges { target: dice1; xRotation: -180 / 2.0; }
                PropertyChanges { target: dice1; yRotation: 0; }
                PropertyChanges { target: dice1; zRotation: 0; }
            }
        ]
        transitions: [
            Transition {
                id: turnTransition
                from: "*"
                to: "*"
                RotationAnimation {
                    properties: "xRotation,yRotation,zRotation"
                    easing.type: Easing.Linear
                    direction: RotationAnimation.Shortest
                    duration: 450
                }
            }
        ]
    }
    Item{
        id:dice2
        property real xRotation: 0
        property real yRotation: 0
        property real zRotation: 0
        state: "image1"
        states: [
            State {
                name: "image1"
                PropertyChanges { target: dice2; xRotation: 0; }
                PropertyChanges { target: dice2; yRotation: 180 * 1.5; }
                PropertyChanges { target: dice2; zRotation: 0 }
            },
            State {
                name: "image5"
                PropertyChanges { target: dice2; xRotation: 0; }
                PropertyChanges { target: dice2; yRotation: 180 * 1.0; }
                PropertyChanges { target: dice2; zRotation: 0 }
            },
            State {
                name: "image6"
                PropertyChanges { target: dice2; xRotation: 0; }
                PropertyChanges { target: dice2; yRotation: 180 * 0.5; }
                PropertyChanges { target: dice2; zRotation: 0 }
            },
            State {
                name: "image2"
                PropertyChanges { target: dice2; xRotation: 0; }
                PropertyChanges { target: dice2; yRotation: 0; }
                PropertyChanges { target: dice2; zRotation: 0; }
            },
            State {
                name: "image3"
                PropertyChanges { target: dice2; xRotation: 180 / 2.0; }
                PropertyChanges { target: dice2; yRotation: 0; }
                PropertyChanges { target: dice2; zRotation: 0; }
            },
            State {
                name: "image4"
                PropertyChanges { target: dice2; xRotation: -180 / 2.0; }
                PropertyChanges { target: dice2; yRotation: 0; }
                PropertyChanges { target: dice2; zRotation: 0; }
            }
        ]
        transitions: [
            Transition {
                id: turnTransition2
                from: "*"
                to: "*"
                RotationAnimation {
                    properties: "xRotation,yRotation,zRotation"
                    easing.type: Easing.Linear
                    direction: RotationAnimation.Shortest
                    duration: 450
                }
            }
        ]
    }



*/
    onInitializeGL: {
        GLCode.initializeGL(cube);
    }

    onPaintGL: {
        GLCode.paintGL(cube);
    }

    onResizeGL: {
        GLCode.resizeGL(cube);
    }

    function setState1(str){
        dice1.state=str;
    }
    function setState2(str){
        dice2.state=str;
    }
    MouseArea{
        property var drop_start: null
        anchors.fill: parent
        onClicked: {
            //if(!showdrop)GLCode.dropDice();
//            showdrop=!showdrop
        }
        onPressed: {
            if(showdrop)return;
            drop_start = {x:mouseX,y:mouseY};
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

    property int now_player:0;
    property var game_fild_array: [];
    property var dice_first : [0];
    property var dice_second : [0];
    property var dice_rol:[];
    property int state:0;
    property int drag_row_index: -1;
    property int turn: 0;
    property bool twice: false

    Component.onCompleted: {
        init();
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
        console.log("game_fild_array:"+tmp);
        game_fild_array=tmp
        state=3;
    }

    function get_count(index){
        return game_fild_array[index].count;
    }
    function get_color(index){
        return game_fild_array[index].color;
    }

    function make_turn(src, dst){
        //if(state!=5)return;
        var tmp=game_fild_array
            tmp[src].count=tmp[src].count-1
        game_fild_array=tmp
            tmp[dst].count=tmp[dst].count+1
            tmp[dst].color=now_player
        game_fild_array=tmp
        drag_row_index=-1;
        tmp=dice_rol
        if(Math.abs(src-dst)==tmp[0])
            tmp[0]=0;
        else
            if(Math.abs(src-dst)==tmp[1])
                tmp[1]=0;
        if(Math.abs(src-dst)==(tmp[0]+tmp[1])){
            tmp[0]=0;
            tmp[1]=0;
        }
        dice_rol=tmp
        if(tmp[0]+tmp[1]==0){
            now_player=!now_player
            if(now_player==1)turn++;
            state=3;
        }
    }

    function drop_dice(){
        if(state!=3)return;
        var i=0;
        dice_first=[];
        dice_second=[];
        do{
            var a=dice_first[dice_first.length-1];
            dice_first.push(Math.floor(Math.random()*6)+1);
            dice_second.push(Math.floor(Math.random()*6)+1);
            i++;
        }while(i<6)
        console.log(dice_first,dice_second);
        state=4;
    }
    function get_state(){
        return state;
    }
    function can_drag_fishka(index){
        console.log("can_drag_fishka:"+index);
        return state==5&&game_fild_array[index].color==now_player;
    }
    function can_drop_fishka(src, dst){
        if(state!=5)return false;
        if(src<0)return false;
        if(get_count(dst)>0&&get_color(src)!=get_color(dst))return false;
        var res=false;
        if(src-dst==0)res=true;
        if(src-dst==dice_rol[0])res=true;

        if(src-dst==dice_rol[1])res=true;
        if(src-dst==(dice_rol[0]+dice_rol[1]))res=true;
        //console.log("can_drop_fishka:"+src+"->"+dst+" dice:"+dice_rol+" result:"+res);
        return res;
    }
    function get_dice(ind){
        var tmp=[]
        if(dice_first.length==1&&dice_second.length==1&&state==4){
            tmp.push(dice_first[0]);
            tmp.push(dice_second[0]);
            dice_rol=tmp;
            state=5;
        }
        tmp=ind==0?dice_first:dice_second;
        if(tmp.length==1)return tmp[0];
        var i=Math.floor(Math.random()*tmp.length);
        var d=tmp[i];
        tmp.splice(i,1);
        return d;
    }
}
