import QtQuick 2.0
import QtQuick.Window 2.2
import QtCanvas3D 1.0
import "gl_draw_code.js" as GLCode
import "gl_logic.js" as GLLogic
import Qt.labs.settings 1.0

Window {
    id:main_win
    visible: true
    x:0
    y:0
    width: 10
    height: 10
    //width: 1920
    //height: 2160
    //minimumWidth: 1920
    //minimumHeight: 2160
    visibility: Window.Maximized
    title: qsTr("Table Game")
    Settings {
        id: settings
        property string state: "active"
    }
    signal haveBill(int bill);

    Component.onCompleted: {
        //calibration_process.p_state=0
        //calibration_process.output=""
        //calibration_process.start("bash",["-c","xinput | grep Touchscreen | cut -f 2"])
        //main_win.showFullScreen();
        //console.log(main_win.height)
        //        if(main_win.height<=1080)
        //            mainIndex.source="Menu1x_test.qml";
        //        else
        //            mainIndex.source="Menu2x_test.qml";
    }
    Rectangle{
        id:fone_rec
        anchors.fill: parent
        color:"black"
    }

    Loader{
        id:mainIndex
        //anchors.fill: parent
        asynchronous: true
        visible: status == Loader.Ready
        onStatusChanged: {
            if(mainIndex.status==Loader.Ready){
                console.log('mainMenu.opacity',main_menu_test.opacity);
                main_menu_test.opacity=0;
                gl_canvas.anchors.fill=mainIndex;
                console.timeEnd('startGame');
            }
        }
    }

    Canvas3D {
        id:gl_canvas
        property bool showdrop: false
        width: 10
        height: 10
        onInitializeGL: {
            GLCode.initializeGL(gl_canvas);
        }
        onPaintGL: {
            GLCode.paintGL(gl_canvas);
        }
        onResizeGL: {
            GLCode.resizeGL(gl_canvas);
        }
    }
    Menu1x_test{
        id:main_menu_test
        Behavior on opacity {
            NumberAnimation {
                duration: 250
                easing.type: Easing.Linear
            }
        }
    }
    Rectangle {
        x: 1302
        y: 27
        width: 219
        height: 33
        color: "green"
        Text {
            id: name
            text: gl_canvas.width+"x"+gl_canvas.height
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                haveBill(500);
            }
        }
    }
    Item{
        focus:true
        Keys.onPressed:{
            console.log("Keys.onPressed:"+event.key);
            if(event.key==Qt.Key_Escape)Qt.quit();
            if(event.key==Qt.Key_A)haveBill(500);
        }
    }
    function startGame(game,match,style){
        console.time('startGame');
        main_menu_test.enabled=false;
        //main_menu_test.opacity=0;
        if(main_win.height<=1080)
            mainIndex.setSource("Backgammon1x.qml");
        else
            mainIndex.setSource("Backgammon2x.qml");
    }
}
