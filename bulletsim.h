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

class bulletSim : public QThread
{
    Q_OBJECT
public:
    bulletSim();
    void run() Q_DECL_OVERRIDE;
protected:
    btDiscreteDynamicsWorld* dynamicsWorld;
    btRigidBody* fallRigidBody;
};

#endif // BULLETSIM_H
