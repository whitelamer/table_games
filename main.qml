import QtQuick 2.5
import QtQuick.Window 2.2
//import Processlib 1.0
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
    visibility: Window.FullScreen
    title: qsTr("Table Game")
    Settings {
        id: settings
        property string state: "active"
    }
    signal haveBill(int bill);
    /*Process{
        property int p_state: 0
        property string output: ""
        property int touch_1: -1
        property int touch_2: -1
        property string output_1: ""
        property string output_2: ""
        property int heigth: 1080;

        id:calibration_process
        onReadyRead: {
            output+=readAll();
        }

        onFinished: {

            if(output.length==0&&p_state<2){
                console.log("Calibration falid at state:"+p_state)
                heigth=1080;
                //mainIndex.source="Index1x.qml"
                mainMenu.source="menu1x_test.qml"
                return;
            }
            if(p_state==0){
                var touchs=output.split('\n')
                console.log("Detect "+(touchs.length-1)+" touchscreens:"+touchs)
                if(touchs.length>0)
                    touch_1=parseInt(touchs[0].split('=')[1])
                if(touchs.length>1&&touchs[1].length>0)
                    touch_2=parseInt(touchs[1].split('=')[1])
                p_state=1
                output="";
                calibration_process.start("bash",["-c","xrandr | grep ' connected' | cut -d ' ' -f 1"])
                return;
            }
            if(p_state==1){
                var outputs=output.split('\n')
                console.log("Detect "+(outputs.length-1)+" outputs:"+outputs)
                if(outputs.length>0)
                    output_1=outputs[0]
                if(outputs.length>1&&outputs[1].length>0)
                    output_2=outputs[1]
                p_state=2;
                output="";
                if(outputs.length-1==1){
                    heigth=1080;
                }
                if(outputs.length-1==2){
                    heigth=2160;
                }
                console.log("mapping touch:"+touch_1+" to monitor:"+output_1)
                calibration_process.start("xinput",["--map-to-output",touch_1,output_1])
                return;
            }
            if(p_state==2){
                p_state=3
                output=""
                console.log("calibration touch:"+touch_1)
                calibration_process.start("xinput",["set-int-prop",touch_1,"Evdev Axis Calibration","32","1581","398","642","1330"])
                return;
            }
            if(p_state==3){
                p_state=4
                output=""
                console.log("calibration swap touch:"+touch_1)
                calibration_process.start("xinput",["set-int-prop",touch_1,"Evdev Axes Swap","8","0"])
                return;
            }

            if(p_state==4&&touch_2>=0&&output_2.length>0){
                p_state=5
                output=""
                console.log("xinput mapping touch:"+touch_2+" to monitor:"+output_2)
                calibration_process.start("xinput",["--map-to-output",touch_2,output_2])
                return;
            }
            if(p_state==5&&touch_2>=0){
                p_state=6
                output=""
                console.log("xinput calibration touch:"+touch_2)
                calibration_process.start("xinput",["set-int-prop",touch_2,"Evdev Axis Calibration","32","1581","398","642","1330"])
                return;
            }
            if(p_state==6&&touch_2>=0){
                p_state=7
                output=""
                console.log("xinput calibration swap touch:"+touch_2)
                calibration_process.start("xinput",["set-int-prop",touch_2,"Evdev Axes Swap","8","0"])
                return;
            }

            heigth=1080;
            mainMenu.source="menu1x_test.qml"
            //mainIndex


            //mainIndex.source="menu2x.qml"
            console.log(output);
        }
    }*/
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
        anchors.fill: parent
        asynchronous: true
        visible: status == Loader.Ready
        onStatusChanged: {
            if(mainIndex.status==Loader.Ready){
                console.log('mainMenu.opacity',main_menu_test.opacity);
                main_menu_test.opacity=0;
                console.timeEnd('startGame');
            }
        }
    }
    //    Loader{
    //        id:mainMenu
    //        anchors.fill: parent
    //        onStatusChanged: {
    //            if(mainMenu.status==Loader.Ready){
    //                //startGame(0,0,0);
    //            }
    //        }
    //        Behavior on opacity {
    //            NumberAnimation {
    //                duration: 1500
    //                easing.type: Easing.Linear
    //            }
    //        }
    //    }
    Menu1x_test{
        id:main_menu_test
        Behavior on opacity {
            NumberAnimation {
                duration: 150
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
        }
    }
    function startGame(game,match,style){
        console.time('startGame');
        main_menu_test.enabled=false;
        //main_menu_test.opacity=0;
        if(main_win.height<=1080)
            mainIndex.source="Backgammon1x.qml";
        else
            mainIndex.source="Backgammon2x.qml";
    }
}
