
var game_turn=0;

var take_head=0;
var ways = [
    [23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0,24],
    [11,10,9,8,7,6,5,4,3,2,1,0,23,22,21,20,19,18,17,16,15,14,13,12,25]
];

WorkerScript.onMessage = function(message) {
    game_turn=message.game_turn;
    var ret_tree=set_dice(message.roll,message.board,message.player);
    WorkerScript.sendMessage({ 'tree': ret_tree })
}


function set_dice(roll,board,player){
    if(roll==null)return
    var tmp=[];//roll
//    tmp[0]=data_context.dice1_val=roll[0];
//    tmp[1]=data_context.dice2_val=roll[1];
    tmp[0]=roll[0];
    tmp[1]=roll[1];

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
    var ret=null;
    if(tmp[0]>0&&tmp[1]>0){
//        if(tmp[0]>tmp[1]){
//            tmp[0]+=tmp[1];
//            tmp[1]=tmp[0]-tmp[1];
//            tmp[0]=tmp[0]-tmp[1];
//        }
        take_head=1;
        if(tmp[0]==tmp[1]){
            if(game_turn<=1&&(tmp[0]==6||tmp[0]==4||tmp[0]==3))take_head=2;
            //twice=true;
            tmp[2]=tmp[3]=tmp[1];
            //turns=4;
        }else{
            //twice=false;
            //turns=2;
        }
        //data_context.dice_rol=tmp;
        console.time('calculate_moves');
        ret=calculate_moves(tmp,board,player);
        //console.log("onMessage",ret)
        console.timeEnd('calculate_moves');
        //console.log("set_dice dice_rol result:",tmp,"turn",game_turn,"movies",tmp.length,"take_head",take_head);
        //logic_state=5;
    }
    return ret;
}

function calculate_moves(dice_rol,board,player){

    //var way      = data_context.ways[now_player];
    var now_dice = 0;

    var dice_lines = [];

    // шаги по кубикам
    if(dice_rol.length>2)
        dice_lines.push([dice_rol[0],dice_rol[0],dice_rol[0],dice_rol[0]]);
    else
    {
        dice_lines.push([dice_rol[0],dice_rol[1]]);
        dice_lines.push([dice_rol[1],dice_rol[0]]);
    }

    //console.log(dice_lines,dice_lines.length);
    var tree = [];
    for(var line=0;line<dice_lines.length;line++)
    {

        //var save = [];  for(var coin=0;coin<game_coins.length;coin++) save.push([coin,game_coins[coin].pos]);
        //var board = [];  for(var coin=0;coin<data_context.game_coins.length;coin++) board.push({player:data_context.game_coins[coin].player,pos:data_context.game_coins[coin].pos,coin:data_context.game_coins[coin]});
        calculate_moves2(board,player,dice_lines,line,tree,0);

        //for(var saveidx=0;saveidx<save.length;saveidx++)game_coins[save[saveidx][0]].pos = save[saveidx][1];
    }
    var deep=calc_deep(tree,0);
    //console.log("deep",deep);
    var clean_tree = [];
    for(var i=0;i<tree.length;i++){
        if(calc_deep(tree[i].tree,1)==deep)clean_tree.push(tree[i]);
    }
    return clean_tree;
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
        for(var w=0;w<ways[player].length-1;w++)
        {
            if(ways[player][w]==board[coin].pos)
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
                for(var w=0;w<ways[player].length-1;w++)
                {
                    if(ways[player][w]===board[coin2].pos && w<18)
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
                for(var w=0;w<ways[player].length-1;w++)
                {
                    if(ways[player][w]===board[coin2].pos && w<way_idx)
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

        var dst_way = ways[player][way_idx+dice_lines[line][dice]];
        var color = 2;//get_color(dst_way);
        for(var ci=0;ci<board.length;ci++)
            if(board[ci].pos==dst_way){color=board[ci].player;break}
        // правила

        //if(way_idx+dice_lines[line][dice]>23)way_idx=24;//continue;
        if(color!==player && color!==2)continue;
        if(take_head==0&&way_idx==0)continue;

        if(way_idx==0)take_head--;
        var tree2 = [];
        //var save = [];  for(var coin2=0;coin2<game_coins.length;coin2++) save.push([coin2,game_coins[coin2].pos]);
        var new_board = [];  for(var coin2=0;coin2<board.length;coin2++) new_board.push({player:board[coin2].player,pos:coin!=coin2?board[coin2].pos:dst_way,coin:board[coin2].coin});

        //game_coins[coin].pos = dst_way;


        // проверка на 6 подряд


        calculate_moves2(new_board,player,dice_lines,line,tree2,dice+1);
        //for(var saveidx=0;saveidx<save.length;saveidx++)game_coins[save[saveidx][0]].pos = save[saveidx][1];
        if(way_idx==0)take_head++;
        tree.push({
                      coin:board[coin].coin,
                      //                              way1:way_idx,
                      //                              way2:way_idx+dice_lines[line][dice],
                      pos1:src,
                      pos2:dst_way,
                      //                              line:line,
                      //                              dice:dice,
                      dice_val:dice_lines[line][dice],
                      tree:tree2
                  });

    }

}
