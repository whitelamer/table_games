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
function isRemoveTurn(src,dst){
    if(now_player==1){
        if(src>=12&&dst<12)return true;
    }else{
        if(src<dst)return true;
    }
    return false;
}
function chk_end_turn(){
    if(dice_rol[0]+dice_rol[1]+(dice_rol[2]||0)+(dice_rol[3]||0)==0)return true;
    var can_drag=true;
    for(var i=0;i<24;i++){
        if(can_drag_fishka(i))can_drag=false;
    }
    return can_drag;
}

function removeTurnsBySrc(index){
    var movies=[[],[],[],[]];
    for(var i=0;i<4;i++){
        if(available_turns[i])
            for(var j=0;j<available_turns[i].length;j++){
                if(available_turns[i][j].src!=index){
                    movies[i].push(available_turns[i][j]);
                }
            }
    }
    console.log("movies removeTurnsBySrc",index);
    available_turns=movies;
    for(i=0;i<4;i++){
        if(available_turns[i])
            for(var j=0;j<available_turns[i].length;j++){
                console.log("move",i,available_turns[i][j].src,"->",available_turns[i][j].dst);
            }
    }
    console.log("movies end");
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
function can_turn(src,dst){
    console.log("can_turn:",src,"->",dst," dice:",dice_rol);
//        if(dst == 25+now_player&&chk_at_home()){
//            return true;
//        }
    var at_home=chk_at_home();
    if(src==dst)return false;
    if(src>=12&&dst<12&&now_player==1)return at_home;
    if(src<12&&now_player==1&&at_home)return false;
    if(src<0){
        if(now_player==1){
            src=(src+24)%24;
            //if(src<12)return false;
        }else return false;
    }
    if(dst<0){
        if(now_player==1){
            dst=(dst+24)%24;
            if(dst<12)return at_home;
        }else
            return at_home;
    }

//        if(now_player==1){
//            if(src>11&&dst<=11)return at_home;
//        }
    if(get_count(dst)>0)
        return now_player==get_color(dst);
    else
        return true;
}
function calculate_moves_old(){


    var movies=[[],[],[],[]];
    var chk_home=chk_at_home();
    for(var i=23;i>=0;i--){
        if(take_head==0)
        if(now_player==1){
            if(i==11)continue;
        }else{
            if(i==23)continue;
        }
        if(get_count(i)>0&&get_color(i)==now_player){
            if(can_turn(i,i-dice_rol[0])){
                if(can_turn(i-dice_rol[0],i-dice_rol[0]-dice_rol[1])){
                    movies[1].push({src:i,dst:(24+i-dice_rol[0]-dice_rol[1])%24});
                    if(turns>2&&can_turn(i-dice_rol[0]-dice_rol[1],i-dice_rol[0]-dice_rol[1]-dice_rol[2])){
                        movies[2].push({src:i,dst:(24+i-dice_rol[0]-dice_rol[1]-dice_rol[2])%24});
                        if(turns==4&&can_turn(i-dice_rol[0]-dice_rol[1]-dice_rol[2],i-dice_rol[0]-dice_rol[1]-dice_rol[2]-dice_rol[3])){
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
                movies[0].push({src:i,dst:(24+i-dice_rol[1])%24});
            }
            /*if(chk_home){
                if((i-11*now_player)-dice_rol[0]<0){
                    if((i-11*now_player)-dice_rol[0]-dice_rol[1]<0&&can_turn(i,i-dice_rol[0])){
                        if((i-11*now_player)-dice_rol[0]-dice_rol[1]-dice_rol[2]<0&&can_turn(i,i-dice_rol[0]-dice_rol[1])){
                            if((i-11*now_player)-dice_rol[0]-dice_rol[1]-dice_rol[2]-dice_rol[3]<0){
                                movies[3].push({src:i,dst:25+now_player});
                            }
                            movies[2].push({src:i,dst:25+now_player});
                        }
                        movies[1].push({src:i,dst:25+now_player});
                    }
                    movies[0].push({src:i,dst:25+now_player});
                }
                if((i-11*now_player)-dice_rol[1]<0){
                    movies[0].push({src:i,dst:25+now_player});
                }
            }*/
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

    /*var clean=false;
    for(i=3;i>=0;i--){
        if(clean){
            movies[i]=[];
            continue;
        }
        if(movies[i]&&movies[i].length>0){
            clean=true;
            continue;
        }
    }*/

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
function make_turn2(src, dst){
    //console.log("Game make_turn logic_state:",logic_state,src,"->",dst);
    if(logic_state<5||logic_state>8)return;
    if(!can_drop_fishka(src,dst))return;
    if(src==dst)return;
    //console.log("Game make_turn:",src,"->",dst,now_player==0?"white[0]":"black[1]");
    var tmp=game_fild_array
    tmp[src].count=tmp[src].count-1
    game_fild_array=tmp


    if(!isRemoveTurn(src,dst)){ // шаг
        tmp[dst].count=tmp[dst].count+1
        tmp[dst].color=now_player
        game_fild_array=tmp
    }else{ // выброс шашки
        if(now_player)
            black_home++
        else
            white_home++;
        console.log("Game make_turn need remove fiska");
    }

    drag_row_index=-1;

    tmp=dice_rol

    // берём с головы
    if(src==23&&now_player==0){
        take_head--;
//            if(take_head==0){
//                removeTurnsBySrc(23);
//            }
    }
    if(src==11&&now_player==1){
        take_head--;
//            if(take_head==0){
//                removeTurnsBySrc(11);
//            }
    }

    // проверяем ходы

    var dt=(src+24-dst)%24;
    console.log("Game make_turn",src,"->",dst,dt,"dice_rol",dice_rol,"dice1_val",dice1_val,"dice2_val",dice2_val);
    var new_logic_state=logic_state;
    for(var i=turns;i>0;i--){
        if(dt>=tmp[i-1]){//||(dst==26&&(src+24-tmp[i-1])%24<=11)||(dst==25&&(src+24-tmp[i-1])%24<=23)
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
            new_logic_state++;
        }
    }

//        var movies=[[],[],[],[]];
//        for(var i=0;i<turns;i++){
//            if(available_turns[i])
//                for(var j=0;j<available_turns[i].length;j++){
//                    movies[i].push(available_turns[i][j]);
//                }
//        }
//        available_turns=movies;

    console.log("Game make_turn correct dices",dice_rol,"dice1_val",dice1_val,"dice2_val",dice2_val,"dt",dt,"turns",turns,"take_head",take_head);
    if(tmp[0]==0&&tmp[1]>0){tmp[0]=tmp[1];tmp[1]=0;}
    dice_rol=tmp;
    if(dst!=src)calculate_moves();

    // завершен ли ход
    if(chk_end_turn()){
        //if(now_player==1)
        turn++;
        now_player=!now_player
        tmp[0]=tmp[1]=tmp[2]=tmp[3]=0;
        dice_rol=tmp;
        GLCode.hide_dice1();
        GLCode.hide_dice2();
        new_logic_state=3;
        if(black_home==15){
            console.log("Game END Black Win");
            new_logic_state=21;
        }
        if(white_home==15){
            console.log("Game END Black Win");
            new_logic_state=20;
        }
        console.log("End make_turn",now_player,turn,new_logic_state);
    }else{
        console.log("Turn NOT Ended",now_player,turn,new_logic_state,dice_rol);
    }

    logic_state=new_logic_state;
}
function can_drop_fishka(src, dst){
    if(logic_state<5||logic_state>8)return false;
    if(src<0)return false;

    for(var i=0;i<available_turns.length;i++){
        if(available_turns[i].pos1==src&&available_turns[i].pos2==dst)return true;
    }

//        if(get_count(dst)>0&&get_color(src)!=get_color(dst))return false;
//        if(get_color(src)!=now_player||get_count(src)==0)return false;
//        if(src==dst)return true;

//        for(var i=0;i<4;i++){
//            if(available_turns[i])
//                for(var j=0;j<available_turns[i].length;j++){
//                    if(available_turns[i][j].src==src&&available_turns[i][j].dst==dst)return true;
//                }
//        }
    return false;
}


/*ListsDelegate{
    id:black_game
    y: 280
    index: 0
    model: getGameList(player_menu.index);
}
ListsDelegate{
    id:chess_game
    y: 280
    index: 1
    model: getGameList(player_menu.index);
}
ListsDelegate{
    id:shah_game
    y: 280
    index: 2
    model: getGameList(player_menu.index);
}*/

/*Flow {
    id: gameGridView
    x: 99
    y: 280
    width: 440
    height: 50
    anchors.horizontalCenter: parent.horizontalCenter
    Repeater{
        id:gameRepView
        model: getGameList(player_menu.index);
        delegate:ListsDelegate{
            //width: 220
            //height: 64
            parentmodel: getGameList(player_menu.index);
        }
    }
}*/

Flow {
    id: typeGridView
    x: 99
    width: 440
    height: 60
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: chess_game.bottom
    anchors.topMargin: 50
    Repeater{
        id:typeRepView
        model: getTypeList(player_menu.index);
        delegate:ListsDelegate{
            model: getTypeList(player_menu.index);
        }
    }
}

Rectangle {
    id: rectangle2
    x: 403
    y: 553
    width: 137
    height: 52
    radius: 3
    Text {
        id: text8
        color: "#c69c6d"
        text: qsTr("ДОП ОПЦИИ >")
        font.pixelSize: 28
        renderType: Text.NativeRendering
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        font.family: "Myriad Pro"
    }

    MouseArea {
        id: mouseArea7
        anchors.fill: parent
        enabled: player_menu3.opacity==1
        onClicked: {
            if(player_menu.state=="menu3")
                player_menu.state="menu4"
            else
                player_menu.state="menu3"
        }
    }
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#623113"
        }

        GradientStop {
            position: 1
            color: "#321405"
        }
    }
    border.width: 0
}

Flow {
    id: timeGridView
    enabled: opacity==1
    width: 440
    height: 118
    Repeater {
        id: timeRepView
        model: getTimeList(player_menu.index)
        ListsDelegate {
            model: getTimeList(player_menu.index)
        }
    }
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: 48
    anchors.top: typeGridView.bottom
}
TabView {
    id: options
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: 20
    anchors.top: timeGridView.bottom
    width: 440
    height: 194
    enabled: opacity==1
    Tab {
        title: "ОФОРМЛЕНИЕ"

        Flow {
            id: styleGridView
            width: 440
            height: 64
            Repeater {
                id: styleRepView
                model: getStyleList(player_menu.index)
                ListsDelegate {
                    model: getStyleList(player_menu.index)
                }
            }
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
        }
    }
    Tab {
        title: "ПРАВИЛА"
    }
    Tab {
        title: "МОЙ КАБИНЕТ"
    }
    style: TabViewStyle {
        frameOverlap: 5
        frame: Rectangle {
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#623113"
                }

                GradientStop {
                    position: 1
                    color: "#321405"
                }
            }
            radius: 15
        }
        tab: Rectangle {
            color: "transparent"//styleData.selected ? "steelblue" :"lightsteelblue"
            //border.color:  "steelblue"
            implicitWidth: 146
            implicitHeight: 45
            Rectangle{
                //color: "#e6e7e8"
                opacity: styleData.selected ? 1.0 :0.5
                radius: 10
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#623113"
                    }

                    GradientStop {
                        position: 1
                        color: "#321405"
                    }
                }
            }
            Text {
                text: styleData.title
                font.bold: true
                color: "#c69c6d"
                fontSizeMode: Text.Fit
                font.pixelSize: 25
                anchors.fill: parent
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                font.family: "Myriad Pro"
                //color: styleData.selected ? "white" : "black"
            }
        }
    }
}
/*Process{
    property int p_state: 0
    property string output: ""
    property int touch_1: -1
    property int touch_2: -1
    property string output_1: ""
    property string output_2: ""
    property int heigth: 1080;

    id:calibration_process
    onReadyRead: {
        output+=readAll();
    }

    onFinished: {

        if(output.length==0&&p_state<2){
            console.log("Calibration falid at state:"+p_state)
            heigth=1080;
            //mainIndex.source="Index1x.qml"
            mainMenu.source="menu1x_test.qml"
            return;
        }
        if(p_state==0){
            var touchs=output.split('\n')
            console.log("Detect "+(touchs.length-1)+" touchscreens:"+touchs)
            if(touchs.length>0)
                touch_1=parseInt(touchs[0].split('=')[1])
            if(touchs.length>1&&touchs[1].length>0)
                touch_2=parseInt(touchs[1].split('=')[1])
            p_state=1
            output="";
            calibration_process.start("bash",["-c","xrandr | grep ' connected' | cut -d ' ' -f 1"])
            return;
        }
        if(p_state==1){
            var outputs=output.split('\n')
            console.log("Detect "+(outputs.length-1)+" outputs:"+outputs)
            if(outputs.length>0)
                output_1=outputs[0]
            if(outputs.length>1&&outputs[1].length>0)
                output_2=outputs[1]
            p_state=2;
            output="";
            if(outputs.length-1==1){
                heigth=1080;
            }
            if(outputs.length-1==2){
                heigth=2160;
            }
            console.log("mapping touch:"+touch_1+" to monitor:"+output_1)
            calibration_process.start("xinput",["--map-to-output",touch_1,output_1])
            return;
        }
        if(p_state==2){
            p_state=3
            output=""
            console.log("calibration touch:"+touch_1)
            calibration_process.start("xinput",["set-int-prop",touch_1,"Evdev Axis Calibration","32","1581","398","642","1330"])
            return;
        }
        if(p_state==3){
            p_state=4
            output=""
            console.log("calibration swap touch:"+touch_1)
            calibration_process.start("xinput",["set-int-prop",touch_1,"Evdev Axes Swap","8","0"])
            return;
        }

        if(p_state==4&&touch_2>=0&&output_2.length>0){
            p_state=5
            output=""
            console.log("xinput mapping touch:"+touch_2+" to monitor:"+output_2)
            calibration_process.start("xinput",["--map-to-output",touch_2,output_2])
            return;
        }
        if(p_state==5&&touch_2>=0){
            p_state=6
            output=""
            console.log("xinput calibration touch:"+touch_2)
            calibration_process.start("xinput",["set-int-prop",touch_2,"Evdev Axis Calibration","32","1581","398","642","1330"])
            return;
        }
        if(p_state==6&&touch_2>=0){
            p_state=7
            output=""
            console.log("xinput calibration swap touch:"+touch_2)
            calibration_process.start("xinput",["set-int-prop",touch_2,"Evdev Axes Swap","8","0"])
            return;
        }

        heigth=1080;
        mainMenu.source="menu1x_test.qml"
        //mainIndex


        //mainIndex.source="menu2x.qml"
        console.log(output);
    }
}*/
import QtQuick 2.0
import "gl_logic.js" as GLCode
import "backgammon_logic.js" as Game

Item {
    id: cube
    //property bool showdrop: false
//    property int logic_state: 0

//    property bool orientation: false

//    property double gl_axis_y: 1.8
//    property double gl_axis_x: 1.8

//    property double phy_axis_y1: 1.8
//    property double phy_axis_y2: 1.8
//    property double phy_axis_x: 1.8


//    property bool gl_ready: false
//    property bool logic_ready: false
//    property bool dice_ready: false
//    property bool fiska_ready: false

//    Text{
//        id:label_drop
//        text: "PRESS FOR DROP DICE"
//        font.bold:true
//        font.pointSize:24
//        visible: Game.logic_state==3&&!GLCode.showdrop
//        opacity: 0
//        anchors.centerIn: parent
//        anchors.horizontalCenterOffset: (1-Game.now_player*2)*parent.width/4
//        SequentialAnimation{

//            loops: Animation.Infinite
//            running: label_drop.visible
//            NumberAnimation {
//                target: label_drop
//                property: "opacity"
//                duration: 1500
//                to:1
//                easing.type: Easing.Linear
//                alwaysRunToEnd:true
//            }
//            NumberAnimation {
//                target: label_drop
//                property: "opacity"
//                duration: 1500
//                to:0
//                easing.type: Easing.Linear
//                alwaysRunToEnd:true
//            }
//        }
//    }
    MouseArea{
        property var drop_start: null
        anchors.fill: parent
        enabled: Game.logic_state==3
        onClicked: {
            //if(!showdrop)GLCode.dropDice();
            //            showdrop=!showdrop
        }
        onPressed: {
            console.log("Game state:",Game.logic_state,mouse.x,mouse.y,width/2,Game.now_player);
            if(GLCode.showdrop)return;
            drop_start=null;
            if(Game.now_player){
                if(mouse.x>width/2)return;
            }else{
                if(mouse.x<=width/2)return;
            }
            if(Game.now_player==0){
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
            if(GLCode.showdrop)return;
            if(!drop_start)return;
            var vector = { x: mouseX - drop_start.x, y: mouseY - drop_start.y };
            vector = translateToCanvas(mouse.x,mouse.y);
            var vector_start = drop_start;//{ x: drop_start.x/width, y: drop_start.y/height };
            drop_start = null;
            var dist = Math.sqrt(vector.x * vector.x + vector.y * vector.y);
            //vector.x /= dist; vector.y /= dist;
            console.log("Game state:",Game.logic_state,mouse.x,mouse.y);
            console.log("vector",vector.x,vector.y);
            console.log("vector_start",vector_start.x,vector_start.y);
            Game.dice_rol=[0,0];
            GLCode.dropDice(vector,vector_start);

            drop_finish_chk_timer.start();
        }
    }


//    Timer{
//        id:drop_finish_chk_timer
//        running: false
//        repeat: true
//        interval: 1500
//        onTriggered: {
//            GLCode.showdrop=running=!GLCode.is_throw_finished();
//            if(GLCode.showdrop)
//                interval/=2.0
//            else{
//                interval=1500;
//                Game.set_dice(GLCode.get_dice());
//            }
//            if(interval<100)interval=150;
//            console.log("drop_finish_chk_timer",running,interval);
//        }
//    }

//    function get3dObj(player){
//        if(GLCode.fishkas_obj.length>0){
//            for(var i=0;i<GLCode.fishkas_obj.length;i++){
//                if(GLCode.fishkas_obj[i].color==player){
//                    var ret=GLCode.fishkas_obj[i];
//                    GLCode.fishkas_obj.splice(i, 1);
//                    return ret;
//                }
//            }
//        }
//        return null;
//    }

//    Component.onCompleted: {

//    }

//    property double op_dice1: 1
//    property double op_dice2: 1

//    NumberAnimation {
//        id:op_dice1_anim
//        target: GLCode
//        property: "op_dice1"
//        duration: 500
//        from:1
//        to:0.5
//        easing.type: Easing.Linear
//        onStopped: {
//            //GLCode.hide_dice1();
//        }
//    }
//    NumberAnimation {
//        id:op_dice2_anim
//        target: GLCode
//        property: "op_dice2"
//        duration: 500
//        from:1
//        to:0.5
//        easing.type: Easing.Linear
//        onStopped: {
//            //GLCode.hide_dice2();
//        }
//    }
    //    Behavior on op_dice1{
    //        NumberAnimation { from:1;to:0;duration: 500 }
    //        NumberAnimation { from:0;to:1;duration: 0 }
    //    }
    //    Behavior on op_dice2{
    //        NumberAnimation { from:1;to:0;duration: 500 }
    //        NumberAnimation { from:0;to:1;duration: 0 }
    //    }
}
