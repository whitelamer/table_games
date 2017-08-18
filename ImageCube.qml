import QtQuick 2.0
import QtCanvas3D 1.0
//import BulletSim 1.0
import "imagecube.js" as GLCode
//import "cannon.js" as Cannon
Canvas3D {
    id: cube
    property bool showdrop: false
    property int now_player:0;
    property var game_fild_array: [];
    property var dice_rol:[];
    property int dice1_val:0;
    property int dice2_val:0;
    property int logic_state:0;
    property int white_home:0;
    property int black_home:0;
    property int drag_row_index: -1;
    property var available_turns: [];
    property int turn: 0;
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
    function get3dObj(index){
        return GLCode.fishkas_obj[index];
    }

    function init() {
        now_player=0;
        white_home=0;
        black_home=0;
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
        if(index==25){
            if(now_player)
                return black_home
            else
                return white_home;
        }
        return game_fild_array[index].count;
    }
    function get_color(index){
        if(index==25)return now_player;
        return game_fild_array[index].color;
    }

    function make_turn(src, dst){
        //console.log("Game make_turn logic_state:",logic_state,src,"->",dst);
        if(logic_state<5||logic_state>8)return;
        if(!can_drop_fishka(src,dst))return;
        if(src==dst)return;
        //console.log("Game make_turn:",src,"->",dst,now_player==0?"white[0]":"black[1]");
        var tmp=game_fild_array
        tmp[src].count=tmp[src].count-1
        game_fild_array=tmp
        if(dst!=25){
            tmp[dst].count=tmp[dst].count+1
            tmp[dst].color=now_player
            game_fild_array=tmp
        }else{
            if(now_player)
                black_home++
            else
                white_home++;
            console.log("Game make_turn need remove fiska");
        }

        drag_row_index=-1;
        tmp=dice_rol

        if(src==23&&now_player==0){
            take_head--;
        }
        if(src==11&&now_player==1){
            take_head--;
        }


        var dt=(src+24-dst)%24;
        console.log("Game make_turn",src,"->",dst,dt,"dice_rol",dice_rol,"dice1_val",dice1_val,"dice2_val",dice2_val);
        for(var i=turns;i>0;i--){
            if(dt>=tmp[i-1]){
                dt-=tmp[i-1];
                turns--;
                if(i<3)
                    if(tmp[i-1]==dice1_val){
                        if(turns>0)
                            op_dice1_anim.start();
                        else
                            GLCode.hide_dice1();
                        dice1_val=0;
                    }else{
                        if(turns>0)
                            op_dice2_anim.start();
                        else
                            GLCode.hide_dice2();
                        dice2_val=0;
                    }
                tmp[i-1]=0;
                logic_state++;
            }
        }
        console.log("Game make_turn correct dices",dice_rol,"dice1_val",dice1_val,"dice2_val",dice2_val,"dt",dt,"turns",turns,"take_head",take_head);
        /*if(Math.abs(src-dst)==tmp[0]||((tmp[0]+dst)%24==src&&now_player==1)){
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
        */
        dice_rol=tmp
        if(chk_end_turn()){
            if(now_player==1)turn++;
            now_player=!now_player
            tmp[0]=tmp[1]=tmp[2]=tmp[3]=0;
            dice_rol=tmp;
            GLCode.hide_dice1();
            GLCode.hide_dice2();
            logic_state=3;
            console.log("End make_turn",now_player,turn,logic_state);
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
    function chk_end_turn(){
        if(dice_rol[0]+dice_rol[1]+dice_rol[2]+dice_rol[3]==0)return true;
        var can_drag=true;
        for(var i=0;i<24;i++){
            if(can_drag_fishka(i))can_drag=false;
        }
        return can_drag;
    }
    function can_drag_fishka(index){
        for(var i=0;i<4;i++){
            if(available_turns[i])
                for(var j=0;j<available_turns[i].length;j++){
                    if(available_turns[i][j].src==index)return true;
                }
        }
        return false;
    }
    function can_drag_fishka_old(index){
        console.log("can_drag_fishka:",index,game_fild_array[index].color,now_player==0?"white[0]":"black[1]",take_head);
        //console.log("Game state:",logic_state);
        if(logic_state<5||logic_state>8)return false;

        //        if(game_fild_array[index].color==now_player&&index==11&&now_player==1&&!take_head){
        //            //console.log("can_drag_fishka true");
        //            return true;
        //        }

        //        if(game_fild_array[index].color==now_player&&index==23&&now_player==0&&!take_head){
        //            //console.log("can_drag_fishka true");
        //            return true;
        //        }

        //if(index!=23&&index!=11)
        if((index==11&&now_player==1&&!take_head)||(index==23&&now_player==0&&!take_head))
        {
            //console.log("can_drag_fishka",game_fild_array[index].color==now_player);
            return false;
        }else{
            if(game_fild_array[index].color!=now_player)return false;

            var can_drop=false;
            if(dice_rol[0]>0&&can_drop_fishka(index,(index+24-dice_rol[0])%24))can_drop=true
            if(dice_rol[1]>0&&can_drop_fishka(index,(index+24-dice_rol[1])%24))can_drop=true
            if(dice_rol[0]+dice_rol[1]>0&&can_drop_fishka(index,(index+24-(dice_rol[0]+dice_rol[1]))%24))can_drop=true
            if(chk_at_home()){
                if(can_drop_fishka(index,25))can_drop=true
            }else{
                if(now_player){
                    if(index>11&&(index+24-dice_rol[0])%24<=11)return false;
                    if(index>11&&(index+24-dice_rol[1])%24<=11)return false;
                }else{
                    if(index-dice_rol[0]<0)return false;
                    if(index-dice_rol[1]<0)return false;
                }
            }

            //            for(var i=index-1;i!=index;i--%24){
            //                if()can_drop=true;
            //                console.log("for",index,i,can_drop);
            //            }
            console.log("can_drag_fishka:",index,can_drop);
            return can_drop;
        }
    }
    function can_drop_fishka(src, dst){
        if(logic_state<5||logic_state>8)return false;
        if(src<0)return false;
        if(get_count(dst)>0&&get_color(src)!=get_color(dst))return false;
        if(get_color(src)!=now_player||get_count(src)==0)return false;
        if(src==dst)return true;

        for(var i=0;i<4;i++){
            if(available_turns[i])
                for(var j=0;j<available_turns[i].length;j++){
                    if(available_turns[i][j].src==src&&available_turns[i][j].dst==dst)return true;
                }
        }
        return false;
    }

    function can_drop_fishka_old(src, dst){
        //return true;
        if(logic_state<5||logic_state>8)return false;
        if(src<0)return false;
        if(get_count(dst)>0&&get_color(src)!=get_color(dst))return false;
        if(get_color(src)!=now_player||get_count(src)==0)return false;
        console.log("can_drop_fishka:",src,"->",dst,"dice_rol",dice_rol,"turns",turns);
        var res=false;
        if(src-dst==0)res=true;

        switch(turns){
        case 4:
            if(src-dst==(dice_rol[0]*4))res=true;
            if(now_player==1){
                if(src==((dice_rol[0]*4)+dst)%24&&((dice_rol[0]*4)+dst)%24>11)res=true;
            }
        case 3:
            if(src-dst==(dice_rol[0]*3))res=true;
            if(now_player==1){
                if(src==((dice_rol[0]*3)+dst)%24&&((dice_rol[0]*3)+dst)%24>11)res=true;
            }
        case 2:
            if(src-dst==(dice_rol[0]+dice_rol[1]))res=true;
            if(now_player==1){
                if(src==((dice_rol[0]+dice_rol[1])+dst)%24)res=true;
            }
        case 1:
            if(src-dst==dice_rol[0])res=true;
            if(src-dst==dice_rol[1])res=true;
            if(now_player==1){
                if(src==(dice_rol[0]+dst)%24)res=true;
                if(src==(dice_rol[1]+dst)%24)res=true;
            }
        }
        //        if(src-dst==dice_rol[0])res=true;
        //        if(src-dst==dice_rol[1])res=true;
        //        if(src-dst==(dice_rol[0]+dice_rol[1]))res=true;

        //        if(now_player==1){
        //            if(src==(dice_rol[0]+dst)%24)res=true;
        //            if(src==(dice_rol[1]+dst)%24)res=true;
        //            if(src==((dice_rol[0]+dice_rol[1])+dst)%24)res=true;
        //        }
        if(dst==25){
            if(chk_at_home()){//paranoya
                if(now_player){
                    if(src-dice_rol[0]==11||src-dice_rol[1]==11)res=true;
                    if(!res&&(src-dice_rol[0]<11||src-dice_rol[1]<11))res=true;
                }else{
                    if(src-dice_rol[0]==-1||src-dice_rol[1]==-1)res=true;
                    if(!res&&(src-dice_rol[0]>0||src-dice_rol[1]>0))res=true;
                }
            }else res=false;
        }

        console.log("can_drop_fishka:"+src+"->"+dst+" dice:"+dice_rol+" result:"+res);
        return res;
    }
    function chk_at_home(){
        console.log("chk_at_home:",now_player==0?"white[0]":"black[1]",now_player==0?white_home:black_home);
        if(now_player){
            var sum=black_home;
            for(var i=12;i<=17;i++){
                if(get_count(i)>0&&get_color(i)==1)sum+=get_count(i);
            }
            console.log("chk_at_home:",sum==15);
            return sum==15;
        }else{
            var sum=white_home;
            for(var i=0;i<=5;i++){
                if(get_count(i)>0&&get_color(i)==0)sum+=get_count(i);
            }
            console.log("chk_at_home:",sum==15);
            return sum==15;
        }
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
                if(turn==0&&(tmp[0]==6||tmp[0]==4||tmp[0]==3))take_head=2;
                twice=true;
                tmp[2]=tmp[3]=tmp[1];
                turns=4;
            }else{
                twice=false;
                turns=2;
            }
            calculate_moves();
            console.log("set_dice dice_rol result:",tmp,"turns",turns,"take_head",take_head);
            logic_state=5;
        }
        dice_rol=tmp;
    }
    function can_turn(src,dst){
        console.log("can_turn:",src,"->",dst," dice:",dice_rol);
        if(dst == 25&&chk_at_home())return chk_at_home();
        if(dst<0){
            if(now_player==1){
                dst=(dst+24)%24;
                if(dst<12)return false;
            }else
                return false;
        }
        if(get_count(dst)>0)
            return get_color(dst)==get_color(src);
        else
            return true;
    }

    function calculate_moves(){
        var movies=[[],[],[],[]];
        for(var i=23;i>=0;i--){
            if(get_count(i)>0&&get_color(i)==now_player){
                if(can_turn(i,i-dice_rol[0])){
                    if(can_turn(i-dice_rol[0],i-dice_rol[0]-dice_rol[1])){
                        movies[1].push({src:i,dst:(24+i-dice_rol[0]-dice_rol[1])%24});
                        if(turns==4&&can_turn(i-dice_rol[0]-dice_rol[1],i-dice_rol[0]-dice_rol[1]-dice_rol[2])){
                            movies[2].push({src:i,dst:(24+i-dice_rol[0]-dice_rol[1]-dice_rol[2])%24});
                            if(can_turn(i-dice_rol[0]-dice_rol[1]-dice_rol[2],i-dice_rol[0]-dice_rol[1]-dice_rol[2]-dice_rol[3])){
                                movies[3].push({src:i,dst:(24+i-dice_rol[0]-dice_rol[1]-dice_rol[2]-dice_rol[3])%24});
                            }
                        }
                    }
                    movies[0].push({src:i,dst:(24+i-dice_rol[0])%24});
                }
                if(dice_rol[0]!=dice_rol[1]&&can_turn(i,i-dice_rol[1])){
                    if(can_turn(i-dice_rol[1],i-dice_rol[0]-dice_rol[1])){
                        movies[1].push({src:i,dst:(24+i-dice_rol[0]-dice_rol[1])%24});
                    }else{

                    }
                    movies[0].push({src:i,dst:(24+i-dice_rol[0])%24});
                }
            }
        }

        console.log("movies");

        for(i=0;i<4;i++){
            if(movies[i])
                for(var j=0;j<movies[i].length;j++){
                    console.log("move",i,movies[i][j].src,"->",movies[i][j].dst);
                }
        }
        console.log("movies cleaning");

        if(turns==2){
            if(movies[1]&&movies[1].length>0)
                movies[0]=[];
        }
        if(turns==4){
            if(movies[3]&&movies[3].length>0){
                movies[2]=[];
                movies[1]=[];
                movies[0]=[];
            }
            if(movies[2]&&movies[2].length>0){
                movies[1]=[];
            }
        }

        for(i=0;i<4;i++){
            if(movies[i])
                for(var j=0;j<movies[i].length;j++){
                    console.log("move",i,movies[i][j].src,"->",movies[i][j].dst);
                }
        }
        console.log("movies end");
        available_turns=movies;
        //console.log("movies",movies);
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
