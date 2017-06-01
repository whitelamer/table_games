#include "bulletsim.h"
#include <QDebug>
#include <QtMath>
#include <bullet/BulletCollision/Gimpact/btGImpactCollisionAlgorithm.h>

//btScalar btSequentialImpulseConstraintSolver::resolveSingleConstraintRowLowerLimit(btSolverBody& body1,btSolverBody& body2,const btSolverConstraint& c)
//{
//   btScalar deltaImpulse = c.m_rhs-btScalar(c.m_appliedImpulse)*c.m_cfm;
//   const btScalar deltaVel1Dotn	=	c.m_contactNormal1.dot(body1.internalGetDeltaLinearVelocity()) 	+ c.m_relpos1CrossNormal.dot(body1.internalGetDeltaAngularVelocity());
//   const btScalar deltaVel2Dotn	=	-c.m_contactNormal1.dot(body2.internalGetDeltaLinearVelocity()) + c.m_relpos2CrossNormal.dot(body2.internalGetDeltaAngularVelocity());

//   deltaImpulse	-=	deltaVel1Dotn*c.m_jacDiagABInv;
//   deltaImpulse	-=	deltaVel2Dotn*c.m_jacDiagABInv;
//   const btScalar sum = btScalar(c.m_appliedImpulse) + deltaImpulse;
//   if (sum < c.m_lowerLimit)
//   {
//       deltaImpulse = c.m_lowerLimit-c.m_appliedImpulse;
//       c.m_appliedImpulse = c.m_lowerLimit;
//   }
//   else
//   {
//       c.m_appliedImpulse = sum;
//   }
//   body1.internalApplyImpulse(c.m_contactNormal1*body1.internalGetInvMass(),c.m_angularComponentA,deltaImpulse);
//   body2.internalApplyImpulse(-c.m_contactNormal1*body2.internalGetInvMass(),c.m_angularComponentB,deltaImpulse);
//   return deltaImpulse;
//}
bulletSim::bulletSim()
{
    btBroadphaseInterface* broadphase = new btDbvtBroadphase();

    btDefaultCollisionConfiguration* collisionConfiguration = new btDefaultCollisionConfiguration();
    btCollisionDispatcher* dispatcher = new btCollisionDispatcher(collisionConfiguration);

    btGImpactCollisionAlgorithm::registerAlgorithm(dispatcher);

    btSequentialImpulseConstraintSolver* solver = new btSequentialImpulseConstraintSolver;

    dynamicsWorld = new btDiscreteDynamicsWorld(dispatcher, broadphase, solver, collisionConfiguration);
    scale=1000;
    dynamicsWorld->setGravity(btVector3(0, -9.8*scale, 0));




    btCollisionShape* groundShape = new btStaticPlaneShape(btVector3(0, 1, 0), 0);
    //btCollisionShape* groundShape = new btBoxShape(btVector3(btScalar(2.),btScalar(3.),btScalar(50.)));
    btDefaultMotionState* groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(0, 0, 0)));
    btVector3 localInertia(0,0,0);
    groundShape->calculateLocalInertia(0, localInertia);

    btRigidBody::btRigidBodyConstructionInfo groundRigidBodyCI(0, groundMotionState, groundShape, localInertia);

    btRigidBody* groundRigidBody = new btRigidBody(groundRigidBodyCI);
    groundRigidBody->setRestitution(.5);
    dynamicsWorld->addRigidBody(groundRigidBody);


/*    groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(1, 0, 0, M_PI/2.0), btVector3(0, 0, 4*scale)));
    groundRigidBody = new btRigidBody(btRigidBody::btRigidBodyConstructionInfo(0, groundMotionState, groundShape, btVector3(0, 0, 0)));
    groundRigidBody->setRestitution(.5);
    dynamicsWorld->addRigidBody(groundRigidBody);

    groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(1, 0, 0, -M_PI/2.0), btVector3(0, 0, -1*scale)));
    groundRigidBody = new btRigidBody(btRigidBody::btRigidBodyConstructionInfo(0, groundMotionState, groundShape, btVector3(0, 0, 0)));
    groundRigidBody->setRestitution(.5);
    dynamicsWorld->addRigidBody(groundRigidBody);

    groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 1, -M_PI/2.0), btVector3(0, 0, 50*scale)));
    groundRigidBody = new btRigidBody(btRigidBody::btRigidBodyConstructionInfo(0, groundMotionState, groundShape, btVector3(0, 0, 0)));
    groundRigidBody->setRestitution(.5);
    dynamicsWorld->addRigidBody(groundRigidBody);

    groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 1, M_PI/2.0), btVector3(0, 0, -50*scale)));
    groundRigidBody = new btRigidBody(btRigidBody::btRigidBodyConstructionInfo(0, groundMotionState, groundShape, btVector3(0, 0, 0)));
    groundRigidBody->setRestitution(.5);
    dynamicsWorld->addRigidBody(groundRigidBody);*/


    double box_size=.35*scale;
    btBoxShape* fallShape = new btBoxShape(btVector3(box_size,box_size,box_size));

    btDefaultMotionState* fallMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(.15*scale, 2.5*scale, 0)));
    btScalar mass = 50*scale;
    btVector3 fallInertia(0, 0, 0);
    fallShape->calculateLocalInertia(mass, fallInertia);
    btRigidBody::btRigidBodyConstructionInfo fallRigidBodyCI(mass, fallMotionState, fallShape, fallInertia);
    fallRigidBody = new btRigidBody(fallRigidBodyCI);
    fallRigidBody->setRestitution(0.5);
    fallRigidBody->setFriction(1);
    fallRigidBody->setAngularVelocity(btVector3(0, 10, 30));
    fallRigidBody->setLinearVelocity(btVector3(3*scale, 0, 1*scale));
    fallRigidBody->setActivationState(DISABLE_DEACTIVATION);
    dynamicsWorld->addRigidBody(fallRigidBody);


    //btBoxShape* fallShape2 = new btBoxShape(btVector3(box_size,box_size,box_size));

    btDefaultMotionState* fallMotionState2 = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(-.15*scale, 2.5*scale, 0)));
    //btVector3 fallInertia2(0, 0, 0);
    //fallShape->calculateLocalInertia(mass, fallInertia2);
    btRigidBody::btRigidBodyConstructionInfo fallRigidBodyCI2(mass, fallMotionState2, fallShape, fallInertia);
    fallRigidBody2 = new btRigidBody(fallRigidBodyCI2);
    fallRigidBody2->setRestitution(0.5);
    fallRigidBody2->setFriction(1);
    fallRigidBody2->setAngularVelocity(btVector3(0, -20, 10));
    fallRigidBody2->setLinearVelocity(btVector3(1*scale, 0, 1*scale));
    fallRigidBody2->setActivationState(DISABLE_DEACTIVATION);
    dynamicsWorld->addRigidBody(fallRigidBody2);

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
    double x,y,z;
    int i=0;
    while (true) {
        if(runing){
            dynamicsWorld->stepSimulation(1 / 60.f, 10);
            btTransform trans;
            fallRigidBody->getMotionState()->getWorldTransform(trans);
            cube1pos = QVector3D(trans.getOrigin().getX(),trans.getOrigin().getY(),trans.getOrigin().getZ())/scale;
            cube1quat = QQuaternion(trans.getRotation().getW(),trans.getRotation().getX(),trans.getRotation().getY(),trans.getRotation().getZ());
            trans.getRotation().getEulerZYX((btScalar&)x,(btScalar&)y,(btScalar&)z);
            cube1rot = QVector3D(x,y,z);


            fallRigidBody2->getMotionState()->getWorldTransform(trans);
            cube2pos = QVector3D(trans.getOrigin().getX(),trans.getOrigin().getY(),trans.getOrigin().getZ())/scale;
            cube2quat = QQuaternion(trans.getRotation().getW(),trans.getRotation().getX(),trans.getRotation().getY(),trans.getRotation().getZ());
            trans.getRotation().getEulerZYX((btScalar&)x,(btScalar&)y,(btScalar&)z);
            cube2rot = QVector3D(x,y,z);
            i++;
            if(i>500){
                i=0;
                fallRigidBody->setWorldTransform(btTransform(btQuaternion(0, 0, 0, 1), btVector3(.15*scale, 2*scale, 0)));
                fallRigidBody2->setWorldTransform(btTransform(btQuaternion(0, 0, 0, 1), btVector3(-.15*scale, 2*scale, 0)));
                fallRigidBody->setAngularVelocity(btVector3(0, 10, 30));
                fallRigidBody->setLinearVelocity(btVector3(1*scale, 0, 1*scale));
                fallRigidBody2->setAngularVelocity(btVector3(0, -20, 10));
                fallRigidBody2->setLinearVelocity(btVector3(3*scale, 0, 1*scale));
                qDebug()<<"Reset state";
            }
            QThread::msleep(33);
        }else{
            QThread::msleep(300);
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

QVector3D bulletSim::getCube1rot() const
{
    return cube1rot;
}

QVector3D bulletSim::getCube2rot() const
{
    return cube2rot;
}
