import QtQuick 2.0
import QtCanvas3D 1.0
import BulletSim 1.0
import "imagecube.js" as GLCode

Canvas3D {
    id: cube
    state: "image1"
//    property string image1: ""
//    property string image2: ""
//    property string image3: ""
//    property string image4: ""
//    property string image5: ""
//    property string image6: ""
//    property alias scale: 1
    property alias xR1: dice1.xRotation
    property alias yR1: dice1.yRotation
    property alias zR1: dice1.zRotation
    property alias xR2: dice2.xRotation
    property alias yR2: dice2.yRotation
    property alias zR2: dice2.zRotation
    BulletSim{
        id:bullet
    }
    Item{
        id:dice1
        property real xRotation: 0
        property real yRotation: 0
        property real zRotation: 0
        state: "image1"
        states: [
            State {
                name: "image1"
                PropertyChanges { target: dice1; xRotation: 0; }
                PropertyChanges { target: dice1; yRotation: 180 * 1.5; }
                PropertyChanges { target: dice1; zRotation: 0 }
            },
            State {
                name: "image5"
                PropertyChanges { target: dice1; xRotation: 0; }
                PropertyChanges { target: dice1; yRotation: 180 * 1.0; }
                PropertyChanges { target: dice1; zRotation: 0 }
            },
            State {
                name: "image6"
                PropertyChanges { target: dice1; xRotation: 0; }
                PropertyChanges { target: dice1; yRotation: 180 * 0.5; }
                PropertyChanges { target: dice1; zRotation: 0 }
            },
            State {
                name: "image2"
                PropertyChanges { target: dice1; xRotation: 0; }
                PropertyChanges { target: dice1; yRotation: 0; }
                PropertyChanges { target: dice1; zRotation: 0; }
            },
            State {
                name: "image3"
                PropertyChanges { target: dice1; xRotation: 180 / 2.0; }
                PropertyChanges { target: dice1; yRotation: 0; }
                PropertyChanges { target: dice1; zRotation: 0; }
            },
            State {
                name: "image4"
                PropertyChanges { target: dice1; xRotation: -180 / 2.0; }
                PropertyChanges { target: dice1; yRotation: 0; }
                PropertyChanges { target: dice1; zRotation: 0; }
            }
        ]
        transitions: [
            Transition {
                id: turnTransition
                from: "*"
                to: "*"
                RotationAnimation {
                    properties: "xRotation,yRotation,zRotation"
                    easing.type: Easing.Linear
                    direction: RotationAnimation.Shortest
                    duration: 450
                }
            }
        ]
    }
    Item{
        id:dice2
        property real xRotation: 0
        property real yRotation: 0
        property real zRotation: 0
        state: "image1"
        states: [
            State {
                name: "image1"
                PropertyChanges { target: dice2; xRotation: 0; }
                PropertyChanges { target: dice2; yRotation: 180 * 1.5; }
                PropertyChanges { target: dice2; zRotation: 0 }
            },
            State {
                name: "image5"
                PropertyChanges { target: dice2; xRotation: 0; }
                PropertyChanges { target: dice2; yRotation: 180 * 1.0; }
                PropertyChanges { target: dice2; zRotation: 0 }
            },
            State {
                name: "image6"
                PropertyChanges { target: dice2; xRotation: 0; }
                PropertyChanges { target: dice2; yRotation: 180 * 0.5; }
                PropertyChanges { target: dice2; zRotation: 0 }
            },
            State {
                name: "image2"
                PropertyChanges { target: dice2; xRotation: 0; }
                PropertyChanges { target: dice2; yRotation: 0; }
                PropertyChanges { target: dice2; zRotation: 0; }
            },
            State {
                name: "image3"
                PropertyChanges { target: dice2; xRotation: 180 / 2.0; }
                PropertyChanges { target: dice2; yRotation: 0; }
                PropertyChanges { target: dice2; zRotation: 0; }
            },
            State {
                name: "image4"
                PropertyChanges { target: dice2; xRotation: -180 / 2.0; }
                PropertyChanges { target: dice2; yRotation: 0; }
                PropertyChanges { target: dice2; zRotation: 0; }
            }
        ]
        transitions: [
            Transition {
                id: turnTransition2
                from: "*"
                to: "*"
                RotationAnimation {
                    properties: "xRotation,yRotation,zRotation"
                    easing.type: Easing.Linear
                    direction: RotationAnimation.Shortest
                    duration: 450
                }
            }
        ]
    }




    onInitializeGL: {
        GLCode.initializeGL(cube);
    }

    onPaintGL: {
        GLCode.paintGL(cube);
    }

    onResizeGL: {
        GLCode.resizeGL(cube);
    }

    function setState1(str){
        dice1.state=str;
    }
    function setState2(str){
        dice2.state=str;
    }
}
