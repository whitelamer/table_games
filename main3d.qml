import QtQuick 2.2 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0

  Entity {
      id: sceneRoot

      Camera {
          id: camera
          projectionType: CameraLens.PerspectiveProjection
          fieldOfView: 45
          aspectRatio: 16/9
          nearPlane : 0.1
          farPlane : 1000.0
          position: Qt.vector3d( 0.0, 0.0, 40.0 )
          upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
          viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
      }

//      Configuration  {
//          controlledCamera: camera
//      }

      components: [
          FrameGraph {
              activeFrameGraph: ForwardRenderer {
                  camera: camera
              }
          }
      ]
      GroundPlane {
          id: ground
      }
      PhongMaterial {
          id: material
          diffuse: "yellow"
      }

      TorusMesh {
          id: torusMesh
          radius: 5
          minorRadius: 1
          rings: 100
          slices: 20
      }

      Transform {
          id: torusTransform
          scale3D: Qt.vector3d(1.5, 1, 0.5)
          rotation: fromAxisAndAngle(Qt.vector3d(1, 0, 0), 45)
      }

      Entity {
          id: torusEntity
          components: [ torusMesh, material, torusTransform ]
      }

      QQ2.Timer {
          interval: 1000
          running: true
          repeat: true
          property bool hasSphere: true

          onTriggered: {
              //loader.source = hasSphere ? "qrc:/SphereEntity.qml" : "qrc:/CuboidEntity.qml"
              hasSphere = !hasSphere
          }
      }

      EntityLoader {
          id: loader
          components: [ revolutionTransform ]
      }

      Transform {
          id: revolutionTransform
          property real userAngle: 0.0
          matrix: {
              var m = Qt.matrix4x4();
              m.rotate(userAngle, Qt.vector3d(0, 1, 0));
              m.translate(Qt.vector3d(20, 0, 0));
              return m;
          }
      }

      QQ2.NumberAnimation {
          target: revolutionTransform
          property: "userAngle"
          duration: 10000
          from: 0
          to: 360

          loops: QQ2.Animation.Infinite
          running: true
      }
  }
