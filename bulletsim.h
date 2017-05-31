#ifndef BULLETSIM_H
#define BULLETSIM_H
#include "btBulletDynamicsCommon.h"
#define ARRAY_SIZE_Y 5
#define ARRAY_SIZE_X 5
#define ARRAY_SIZE_Z 5

#include "LinearMath/btVector3.h"
#include "LinearMath/btAlignedObjectArray.h"

//#include "../CommonInterfaces/CommonRigidBodyBase.h"
#include <QObject>
#include <QThread>
#include <QVector3D>
#include <QQuaternion>

class bulletSim : public QThread
{
    Q_OBJECT
public:
    bulletSim();
    void run() Q_DECL_OVERRIDE;
    QVector3D getCube1pos() const;
    QQuaternion getCube1quat() const;

    QQuaternion getCube2quat() const;
    QVector3D getCube2pos() const;

    bool getRuning() const;
    void setRuning(bool value);

protected:
    bool runing;
    btDiscreteDynamicsWorld* dynamicsWorld;
    btRigidBody* fallRigidBody;
    QQuaternion cube1quat;
    QVector3D cube1pos;
    QQuaternion cube2quat;
    QVector3D cube2pos;
    /*
QQuaternion -> quaternion
QVector2D, QVector3D, QVector4D ->
vector2d, vector3d, vector4d
*/
};

#endif // BULLETSIM_H
