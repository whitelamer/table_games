import QtQuick 2.0

Item {
    id:main_form
    width: 1920
    height: 1080
    Image {
        id: background
        width: 1280
        height: 1024
        fillMode: Image.PreserveAspectFit
        source:"./img/fone1280x1024.png"
    }
    ImageCube {
        id: gameLogic
        width: 502
        height: 940
        anchors.centerIn: background
        anchors.horizontalCenterOffset: gameLogic.now_player==1?-320:320
//        anchors.horizontalCenterOffset: 320

        visible: true
    }

    anchors.fill: parent
    property alias gamestate: gameLogic.state
    property alias nowplayer: gameLogic.now_player
    property QtObject drag_item: null
    property bool drag_need_resume: false
    property int main_spacing: 40
    signal updateAfterDrop(int src, int dst)

}
