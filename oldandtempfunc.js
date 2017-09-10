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
