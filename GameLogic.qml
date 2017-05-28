import QtQuick 2.0

Item {
    property int now_player:0;
    property var game_fild_array: [];// [
                //{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0}
                //,{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:15,color:1}
                //,{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0}
                //,{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:15,color:0}];

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
