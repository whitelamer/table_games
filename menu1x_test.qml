import QtQuick 2.0

Item {
    property int main_user: 0
    property int second_user: 0
    property int board_mode: 0
    property int main_balance: 0
    property int second_balance: 0
    id: item1
    width: 1280
    height: 1024

    Menu1x_ {
        id: menu1x_1
        rotation: 180
        index:1
    }

    Menu1x_ {
        id: menu1x_2
        y: 0
        anchors.left: menu1x_1.right
        anchors.leftMargin: 0
        index:2
    }
    ListModel {
        id:mainGameList
        function setSelected(ind){
            for(var i=0;i<this.count;i++){
                this.set(i,{"selected":false})
                secondGameList.set(i,{"enable":false,"selected":false})
            }
            this.set(ind,{"selected":true});
            secondGameList.set(ind,{"enable":false,"selected":true})
        }

        ListElement {
            num: 1
            selected:false
            img: "img/menu/n.png"
            img_: "img/menu/n_.png"
            caption:""
            enable:true
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/shs.png"
            img_: "img/menu/shs_.png"
            caption:""
            enable:true
        }

        ListElement {
            num: 3
            selected:false
            img: "img/menu/sh.png"
            img_: "img/menu/sh_.png"
            caption:""
            enable:true
        }
    }
    ListModel {
        id:secondGameList
        function setSelected(ind){

        }
        ListElement {
            num: 1
            selected:false
            img: "img/menu/n.png"
            img_: "img/menu/n_.png"
            caption:""
            enable:false
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/shs.png"
            img_: "img/menu/shs_.png"
            caption:""
            enable:false
        }

        ListElement {
            num: 3
            selected:false
            img: "img/menu/sh.png"
            img_: "img/menu/sh_.png"
            caption:""
            enable:false
        }
    }

    ListModel {
        id:mainGameTypeList
        function setSelected(ind){
            for(var i=0;i<this.count;i++){
                this.set(i,{"selected":false})
                secondGameTypeList.set(i,{"enable":false,"selected":false})
            }
            this.set(ind,{"selected":true});
            secondGameTypeList.set(ind,{"enable":false,"selected":true})
        }
        ListElement {
            num: 1
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"ТРЕНИРОВКА"
            enable:true
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"МАТЧ"
            enable:true
        }
    }
    ListModel {
        id:secondGameTypeList
        function setSelected(ind){

        }
        ListElement {
            num: 1
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"ТРЕНИРОВКА"
            enable:false
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"МАТЧ"
            enable:false
        }
    }

    ListModel {
        id:mainGameTimeList
        function setSelected(ind){
            for(var i=0;i<this.count;i++){
                this.set(i,{"selected":false})
                secondGameTimeList.set(i,{"enable":false,"selected":false})
            }
            this.set(ind,{"selected":true});
            secondGameTimeList.set(ind,{"enable":false,"selected":true})
        }
        ListElement {
            num: 1
            selected:false
            img: "img/menu/15.png"
            img_: "img/menu/btn_.png"
            caption:"15\n500"
            enable:true
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/30.png"
            img_: "img/menu/btn_.png"
            caption:"30\n1000"
            enable:true
        }
        ListElement {
            num: 3
            selected:false
            img: "img/menu/45.png"
            img_: "img/menu/btn_.png"
            caption:"45\n1500"
            enable:true
        }
        ListElement {
            num: 4
            selected:false
            img: "img/menu/60.png"
            img_: "img/menu/btn_.png"
            caption:"30\n2000"
            enable:true
        }
        ListElement {
            num: 5
            selected:false
            img: "img/menu/00.png"
            img_: "img/menu/btn_.png"
            caption:"∞\n10000"
            enable:true
        }
    }

    ListModel {
        id:secondGameTimeList
        function setSelected(ind){

        }
        ListElement {
            num: 1
            selected:false
            img: "img/menu/15.png"
            img_: "img/menu/btn_.png"
            caption:"15\n500"
            enable:false
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/30.png"
            img_: "img/menu/btn_.png"
            caption:"30\n1000"
            enable:false
        }
        ListElement {
            num: 3
            selected:false
            img: "img/menu/45.png"
            img_: "img/menu/btn_.png"
            caption:"45\n1500"
            enable:false
        }
        ListElement {
            num: 4
            selected:false
            img: "img/menu/60.png"
            img_: "img/menu/btn_.png"
            caption:"30\n2000"
            enable:false
        }
        ListElement {
            num: 5
            selected:false
            img: "img/menu/00.png"
            img_: "img/menu/btn_.png"
            caption:"∞\n10000"
            enable:false
        }
    }

    ListModel {
        id:mainGameStyleList
        function setSelected(ind){
            for(var i=0;i<this.count;i++){
                this.set(i,{"selected":false})
                secondGameStyleList.set(i,{"enable":false,"selected":false})
            }
            this.set(ind,{"selected":true});
            secondGameStyleList.set(ind,{"enable":false,"selected":true})
        }
        ListElement {
            num: 1
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"ДЕРЕВО"
            enable:true
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"КАМЕНЬ"
            enable:true
        }

        ListElement {
            num: 3
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"МЕТАЛЛ"
            enable:true
        }
    }
    ListModel {
        id:secondGameStyleList
        function setSelected(ind){

        }
        ListElement {
            num: 1
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"ДЕРЕВО"
            enable:false
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"КАМЕНЬ"
            enable:false
        }

        ListElement {
            num: 3
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"МЕТАЛЛ"
            enable:false
        }
    }
    function setGemeboardMode(mode){
        board_mode=mode;
        if(mode==1){
            menu1x_1.state="menu2"
            menu1x_2.state="menu2"
            second_user=3-main_user;
        }
    }
    function generateUUID () { // Public Domain/MIT
        var d = new Date().getTime();
        if (typeof performance !== 'undefined' && typeof performance.now === 'function'){
            d += performance.now(); //use high-precision timer if available
        }
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = (d + Math.random() * 16) % 16 | 0;
            d = Math.floor(d / 16);
            return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
        });
    }

    function userLogin(ind,name){
        if(ind==1)menu1x_1.user_name=name
        if(ind==2)menu1x_2.user_name=name
        if(board_mode==1){
            if(main_user==ind){

                console.time('t');
                console.log(generateUUID());
                console.timeEnd('t');
            }
        }
    }
    function have_player(ind){
        if(main_user==0){
            //TODO: clean lists
            main_user=ind;
        }else
            second_user=ind;
    }
    function leave_player(ind){
        if(main_user==ind){
            if(second_user!=0){
                main_user=second_user;
                second_user=0;
                for(var i=0;i<mainGameList.count;i++){
                    mainGameList.set(i,{"selected":secondGameList.get(i).selected})
                    secondGameList.set(i,{"enable":false,"selected":false})
                }
                for(var i=0;i<mainGameTypeList.count;i++){
                    mainGameTypeList.set(i,{"selected":secondGameTypeList.get(i).selected})
                    secondGameTypeList.set(i,{"enable":false,"selected":false})
                }
                for(var i=0;i<mainGameTimeList.count;i++){
                    mainGameTimeList.set(i,{"selected":secondGameTimeList.get(i).selected})
                    secondGameTimeList.set(i,{"enable":false,"selected":false})
                }
                for(var i=0;i<mainGameStyleList.count;i++){
                    mainGameStyleList.set(i,{"selected":secondGameStyleList.get(i).selected})
                    secondGameStyleList.set(i,{"enable":false,"selected":false})
                }
                listUpdated();
            }else{
                main_user=0;
                board_mode=0;
            }
        }else{
            second_user=0;
            board_mode=0;
        }
    }
    function listUpdated(){
        for(var i=0;i<mainGameList.count;i++){
            secondGameList.set(i,{"enable":mainGameList.get(i).selected})
        }
        for(var i=0;i<mainGameTypeList.count;i++){
            secondGameTypeList.set(i,{"enable":mainGameTypeList.get(i).selected})
        }
        for(var i=0;i<mainGameTimeList.count;i++){
            secondGameTimeList.set(i,{"enable":mainGameTimeList.get(i).selected})
        }
        for(var i=0;i<mainGameStyleList.count;i++){
            secondGameStyleList.set(i,{"enable":mainGameStyleList.get(i).selected})
        }
        menu1x_1.updateList()
        menu1x_2.updateList()
    }
    function getGameList(ind){
        if(main_user==ind){
            return mainGameList;
        }else{
            return secondGameList;
        }
    }
    function getTypeList(ind){
        if(main_user==ind){
            return mainGameTypeList;
        }else{
            return secondGameTypeList;
        }
    }
    function getTimeList(ind){
        if(main_user==ind){
            return mainGameTimeList;
        }else{
            return secondGameTimeList;
        }
    }
    function getStyleList(ind){
        if(main_user==ind){
            return mainGameStyleList;
        }else{
            return secondGameStyleList;
        }
    }
}
