import QtQuick 2.0
import QtCanvas3D 1.0
//import BulletSim 1.0
import "imagecube.js" as GLCode
//import "cannon.js" as Cannon
Canvas3D {
    id: cube
    property bool showdrop: false
    property int now_player:0;
    //    property var game_fild_array: [{count:3,color:0},{count:3,color:0},{count:3,color:0},{count:3,color:0},{count:2,color:0},{count:0,color:0},
    //    {count:1,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},
    //    {count:3,color:1},{count:3,color:1},{count:3,color:1},{count:3,color:1},{count:2,color:1},{count:0,color:0},
    //    {count:1,color:1},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0},{count:0,color:0}];

    /*-----NEW-----*/
    property var game_coins     :[];
    property var game_first_step:[true,true];
    property var game_rol       :[0,0];
    property var ways  : [
        [23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0,24],
        [11,10,9,8,7,6,5,4,3,2,1,0,23,22,21,20,19,18,17,16,15,14,13,12,25]
    ];
    /*-------------*/

    property var dice_rol:[];
    property int dice1_val:0;
    property int dice2_val:0;
    property int logic_state:0;
    property int white_home:0;
    property int black_home:0;
    //    property int drag_row_index: -1;
    property var available_turns: [];
    property int game_turn: 0;
    property int take_head: 0
    property bool twice: false
    property int turns: 0
    property bool orientation: false

    property double gl_axis_y: 1.8
    property double gl_axis_x: 1.8

    property double phy_axis_y1: 1.8
    property double phy_axis_y2: 1.8
    property double phy_axis_x: 1.8


    property bool gl_ready: false
    property bool logic_ready: false
    property bool dice_ready: false
    property bool fiska_ready: false

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
    Text{
        id:label_drop
        text: "PRESS FOR DROP DICE"
        font.bold:true
        font.pointSize:24
        visible: logic_state==3&&!showdrop
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
    MouseArea{
        property var drop_start: null
        anchors.fill: parent
        enabled: logic_state==3
        onClicked: {
            //if(!showdrop)GLCode.dropDice();
            //            showdrop=!showdrop
        }
        onPressed: {
            console.log("Game state:",logic_state,mouse.x,mouse.y,width/2,now_player);
            if(showdrop)return;
            drop_start=null;
            if(now_player){
                if(mouse.x>width/2)return;
            }else{
                if(mouse.x<=width/2)return;
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
            if(showdrop)return;
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
    //    function setFishkaPos(vec,index){
    //        //console.log("setFishka",index,"Pos:",vec.x,vec.y);
    //        GLCode.fishkas_obj[index].position.set(vec.x,vec.y,0);
    //    }
    //    function setFishkaShadow(val,index){
    //        //console.log("setFishka",index,"Pos:",vec.x,vec.y);
    //        GLCode.fishkas_obj[index].castShadow=val;
    //    }
    function get3dObj(player){//index
        if(GLCode.fishkas_obj.length>0){
            for(var i=0;i<GLCode.fishkas_obj.length;i++){
                if(GLCode.fishkas_obj[i].color==player){
                    var ret=GLCode.fishkas_obj[i];
                    GLCode.fishkas_obj.splice(i, 1);
                    return ret;
                }
            }
        }
        return null;//GLCode.fishkas_obj[index];
    }
    function add_fishka(fishka){
        game_coins.push(fishka);
        fishka.index=get_count(fishka.pos)-1;
    }

    function init() {

        /*-----NEW-----*/

        //        for(var i=0;i<15;i++)
        //        {
        //            game_coins.push({player:1,pos:11});
        //            game_coins.push({player:0,pos:23});
        //        }

        /*-------------*/

        now_player=0;
        game_turn=0;
        /*white_home=0;
        black_home=0;*/
        /*
        var tmp=[];
        for (var i = 0; i < 23; i++)
            if(i!=11)
                tmp.push({count:0,color:0})
            else
                tmp.push({count:15,color:1})

        tmp.push({count:15,color:0})
        game_fild_array=tmp
        */
        logic_state=2;
        logic_ready=true;
    }

    function get_count(index){

        /*-----NEW-----*/
        var count = 0;
        if(index>25 || index<0)
            console.log("get_count for undefined index",index)
        else
            for(var i=0;i<game_coins.length;i++)
                if(game_coins[i].pos==index)count++;
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
            for(var i=0;i<game_coins.length;i++)
                if(game_coins[i].pos==index)return game_coins[i].player;
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
        if(logic_state<5||logic_state>8)return;
        if(coin.pos===dst)return;
        var roll=[];
        var turn=get_reach_turn(available_turns,coin,dst,roll);
        if(turn!=null){
            for(var j=game_coins.length-1;j>=0;j--){
                if(game_coins[j].pos==coin.pos&&game_coins[j].index>coin.index)game_coins[j].index--;
            }
            coin.pos=dst;
            coin.index=get_count(dst)-1
            available_turns=turn.tree;
            if(roll.length!=dice_rol.length){
                var dv=0;
                while(roll.length>0){
                    dv=roll.pop();
                    for(var di=dice_rol.length-1;di>=0;di--){

                        if(dice_rol[di]==dv){
                            var tmpd=dice_rol;
                            tmpd[di]=0;
                            dice_rol=tmpd;
                            if(di<2){
                                if(dice1_val==dv){
                                    op_dice1_anim.start();
                                    break;
                                }
                                if(dice2_val==dv){
                                    op_dice2_anim.start();
                                    break;
                                }
                            }
                            break;
                        }
                    }
                }
            }

            var new_logic_state=logic_state;
            new_logic_state++;
            if(available_turns.length==0){
                game_turn++;
                now_player=!now_player;
                //var tmp=[];
                //tmp[0]=tmp[1]=tmp[2]=tmp[3]=0;
                dice_rol=[];
                GLCode.hide_dice1();
                GLCode.hide_dice2();
                new_logic_state=3;
                if(dst==24){
                    if(get_count(24)==15){
                        showWhiteWin();
                        new_logic_state=24;
                    }
                }
                if(dst==25){
                    if(get_count(25)==15){
                        showBlackWin();
                        new_logic_state=25;
                    }
                }
            }
            logic_state=new_logic_state;
        }

        /*for(var i=available_turns.length-1;i>=0;i--){
            if(available_turns[i].coin===coin){

                for(var j=game_coins.length-1;j>=0;j--){
                    if(game_coins[j].pos==coin.pos&&game_coins[j].index>coin.index)game_coins[j].index--;
                }

                coin.pos=dst;
                coin.index=get_count(dst)-1
                available_turns=available_turns[i].tree;

                var new_logic_state=logic_state;
                new_logic_state++;
                if(available_turns.length==0){
                    turn++;
                    now_player=!now_player;
                    //var tmp=[];
                    //tmp[0]=tmp[1]=tmp[2]=tmp[3]=0;
                    dice_rol=[];
                    GLCode.hide_dice1();
                    GLCode.hide_dice2();
                    new_logic_state=3;
                }
                logic_state=new_logic_state;
                return;
            }
        }*/
    }


    function get_state(){
        return logic_state;
    }


    function canDragFishka(coin){
        for(var i=0;i<available_turns.length;i++){
            if(available_turns[i].coin===coin)return true;
        }
        return false;
    }
    function can_drag_fishka(index){
        for(var i=0;i<available_turns.length;i++){
            if(available_turns[i].pos1==index)return true;
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
        if(logic_state<5||logic_state>8)return false;
        if(coin.pos==dst)return true;
        return can_drop_fishka_p(available_turns,coin, dst)
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
        if(game_coins.length<30)return false;
        for(var i=0;i<game_coins.length;i++){
            if(game_coins[i].player!=now_player)continue;
            //console.log(game_coins[i].pos,ways[now_player].indexOf(game_coins[i].pos))
            if(ways[now_player].indexOf(game_coins[i].pos)<18)return false;
        }
        return true;
    }

    function get_dice(ind){
        if(logic_state>=5&&logic_state<=8){
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
            dice1_val=a;
            tmp[0]=a;
            console.log("set_dice 1:",a);
        }
        if(b>0){
            dice2_val=b;
            tmp[1]=b;
            console.log("set_dice 2:",b);
        }
        if(tmp[0]>0&&tmp[1]>0){
            console.log("set_dice dice_rol:",tmp);
            if(tmp[0]>tmp[1]){
                tmp[0]+=tmp[1];
                tmp[1]=tmp[0]-tmp[1];
                tmp[0]=tmp[0]-tmp[1];
            }
            take_head=1;
            if(tmp[0]==tmp[1]){
                if(game_turn<=1&&(tmp[0]==6||tmp[0]==4||tmp[0]==3))take_head=2;
                twice=true;
                tmp[2]=tmp[3]=tmp[1];
                turns=4;
            }else{
                twice=false;
                turns=2;
            }
            dice_rol=tmp;
            console.time('t');
            calculate_moves();
            console.timeEnd('t');
            console.log("set_dice dice_rol result:",tmp,"turn",game_turn,"movies",turns,"take_head",take_head);
            logic_state=5;
        }
        dice_rol=tmp;
    }

    function calculate_moves(){

        var way      = ways[now_player];
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

        console.log(dice_lines,dice_lines.length);
        var tree = [];
        for(var line=0;line<dice_lines.length;line++)
        {

            //var save = [];  for(var coin=0;coin<game_coins.length;coin++) save.push([coin,game_coins[coin].pos]);
            var board = [];  for(var coin=0;coin<game_coins.length;coin++) board.push({player:game_coins[coin].player,pos:game_coins[coin].pos,coin:game_coins[coin]});
            calculate_moves2(board,now_player,dice_lines,line,tree,0);

            //for(var saveidx=0;saveidx<save.length;saveidx++)game_coins[save[saveidx][0]].pos = save[saveidx][1];
        }

        var deep=calc_deep(tree,0);

        console.log("deep",deep);
        var clean_tree = [];
        for(var i=0;i<tree.length;i++){
            if(calc_deep(tree[i].tree,1)==deep)clean_tree.push(tree[i]);
        }
        available_turns=clean_tree;


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

            if(board[coin].player!==now_player)continue;
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
                    if(board[coin2].player!==now_player)continue;
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
                    if(board[coin2].player!==now_player)continue;
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
            if(color!==now_player && color!==2)continue;
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
                          //                              pos1:src,
                          pos2:dst_way,
                          //                              line:line,
                          //                              dice:dice,
                          dice_val:dice_lines[line][dice],
                          tree:tree2
                      });

        }

    }




    property double op_dice1: 1
    property double op_dice2: 1

    NumberAnimation {
        id:op_dice1_anim
        target: cube
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
        target: cube
        property: "op_dice2"
        duration: 500
        from:1
        to:0.5
        easing.type: Easing.Linear
        onStopped: {
            //GLCode.hide_dice2();
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
