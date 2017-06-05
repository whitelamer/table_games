#ifndef BULLETSIM_H
#define BULLETSIM_H
#include "btBulletDynamicsCommon.h"
#define ARRAY_SIZE_Y 5
#define ARRAY_SIZE_X 5
#define ARRAY_SIZE_Z 5

#include "LinearMath/btVector3.h"
#include "LinearMath/btAlignedObjectArray.h"
#include "BulletSoftBody/btSoftBodyRigidBodyCollisionConfiguration.h"
#include "BulletSoftBody/btSoftRigidDynamicsWorld.h"

//#include "../CommonInterfaces/CommonRigidBodyBase.h"
#include <QObject>
#include <QThread>
#include <QVector3D>
#include <QMatrix4x4>
#include <QQuaternion>

class bulletSim : public QThread
{
    Q_OBJECT
public:
    bulletSim();
    void run() Q_DECL_OVERRIDE;
    Q_PROPERTY(QVector3D cube1pos READ getCube1pos)

    Q_INVOKABLE QVector3D getCube1pos() const;
    Q_INVOKABLE QQuaternion getCube1quat() const;

    Q_INVOKABLE QQuaternion getCube2quat() const;
    Q_INVOKABLE QVector3D getCube2pos() const;

    bool getRuning() const;
    void setRuning(bool value);

    Q_INVOKABLE QVector3D getCube1rot() const;

    Q_INVOKABLE QVector3D getCube2rot() const;
    void applyForceInDirection(btRigidBody*obj,QVector3D dir);

    Q_INVOKABLE QMatrix4x4 getCube2trans() const;

    Q_INVOKABLE QMatrix4x4 getCube1trans() const;

protected:
    void setupWalls();
    bool runing;
    btDiscreteDynamicsWorld* dynamicsWorld;
    btRigidBody* groundRigidBody;
    btRigidBody* fallRigidBody;
    btRigidBody* fallRigidBody2;
    QMatrix4x4 cube1trans;
    QQuaternion cube1quat;
    QVector3D cube1pos;
    QVector3D cube1rot;
    QMatrix4x4 cube2trans;
    QQuaternion cube2quat;
    QVector3D cube2pos;
    QVector3D cube2rot;
    double scale;

    /*
QQuaternion -> quaternion
QVector2D, QVector3D, QVector4D ->
vector2d, vector3d, vector4d
*/
};

#endif // BULLETSIM_H
