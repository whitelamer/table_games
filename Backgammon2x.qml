//import QtQuick 2.0
//import QtCanvas3D 1.0
import QtGraphicalEffects 1.0
import QtQuick 2.2


Item {
    id:main_form
    width: 1920
    height: 2160
    GameLogic{
        id:gameLogic
    }
    anchors.fill: parent
    property alias gamestate: gameLogic.state
    property alias nowplayer: gameLogic.now_player
    property QtObject drag_item: null
    property bool drag_need_resume: false
    property int main_spacing: 40
    signal updateAfterDrop(int src, int dst)
    MouseArea{
        id:global_area
        anchors.fill: parent
        onPositionChanged: {
            if(main_form.drag_item!=null&&main_form.drag_need_resume==true){
                var point=main_form.mapToItem(main_form.drag_item.parent,mouse.x,mouse.y)
                main_form.drag_item.x=point.x-48
                main_form.drag_item.y=point.y-48
            }
        }
        onClicked: {
            if(gameLogic.get_state()==3){
                gameLogic.drop_dice();
                //drop_anim.start();
                drop_timer.start();
            }
            if(gameLogic.get_state()==5){
                //console.log(main_form.childAt(main_form.drag_item.x+48,main_form.drag_item.y+48))
            }
        }
    }
    onUpdateAfterDrop: {
        console.log("main_form updateAfterDrop")
    }

    Image {
        width: 1920
        height: 1080
        fillMode: Image.PreserveAspectCrop
        clip:false
        id: background
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        source:"./img/fon_1_B.png"
    }

    Image {
        width: 1920
        height: 1080
        fillMode: Image.PreserveAspectCrop
        clip: false
        id: background2
        anchors.top: background.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        source:"./img/fon_1_B.png"
    }

    Column{
        spacing: main_spacing
        anchors.top: parent.top
        anchors.topMargin: 122
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
        anchors.left: parent.left
        anchors.leftMargin: 0
        Repeater{
            property int align_rows: Qt.LeftToRight
            model:6
            delegate:DropAreaDelegate{
                p_ind: 17-index
                layoutDirection: Qt.LeftToRight
            }
        }
    }
    Column{
        spacing: main_spacing
        anchors.top: parent.top
        anchors.topMargin: 122
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
        anchors.right: parent.right
        anchors.rightMargin: 0
        Repeater{
            property int align_rows: Qt.RightToLeft
            model:6
            delegate:DropAreaDelegate{
                p_ind: 6+index
                layoutDirection: Qt.RightToLeft
            }
        }
    }
    Column{
        spacing: main_spacing
        anchors.top: background.bottom
        anchors.topMargin: 122
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
        anchors.left: parent.left
        anchors.leftMargin: 0
        Repeater{
            property int align_rows: Qt.LeftToRight
            model:6
            delegate:DropAreaDelegate{
                p_ind: index
                layoutDirection: Qt.LeftToRight
            }
        }
    }
    Column{
        spacing: main_spacing
        anchors.top: background.bottom
        anchors.topMargin: 122
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
        anchors.right: parent.right
        anchors.rightMargin: 0
        Repeater{
            property int align_rows: Qt.RightToLeft
            model:6
            delegate:DropAreaDelegate{
                p_ind: 23-index
                layoutDirection: Qt.RightToLeft
            }
        }
    }

    Column{
        spacing: main_spacing
        anchors.top: parent.top
        anchors.topMargin: 122
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
        anchors.left: parent.left
        anchors.leftMargin: 0
        Repeater{
            property int align_rows: Qt.LeftToRight
            model:6
            delegate:DragFishkaDelegate{
                p_ind: 17-index
                layoutDirection: Qt.LeftToRight
            }
        }
    }
    Column{
        spacing: main_spacing
        anchors.top: parent.top
        anchors.topMargin: 122
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
        anchors.right: parent.right
        anchors.rightMargin: 0
        Repeater{
            property int align_rows: Qt.RightToLeft
            model:6
            delegate:DragFishkaDelegate{
                p_ind: 6+index
                layoutDirection: Qt.RightToLeft
            }
        }
    }
    Column{
        spacing: main_spacing
        anchors.top: background.bottom
        anchors.topMargin: 122
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
        anchors.left: parent.left
        anchors.leftMargin: 0
        Repeater{
            property int align_rows: Qt.LeftToRight
            model:6
            delegate:DragFishkaDelegate{
                p_ind: index
                layoutDirection: Qt.LeftToRight
            }
        }
    }
    Column{
        spacing: main_spacing
        anchors.top: background.bottom
        anchors.topMargin: 122
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
        anchors.right: parent.right
        anchors.rightMargin: 0
        Repeater{
            property int align_rows: Qt.RightToLeft
            model:6
            delegate:DragFishkaDelegate{
                p_ind: 23-index
                layoutDirection: Qt.RightToLeft
            }
        }
    }
    ///////////////////////////////////////////////////////////////////
    ImageCube {
        id: imageCube
//        x: 108
//        y: 92
//        Rectangle {
//            id: rectangle
//            anchors.fill: parent
//            color: "#ffffff"
//        }
        width: 1700
        height: 887
        anchors.centerIn: gameLogic.now_player==1?background:background2
        visible: true
//        state: "image1"
//        image1: "img/cube1.png"
//        image2: "img/cube2.png"
//        image3: "img/cube3.png"
//        image4: "img/cube4.png"
//        image5: "img/cube5.png"
//        image6: "img/cube6.png"
    }
//    NumberAnimation {
//        id: drop_anim
//        targets: [imageCube]
//        property: "scale"
//        duration: 3000
//        from: 1
//        to:0.8
//        easing.type: Easing.OutBounce
//    }
//    ImageCube {
//        id: imageCube2
//        width: 250
//        height: 250
//        anchors.centerIn: gameLogic.now_player==1?background:background2
//        anchors.verticalCenterOffset: 75
//        anchors.horizontalCenterOffset: -15
//        visible: true
//        state: "image1"
//        image1: "img/cube1.png"
//        image2: "img/cube2.png"
//        image3: "img/cube3.png"
//        image4: "img/cube4.png"
//        image5: "img/cube5.png"
//        image6: "img/cube6.png"
//    }
    Timer{
        id:drop_timer
        running: false
        interval: 500
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            imageCube.setState1("image"+gameLogic.get_dice(0));
            imageCube.setState2("image"+gameLogic.get_dice(1));

            //gameLogic.get_dice(1);

            //console.log(imageCube.state);
            //main_form.gamestate=gameLogic.state
            //main_form.nowplayer=gameLogic.now_player
        }
    }
//    Component.onCompleted: {
//        gameLogic.init();
//    }
    focus: true

    Keys.onPressed:{
        console.log("Keys.onPressed:"+event.key);
        if(event.key==Qt.Key_Escape)Qt.quit();
        if(event.key==Qt.Key_S)showService();
    }
}
