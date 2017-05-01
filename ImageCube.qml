import QtQuick 2.0
import QtCanvas3D 1.0

import "imagecube.js" as GLCode

Canvas3D {
    id: cube

    state: "image6"
    property real angleOffset: 0;//-180 / 8.0
    property string image1: ""
    property string image2: ""
    property string image3: ""
    property string image4: ""
    property string image5: ""
    property string image6: ""
    property real xRotation: 0
    property real yRotation: 0
    property real zRotation: 0
    property real scale: 1
    states: [
        State {
            name: "image1"
            PropertyChanges { target: cube; xRotation: 0; }
            PropertyChanges { target: cube; yRotation: 180 * 1.5; }
            PropertyChanges { target: cube; zRotation: 0 }
        },
        State {
            name: "image2"
            PropertyChanges { target: cube; xRotation: 0; }
            PropertyChanges { target: cube; yRotation: 180 * 1.0; }
            PropertyChanges { target: cube; zRotation: 0 }
        },
        State {
            name: "image3"
            PropertyChanges { target: cube; xRotation: 0; }
            PropertyChanges { target: cube; yRotation: 180 * 0.5; }
            PropertyChanges { target: cube; zRotation: 0 }
        },
        State {
            name: "image4"
            PropertyChanges { target: cube; xRotation: 0; }
            PropertyChanges { target: cube; yRotation: 0; }
            PropertyChanges { target: cube; zRotation: 0; }
        },
        State {
            name: "image5"
            PropertyChanges { target: cube; xRotation: 180 / 2.0; }
            PropertyChanges { target: cube; yRotation: 0; }
            PropertyChanges { target: cube; zRotation: 0; }
        },
        State {
            name: "image6"
            PropertyChanges { target: cube; xRotation: -180 / 2.0; }
            PropertyChanges { target: cube; yRotation: 0; }
            PropertyChanges { target: cube; zRotation: 0; }
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

    onInitializeGL: {
        GLCode.initializeGL(cube);
    }

    onPaintGL: {
        GLCode.paintGL(cube);
    }

    onResizeGL: {
        GLCode.resizeGL(cube);
    }

}
