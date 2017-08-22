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
