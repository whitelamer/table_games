import QtQuick 2.0

Item {
    id:main_form
    width: 1920
    height: 1080
    GameLogic{
        id:gameLogic
    }

    Image {
        id: background
        x: -236
        y: 236
        width: 1080
        height: (1080/1920)*1080
        rotation: 90
        fillMode: Image.PreserveAspectFit
        source:"/home/user/table_games/img/fon_1_B.png"
    }

    Image {
        id: background2
        x: 371
        y: 236
        width: 1080
        height: (1080/1920)*1080
        rotation: -90
        source: "/home/user/table_games/img/fon_1_B.png"
        fillMode: Image.PreserveAspectFit
    }
    anchors.fill: parent
    property alias gamestate: gameLogic.state
    property alias nowplayer: gameLogic.now_player
    property QtObject drag_item: null
    property bool drag_need_resume: false
    property int main_spacing: 40
    signal updateAfterDrop(int src, int dst)

}
