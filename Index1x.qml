import QtQuick 2.0

Item {
    id:main_form
    property int main_spacing: 17
    property int fiska_size: 61
    property QtObject gameLogic: gameLogic
    property int fishka_count: 0
    property var drag_item: null
    property variant drop_areas: []
    property variant drag_fishkas: []
    property variant fishka_c: null
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
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent
            //enabled: gameLogic.get_state()!=3
            onPositionChanged: {
                if(main_form.drag_item!=null&&main_form.drag_need_resume==true){
                    var point=main_form.mapToItem(main_form.drag_item.parent,mouse.x,mouse.y)
                    main_form.drag_item.x=point.x-fiska_size*.5
                    main_form.drag_item.y=point.y-fiska_size*.5
                }
                gameLogic.setFishkaPos(gameLogic.translateToCanvas(mouse.x,mouse.y),0);
            }
            onClicked: {
                if(gameLogic.get_state()==5){
                    //console.log(main_form.childAt(main_form.drag_item.x+48,main_form.drag_item.y+48))
                }
            }
        }
        /*Row{
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
                    Component.onCompleted: {
                        console.log("DropAreaDelegate_Column",p_ind)
                        var tmp=drop_areas;
                        tmp[p_ind]=this;
                        drop_areas=tmp;
                createFishkas(p_ind);
                    }
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
                    Component.onCompleted: {
                        console.log("DropAreaDelegate_Column",p_ind)
                        var tmp=drop_areas;
                        tmp[p_ind]=this;
                        drop_areas=tmp;
                createFishkas(p_ind);
                    }
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
                    Component.onCompleted: {
                        console.log("DropAreaDelegate_Column",p_ind)
                        var tmp=drop_areas;
                        tmp[p_ind]=this;
                        drop_areas=tmp;
                createFishkas(p_ind);
                    }
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
                    Component.onCompleted: {
                        console.log("DropAreaDelegate_Column",p_ind)
                        var tmp=drop_areas;
                        tmp[p_ind]=this;
                        drop_areas=tmp;
                createFishkas(p_ind);
                    }
                }
            }
        }*/

        /*Row{
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
        }*/

        Rectangle{
            id: rectangle13
            x: 91
            y: 27
            width: 71
            height: 395
            color:"transparent"
            property int p_ind: 12
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/33.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle14
            x: 168
            y: 27
            width: 71
            height: 295
            color:"transparent"
            property int p_ind: 13
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/22.png"
                }

                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle15
            x: 246
            y: 26
            width: 71
            height: 197
            color:"transparent"
            property int p_ind: 14
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/11.png"
                }

                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle18
            x: 479
            y: 27
            width: 71
            height: 395
            color:"transparent"
            property int p_ind: 17
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/33.png"
                }

                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle17
            x: 402
            y: 27
            width: 71
            height: 295
            color:"transparent"
            property int p_ind: 16
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/22.png"
                }

                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle16
            x: 324
            y: 26
            width: 71
            height: 197
            color:"transparent"
            property int p_ind: 15
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/11.png"
                }

                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle19
            x: 730
            y: 27
            width: 71
            height: 395
            color:"transparent"
            property int p_ind: 18
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/33.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle20
            x: 808
            y: 27
            width: 71
            height: 295
            color:"transparent"
            property int p_ind: 19
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/22.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle22
            x: 964
            y: 26
            width: 71
            height: 197
            color:"transparent"
            property int p_ind: 21
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind);
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/11.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle21
            x: 885
            y: 26
            width: 71
            height: 197
            color:"transparent"
            property int p_ind: 20
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/11.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle24
            x: 1119
            y: 27
            width: 71
            height: 395
            color:"transparent"
            property int p_ind: 23
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/33.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle23
            x: 1041
            y: 27
            width: 71
            height: 295
            color:"transparent"
            property int p_ind: 22
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/22.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle12
            x: 91
            y: 601
            width: 71
            height: 395
            color:"transparent"
            rotation: 180
            property int p_ind: 11
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/33.png"
                }

                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle11
            x: 168
            y: 702
            width: 71
            height: 295
            color:"transparent"
            rotation: 180
            property int p_ind: 10
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/22.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle10
            x: 246
            y: 801
            width: 71
            height: 197
            color:"transparent"
            rotation: 180
            property int p_ind: 9
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/11.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle7
            x: 479
            y: 601
            width: 71
            height: 395
            color:"transparent"
            rotation: 180
            property int p_ind: 6
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/33.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle8
            x: 401
            y: 702
            width: 71
            height: 295
            color:"transparent"
            rotation: 180
            property int p_ind: 7
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/22.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle9
            x: 324
            y: 801
            width: 71
            height: 197
            color:"transparent"
            rotation: 180
            property int p_ind: 8
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/11.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle6
            x: 731
            y: 602
            width: 71
            height: 395
            color:"transparent"
            rotation: 180
            property int p_ind: 5
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/33.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle5
            x: 808
            y: 702
            width: 71
            height: 295
            color:"transparent"
            rotation: 180
            property int p_ind: 4
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/22.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle4
            x: 886
            y: 802
            width: 71
            height: 197
            color:"transparent"
            rotation: 180
            property int p_ind: 3
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/11.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle1
            x: 1119
            y: 601
            width: 71
            height: 395
            color:"transparent"
            rotation: 180
            property int p_ind: 0
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/33.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle2
            x: 1041
            y: 702
            width: 71
            height: 295
            color:"transparent"
            rotation: 180
            property int p_ind: 1
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/22.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        Rectangle {
            id: rectangle3
            x: 964
            y: 801
            width: 71
            height: 197
            color:"transparent"
            rotation: 180
            property int p_ind: 2
            DropArea {
                anchors.fill: parent
                enabled:gameLogic.can_drop_fishka(gameLogic.drag_row_index,parent.p_ind)
                visible:enabled
                Image {
                    opacity: parent.containsDrag?1.0:1.0
                    anchors.fill: parent
                    source: "img/11.png"
                }
                onDropped: {
                    gameLogic.make_turn(drop.source.p_ind,parent.p_ind);
                    drop.source.drop_link=parent;
                    drop.source.index=gameLogic.get_count(parent.p_ind)-1;
                    return Qt.MoveAction;
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: parent.enabled&&main_form.drag_need_resume
                    onClicked: {
                        gameLogic.make_turn(gameLogic.drag_row_index,parent.parent.p_ind);
                    }
                }
            }
            Component.onCompleted: {
                var tmp=drop_areas;
                tmp[p_ind]=this;
                drop_areas=tmp;
                createFishkas(p_ind);
            }
        }

        ImageCube {
            id: gameLogic
            width: 1090
            height: 970
            orientation: true
            anchors.centerIn: parent
            //anchors.horizontalCenterOffset: gameLogic.now_player==1?-320:320
            //        anchors.horizontalCenterOffset: 320

            visible: true
            onLogic_stateChanged: {
                console.log("onLogic_stateChanged");
                main_form.gamestate=gameLogic.logic_state
                newgamestate(main_form.gamestate)
            }
            onLogicInited: {
                //createFishkas();
            }
            gl_axis_y:4.5
            gl_axis_x:3.75
            function translateToCanvas(x,y){
                var newY=(x/background.width)*gl_axis_y*2-gl_axis_y
                var newX=(y/background.height)*gl_axis_x*2-gl_axis_x

                console.log("translateToCanvas",x,y,newX,newY)
                var vector = { x: newX, y: newY };
            return vector;
            }
        }

    }
    Component.onCompleted: {
        fishka_c = Qt.createComponent("Fishka.qml");
        if (fishka_c.status != Component.Ready)fishka_c=null;
    }
    function createFishkas(index){
        if(fishka_c==null)return;
        var tmp=drag_fishkas;
        for(var j=0;j<gameLogic.get_count(index);j++){
            var fishka = fishka_c.createObject(background, {
                                                   "drop_link":drop_areas[index],
                                                   //"p_ind":index,
                                                   "index": j,
                                                   //"anchors.top": drop_areas[index].top,
                                                   "fiska_size": fiska_size,
                                                   "image_white": "1w_+++.png",
                                                   "image_black": "1b_+++.png"});
            if (fishka == null)
                console.log("Error creating object");
            else
                tmp.push(fishka);
        }
        drag_fishkas=tmp;
    }
}
