import QtQuick 2.0

Component {
    property int now_player:0;
    property array game_fild_array:  [
                {count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0}
                ,{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:15,color:1}
                ,{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0}
                ,{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:15,color:0}];

    var dice_first = [0];
    var dice_second = [0];
    var state=0;

    function init() {
        now_player=0;
        game_fild_array =  [
            {count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0}
            ,{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:15,color:1}
            ,{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0}
            ,{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:15,color:0}];
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
        game_fild_array[src].count=game_fild_array[src].count-1
        game_fild_array[dst].count=game_fild_array[dst].count+1
        //updateAfterDrop(src,dst);
        now_player=!now_player
        state=3;
    }

    function drop_dice(){
        if(state!=3)return;
        var i=0;
        dice_first=[Math.floor(Math.random()*6)+1];
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
        console.log("can_drop_fishka:"+src+"-"+dst);
        return true;
    }
    function get_dice(ind){
        if(dice_first.length==1&&dice_second.length==1&&state==4)state=5;
        var tmp=ind==0?dice_first:dice_second;
        if(tmp.length==1)return tmp[0];
        var i=Math.floor(Math.random()*tmp.length);
        var d=tmp[i];
        tmp.splice(i,1);
        return d;
    }
}
