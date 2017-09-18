.pragma library

var data_context = null;
/*
var now_player = 0;


var game_coins     =                [];
//var game_first_step=[true,true];
var game_rol =                      [0,0];
var ways = [
            [23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0,24],
            [11,10,9,8,7,6,5,4,3,2,1,0,23,22,21,20,19,18,17,16,15,14,13,12,25]
        ];
var dice_rol=                       [];
var dice1_val=                      0;
var dice2_val=                      0;
var logic_state=                    0;
//var white_home:0;
//var black_home:0;
//    property int drag_row_index: -1;
var available_turns=                [];
var game_turn=                      0;
var take_head=                      0;
//var twice: false
//var turns=                          0;
*/
function add_fishka(fishka){
    data_context.game_coins.push(fishka);
    fishka.index=get_count(fishka.pos)-1;
}

function init(context) {

    /*-----NEW-----*/

    //        for(var i=0;i<15;i++)
    //        {
    //            game_coins.push({player:1,pos:11});
    //            game_coins.push({player:0,pos:23});
    //        }

    /*-------------*/
    data_context=context;
    data_context.now_player=0;
    data_context.game_turn=0;

    data_context.game_coins=[];
    data_context.game_rol = [0,0];
    data_context.ways = [
                [23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0,24],
                [11,10,9,8,7,6,5,4,3,2,1,0,23,22,21,20,19,18,17,16,15,14,13,12,25]
            ];
    data_context.dice_rol = [];
    data_context.dice1_val = 0;
    data_context.dice2_val = 0;
    data_context.available_turns = [];
    data_context.game_turn = 0;
    data_context.take_head = 0;
    data_context.logic_state = 3;
    console.log("Back Logic inited");
}

function get_count(index){

    /*-----NEW-----*/
    if(!data_context) return 0;
    var count = 0;
    if(index>25 || index<0)
        console.log("get_count for undefined index",index)
    else
        for(var i=0;i<data_context.game_coins.length;i++)
            if(data_context.game_coins[i].pos==index)count++;
    return count;
    /*-------------*/
    /*

    if(index==25||index==26){
        if(now_player)
            return black_home
        else
            return white_home;
    }
    if(game_fild_array[index])
    return game_fild_array[index].count;
    else
        console.log("get_count for undefined index",index)
    return 0;*/
}
function get_color(index){

    var color = 2;
    if(index>25 || index<0)
        console.log("get_color for undefined index",index)
    else
        for(var i=0;i<data_context.game_coins.length;i++)
            if(data_context.game_coins[i].pos==index)return data_context.game_coins[i].player;
    return color;
    /*
    if(index==25||index==26)return now_player;
    return game_fild_array[index].color;*/
}
function get_reach_turn(turns,coin,dst,roll){
    for(var i=turns.length-1;i>=0;i--){
        if(turns[i].coin===coin){
            roll.push(turns[i].dice_val);
            if(turns[i].pos2===dst)return turns[i];
            var turn=get_reach_turn(turns[i].tree,coin,dst,roll);
            if(turn!=null)return turn;
            roll.pop();
        }
    }
    return null;
}

function make_turn(coin, dst){
    if(data_context.logic_state<5||data_context.logic_state>8)return;
    if(coin.pos===dst)return;
    var roll=[];
    var turn=get_reach_turn(data_context.available_turns,coin,dst,roll);
    if(turn!=null){
        for(var j=data_context.game_coins.length-1;j>=0;j--){
            if(data_context.game_coins[j].pos==coin.pos&&data_context.game_coins[j].index>coin.index)data_context.game_coins[j].index--;
        }
        coin.pos=dst;
        coin.index=get_count(dst)-1
        data_context.available_turns=turn.tree;
        if(roll.length!=data_context.dice_rol.length){
            var dv=0;
            while(roll.length>0){
                dv=roll.pop();
                for(var di=data_context.dice_rol.length-1;di>=0;di--){

                    if(data_context.dice_rol[di]==dv){
                        var tmpd=data_context.dice_rol;
                        tmpd[di]=0;
                        data_context.dice_rol=tmpd;
                        if(di<2){
                            if(data_context.dice1_val==dv){
                                data_context.disable_dice(0);
                                break;
                            }
                            if(data_context.dice2_val==dv){
                                data_context.disable_dice(1);
                                break;
                            }
                        }
                        break;
                    }
                }
            }
        }

        var new_logic_state=data_context.logic_state;
        new_logic_state++;
        if(data_context.available_turns.length==0){
            data_context.game_turn++;
            data_context.now_player=!data_context.now_player;
            //var tmp=[];
            //tmp[0]=tmp[1]=tmp[2]=tmp[3]=0;
            data_context.dice_rol=[];
            data_context.hide_dice(0,1);
            new_logic_state=3;
            if(dst==24){
                if(get_count(24)==15){
                    data_context.showWhiteWin();
                    new_logic_state=24;
                }
            }
            if(dst==25){
                if(get_count(25)==15){
                    data_context.showBlackWin();
                    new_logic_state=25;
                }
            }
        }
        data_context.logic_state=new_logic_state;
    }
}


function get_state(){
    if(!data_context) return 0;
    return data_context.logic_state;
}


function canDragFishka(coin){
    for(var i=0;i<data_context.available_turns.length;i++){
        if(data_context.available_turns[i].coin===coin)return true;
    }
    return false;
}
function can_drag_fishka(index){
    for(var i=0;i<data_context.available_turns.length;i++){
        if(data_context.available_turns[i].pos1==index)return true;
    }

    //        if(get_count(index)==0)return false;
    //        for(var i=0;i<4;i++){
    //            if(available_turns[i])
    //                for(var j=0;j<available_turns[i].length;j++){
    //                    if(available_turns[i][j].src==index){
    //                        console.log("can_drag_fishka",index,"true")
    //                        return true;
    //                    }
    //                }
    //        }
    console.log("can_drag_fishka",index,"false")
    return false;
}
function canDropFishka(coin,dst){
    if(data_context.logic_state<5||data_context.logic_state>8)return false;
    if(coin.pos==dst)return true;
    return can_drop_fishka_p(data_context.available_turns,coin, dst)
}

function can_drop_fishka_p(turns,coin, dst){
    for(var i=0;i<turns.length;i++){
        if(turns[i].coin==coin){
            if(turns[i].pos2==dst)return true;
            if(can_drop_fishka_p(turns[i].tree,coin, dst))return true;
        }
    }
    return false;
}
function chkIsAtHome(){
    if(data_context.game_coins.length<30)return false;
    for(var i=0;i<data_context.game_coins.length;i++){
        if(data_context.game_coins[i].player!=data_context.now_player)continue;
        //console.log(game_coins[i].pos,ways[now_player].indexOf(game_coins[i].pos))
        if(data_context.ways[data_context.now_player].indexOf(data_context.game_coins[i].pos)<18)return false;
    }
    return true;
}

function get_dice(ind){
    if(data_context.logic_state>=5&&data_context.logic_state<=8){
        return data_context.dice_rol[ind]
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
function set_dice(roll){
    if(roll==null)return
    var tmp=roll
    data_context.dice1_val=tmp[0];
    data_context.dice2_val=tmp[1];
//    if(a>0){
//        dice1_val=tmp[0];
//        tmp[0]=a;
//        console.log("set_dice 1:",a);
//    }
//    if(b>0){
//        dice2_val=b;
//        tmp[1]=b;
//        console.log("set_dice 2:",b);
//    }
    if(tmp[0]>0&&tmp[1]>0){
        console.log("set_dice dice_rol:",tmp);
        if(tmp[0]>tmp[1]){
            tmp[0]+=tmp[1];
            tmp[1]=tmp[0]-tmp[1];
            tmp[0]=tmp[0]-tmp[1];
        }
        data_context.take_head=1;
        if(tmp[0]==tmp[1]){
            if(data_context.game_turn<=1&&(tmp[0]==6||tmp[0]==4||tmp[0]==3))data_context.take_head=2;
            //twice=true;
            tmp[2]=tmp[3]=tmp[1];
            //turns=4;
        }else{
            //twice=false;
            //turns=2;
        }
        data_context.dice_rol=tmp;
        console.time('calculate_moves');
        calculate_moves();
        console.timeEnd('calculate_moves');
        console.log("set_dice dice_rol result:",tmp,"turn",data_context.game_turn,"movies",tmp.length,"take_head",data_context.take_head);
        data_context.logic_state=5;
    }
    data_context.dice_rol=tmp;
}

function calculate_moves(){

    //var way      = data_context.ways[now_player];
    var now_dice = 0;

    var dice_lines = [];

    // шаги по кубикам
    if(data_context.dice_rol.length>2)
        dice_lines.push([data_context.dice_rol[0],data_context.dice_rol[0],data_context.dice_rol[0],data_context.dice_rol[0]]);
    else
    {
        dice_lines.push([data_context.dice_rol[0],data_context.dice_rol[1]]);
        dice_lines.push([data_context.dice_rol[1],data_context.dice_rol[0]]);
    }

    console.log(dice_lines,dice_lines.length);
    var tree = [];
    console.time('calculate all moves');
    for(var line=0;line<dice_lines.length;line++)
    {

        //var save = [];  for(var coin=0;coin<game_coins.length;coin++) save.push([coin,game_coins[coin].pos]);
        var board = [];  for(var coin=0;coin<data_context.game_coins.length;coin++) board.push({player:data_context.game_coins[coin].player,pos:data_context.game_coins[coin].pos,coin:data_context.game_coins[coin]});
        calculate_moves2(board,data_context.now_player,dice_lines,line,tree,0);

        //for(var saveidx=0;saveidx<save.length;saveidx++)game_coins[save[saveidx][0]].pos = save[saveidx][1];
    }
    console.timeEnd('calculate all moves');
    console.time('calculate clean moves');
    var deep=calc_deep(tree,0);

    console.log("deep",deep);
    var clean_tree = [];
    for(var i=0;i<tree.length;i++){
        if(calc_deep(tree[i].tree,1)==deep)clean_tree.push(tree[i]);
    }
    console.timeEnd('calculate clean moves');
    data_context.available_turns=clean_tree;


}
function calc_deep(turns,deep){
    //console.log("call deep",turns.length,deep);
    var new_deep=deep;
    for(var i=0;i<turns.length;i++){
        var cd=calc_deep(turns[i].tree,deep+1);
        if(cd>new_deep)new_deep=cd;
        //console.log("deep",cd,deep);
    }
    return new_deep;
}
function calculate_moves2(board,player,dice_lines,line,tree,dice)
{

    if(dice>=dice_lines[line].length)return;

    for(var coin=0;coin<board.length;coin++)
    {
        var coin_steps = [];

        if(board[coin].player!==player)continue;
        if(board[coin].pos>23)continue;

        if(dice_lines[line][dice]===0)return;

        var src     = board[coin].pos;
        var way_idx = 999;
        for(var w=0;w<data_context.ways[player].length-1;w++)
        {
            if(data_context.ways[player][w]==board[coin].pos)
            {
                way_idx = w;
                break;
            }
        }



        if(way_idx+dice_lines[line][dice]===24)
        {
            var finded = false;
            for(var coin2=0;coin2<board.length;coin2++)
            {
                if(board[coin2].player!==player)continue;
                for(var w=0;w<data_context.ways[player].length-1;w++)
                {
                    if(data_context.ways[player][w]===board[coin2].pos && w<18)
                    {
                        finded = true;
                        break;
                    }
                }
                if(finded===true)
                    break;
            }
            if(finded===true)
                continue;
        }

        if(way_idx+dice_lines[line][dice]>24)
        {
            var finded = false;
            for(var coin2=0;coin2<board.length;coin2++)
            {
                if(board[coin2].player!==player)continue;
                for(var w=0;w<data_context.ways[player].length-1;w++)
                {
                    if(data_context.ways[player][w]===board[coin2].pos && w<way_idx)
                    {
                        finded = true;
                        break;
                    }
                }
                if(finded===true)
                    break;
            }
            if(finded===true)
                continue;
        }

        if(way_idx+dice_lines[line][dice]>24)way_idx=24-dice_lines[line][dice];

        var dst_way = data_context.ways[player][way_idx+dice_lines[line][dice]];
        var color = 2;//get_color(dst_way);
        for(var ci=0;ci<board.length;ci++)
            if(board[ci].pos==dst_way){color=board[ci].player;break}
        // правила

        //if(way_idx+dice_lines[line][dice]>23)way_idx=24;//continue;
        if(color!==player && color!==2)continue;
        if(data_context.take_head==0&&way_idx==0)continue;

        if(way_idx==0)data_context.take_head--;
        var tree2 = [];
        //var save = [];  for(var coin2=0;coin2<game_coins.length;coin2++) save.push([coin2,game_coins[coin2].pos]);
        var new_board = [];  for(var coin2=0;coin2<board.length;coin2++) new_board.push({player:board[coin2].player,pos:coin!=coin2?board[coin2].pos:dst_way,coin:board[coin2].coin});

        //game_coins[coin].pos = dst_way;


        // проверка на 6 подряд


        calculate_moves2(new_board,player,dice_lines,line,tree2,dice+1);
        //for(var saveidx=0;saveidx<save.length;saveidx++)game_coins[save[saveidx][0]].pos = save[saveidx][1];
        if(way_idx==0)data_context.take_head++;

        tree.push({
                      coin:board[coin].coin,
                      //                              way1:way_idx,
                      //                              way2:way_idx+dice_lines[line][dice],
                      //                              pos1:src,
                      pos2:dst_way,
                      //                              line:line,
                      //                              dice:dice,
                      dice_val:dice_lines[line][dice],
                      tree:tree2
                  });

    }

}
