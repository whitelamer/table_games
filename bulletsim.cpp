#include "bulletsim.h"
#include <QDebug>

bulletSim::bulletSim()
{
    btBroadphaseInterface* broadphase = new btDbvtBroadphase();

    btDefaultCollisionConfiguration* collisionConfiguration = new btDefaultCollisionConfiguration();
    btCollisionDispatcher* dispatcher = new btCollisionDispatcher(collisionConfiguration);



    btSequentialImpulseConstraintSolver* solver = new btSequentialImpulseConstraintSolver;

    dynamicsWorld = new btDiscreteDynamicsWorld(dispatcher, broadphase, solver, collisionConfiguration);

    dynamicsWorld->setGravity(btVector3(0, 0, -10));




    btCollisionShape* groundShape = new btStaticPlaneShape(btVector3(0, 0, 1), 1);

    btDefaultMotionState* groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(0, 0, -1)));

    btRigidBody::btRigidBodyConstructionInfo groundRigidBodyCI(0, groundMotionState, groundShape, btVector3(0, 0, 0));

    btRigidBody* groundRigidBody = new btRigidBody(groundRigidBodyCI);

    dynamicsWorld->addRigidBody(groundRigidBody);




    btBoxShape* fallShape = new btBoxShape(btVector3(.25,.25,.25));

    btDefaultMotionState* fallMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(0, 0, 2)));
    btScalar mass = 5;
    btVector3 fallInertia(1, 1, 0);
    fallShape->calculateLocalInertia(mass, fallInertia);
    btRigidBody::btRigidBodyConstructionInfo fallRigidBodyCI(mass, fallMotionState, fallShape, fallInertia);
    fallRigidBody = new btRigidBody(fallRigidBodyCI);
    dynamicsWorld->addRigidBody(fallRigidBody);


//    for (int i = 0; i < 300; i++) {
//            dynamicsWorld->stepSimulation(1 / 60.f, 10);

//            btTransform trans;
//            fallRigidBody->getMotionState()->getWorldTransform(trans);

//            qDebug() << "sphere height: " << trans.getOrigin().getX() << trans.getOrigin().getY() << trans.getOrigin().getZ();
//    }
}

void bulletSim::run()
{
    runing = true;
    while (true) {
        if(runing){
            dynamicsWorld->stepSimulation(1 / 60.f, 10);
            btTransform trans;
            fallRigidBody->getMotionState()->getWorldTransform(trans);
            cube1pos = QVector3D(trans.getOrigin().getX(),trans.getOrigin().getY(),trans.getOrigin().getZ());
            qDebug() << "sphere height: " << trans.getOrigin().getX() << trans.getOrigin().getY() << trans.getOrigin().getZ();
            QThread::sleep(1);
        }else{
            QThread::sleep(300);
        }
    }
}

QVector3D bulletSim::getCube1pos() const
{
    return cube1pos;
}

QQuaternion bulletSim::getCube1quat() const
{
    return cube1quat;
}

QQuaternion bulletSim::getCube2quat() const
{
    return cube2quat;
}

QVector3D bulletSim::getCube2pos() const
{
    return cube2pos;
}

bool bulletSim::getRuning() const
{
    return runing;
}

void bulletSim::setRuning(bool value)
{
    runing = value;
}
