import QtQuick 2.0

Item {
    id:main_form
    property int main_spacing: 17
    property int fiska_size: 61
    property QtObject gameLogic: gameLogic
    property QtObject drag_item: null
    property int gamestate: gameLogic.logic_state
    property alias nowplayer: gameLogic.now_player
    property bool drag_need_resume: false
    signal updateAfterDrop(int src, int dst)
    signal newgamestate(int state)
    width: 1920
    height: 1080
    Image {
        id: background
        width: 1280
        height: 1024
        fillMode: Image.PreserveAspectFit
        source:"./img/fone1280x1024.png"
        MouseArea{
            id:global_area
            anchors.fill: parent
            enabled: gameLogic.get_state()!=3
            onPositionChanged: {
                if(main_form.drag_item!=null&&main_form.drag_need_resume==true){
                    var point=main_form.mapToItem(main_form.drag_item.parent,mouse.x,mouse.y)
                    main_form.drag_item.x=point.x-fiska_size*.5
                    main_form.drag_item.y=point.y-fiska_size*.5
                }
            }
            onClicked: {
                if(gameLogic.get_state()==5){
                    //console.log(main_form.childAt(main_form.drag_item.x+48,main_form.drag_item.y+48))
                }
            }
        }
        Row{
            spacing: main_spacing
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 95
            layoutDirection: Qt.RightToLeft
            Repeater{
                model:6
                delegate:DropAreaDelegate_Column{
                    //fiska_size: 61
                    p_ind: 17-index
                }
            }
        }
        Row{
            spacing: main_spacing
            layoutDirection: Qt.RightToLeft
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            anchors.left: parent.left
            anchors.leftMargin: 95
            Repeater{
                //property int align_rows: Qt.RightToLeft
                //rotation: 180
                model:6
                delegate:DropAreaDelegate_Column{
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    rotation: 180
                    //fiska_size: 61
                    p_ind: 6+index
                }
            }
        }
        Row{
            layoutDirection: Qt.RightToLeft
            spacing: main_spacing
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 95
            Repeater{
                property int align_rows: Qt.LeftToRight
                model:6
                delegate:DropAreaDelegate_Column{
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    rotation: 180
                    //fiska_size: 61
                    p_ind: index
                }
            }
        }
        Row{
            layoutDirection: Qt.RightToLeft
            spacing: main_spacing
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 95
            Repeater{
                model:6
                delegate:DropAreaDelegate_Column{
                    //fiska_size: 61
                    p_ind: 23-index
                }
            }
        }

        Row{
            spacing: main_spacing
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 95
            layoutDirection: Qt.RightToLeft
            Repeater{
                model:6
                delegate:DragFishkaDelegate_Column{
                    image_white: "1w_+++.png"
                    image_black: "1b_+++.png"
                    //fiska_size: 61
                    p_ind: 17-index
                    //layoutDirection: Qt.LeftToRight
                }
            }
        }
        Row{
            //LayoutMirroring.enabled: true
            layoutDirection: Qt.RightToLeft
            spacing: main_spacing
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            anchors.left: parent.left
            anchors.leftMargin: 95
            Repeater{
                model:6
                delegate:DragFishkaDelegate_Column{
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    rotation: 180
                    image_white: "1w_+++.png"
                    image_black: "1b_+++.png"
                    //fiska_size: 61
                    p_ind: 6+index
                    //layoutDirection: Qt.RightToLeft
                }
            }
        }
        Row{
            layoutDirection: Qt.RightToLeft
            spacing: main_spacing
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 95
            Repeater{
                model:6
                delegate:DragFishkaDelegate_Column{
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    rotation: 180
                    image_white: "1w_+++.png"
                    image_black: "1b_+++.png"
                    //fiska_size: 61
                    p_ind: index
                    //layoutDirection: Qt.LeftToRight
                }
            }
        }
        Row{
            layoutDirection: Qt.RightToLeft
            spacing: main_spacing
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 95
            Repeater{
                property int align_rows: Qt.RightToLeft
                model:6
                delegate:DragFishkaDelegate_Column{
                    image_white: "1w_+++.png"
                    image_black: "1b_+++.png"
                    //fiska_size: 61
                    p_ind: 23-index
                    //layoutDirection: Qt.RightToLeft
                }
            }
        }

        ImageCube {
            id: gameLogic
            width: 502
            height: 940
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: gameLogic.now_player==1?-320:320
            //        anchors.horizontalCenterOffset: 320

            visible: true
            onLogic_stateChanged: {
                console.log("onLogic_stateChanged");
                main_form.gamestate=gameLogic.logic_state
                newgamestate(main_form.gamestate)
            }
        }
    }
}
