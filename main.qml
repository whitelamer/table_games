import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    id:main_win
    visible: true
    width: 1920
    height: 2160
    minimumWidth: 1920
    minimumHeight: 2160
    visibility: Window.FullScreen
    title: qsTr("Table Game")

    Loader{
        source: "Index.qml"
        id:mainIndex
        anchors.fill: parent
        onStatusChanged: {
            if(status==Loader.Ready){
                main_win.showFullScreen();
            }
        }
    }
	Item{
focus:true
Keys.onPressed:{
        console.log("Keys.onPressed:"+event.key);
        if(event.key==Qt.Key_Escape)Qt.quit();
    }
}
}
