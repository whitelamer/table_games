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
    scale=500;
    dynamicsWorld->setGravity(btVector3(0, -9.8*scale, 0));




    btCollisionShape* groundShape = new btStaticPlaneShape(btVector3(0, 1, 0), 1);
    //btCollisionShape* groundShape = new btBoxShape(btVector3(btScalar(2.),btScalar(3.),btScalar(50.)));
    btDefaultMotionState* groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(0, 0, 0)));
    btVector3 localInertia(0,0,0);
    groundShape->calculateLocalInertia(0, localInertia);

    btRigidBody::btRigidBodyConstructionInfo groundRigidBodyCI(0, groundMotionState, groundShape, btVector3(0, 0, 0));

    groundRigidBody = new btRigidBody(groundRigidBodyCI);
    groundRigidBody->setRestitution(1);
    dynamicsWorld->addRigidBody(groundRigidBody);


    btCollisionShape* borderShape= new btBoxShape(btVector3(680,1500,1));
    //borderShape = new btStaticPlaneShape(btVector3(0, 0, 1), 1);
    groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(0, 0, 1.7*scale)));
    groundRigidBody = new btRigidBody(btRigidBody::btRigidBodyConstructionInfo(0, groundMotionState, borderShape, btVector3(0, 0, 0)));
    groundRigidBody->setRestitution(1);
    dynamicsWorld->addRigidBody(groundRigidBody);

    borderShape = new btBoxShape(btVector3(680,1500,1));
    //borderShape = new btStaticPlaneShape(btVector3(0, 0, 1), 1);
    groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(0, 0, -1.7*scale)));
    groundRigidBody = new btRigidBody(btRigidBody::btRigidBodyConstructionInfo(0, groundMotionState, borderShape, btVector3(0, 0, 0)));
    groundRigidBody->setRestitution(1);
    dynamicsWorld->addRigidBody(groundRigidBody);


    borderShape = new btBoxShape(btVector3(1,1500,400));
    //borderShape = new btStaticPlaneShape(btVector3(1, 0, 0), 1);
    groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(3.35*scale, 0, 0)));
    groundRigidBody = new btRigidBody(btRigidBody::btRigidBodyConstructionInfo(0, groundMotionState, borderShape, btVector3(0, 0, 0)));
    groundRigidBody->setRestitution(1);
    dynamicsWorld->addRigidBody(groundRigidBody);


    borderShape = new btBoxShape(btVector3(1,1500,400));
    //borderShape = new btStaticPlaneShape(btVector3(1, 0, 0), 1);
    groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(-3.35*scale, 0, 0)));
    groundRigidBody = new btRigidBody(btRigidBody::btRigidBodyConstructionInfo(0, groundMotionState, borderShape, btVector3(0, 0, 0)));
    groundRigidBody->setRestitution(1);
    dynamicsWorld->addRigidBody(groundRigidBody);


    /*groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(1, 0, 0, -M_PI/2.0), btVector3(0, 0, -1*scale)));
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


    double box_size=.25*scale;
    btBoxShape* fallShape = new btBoxShape(btVector3(box_size,box_size,box_size));

    btDefaultMotionState* fallMotionState = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(.55*scale, 2.5*scale, 0)));
    btScalar mass = 50*scale;
    btVector3 fallInertia(0, 0, 0);
    fallShape->calculateLocalInertia(mass, fallInertia);
    btRigidBody::btRigidBodyConstructionInfo fallRigidBodyCI(mass, fallMotionState, fallShape, fallInertia);
    fallRigidBody = new btRigidBody(fallRigidBodyCI);
    fallRigidBody->setRestitution(.1);
    fallRigidBody->setFriction(.5);
    fallRigidBody->setAngularVelocity(btVector3(0, 5, 10));
    fallRigidBody->setLinearVelocity(btVector3(10*scale, 0, 5*scale));
    dynamicsWorld->addRigidBody(fallRigidBody);


    btBoxShape* fallShape2 = new btBoxShape(btVector3(box_size,box_size,box_size));

    btDefaultMotionState* fallMotionState2 = new btDefaultMotionState(btTransform(btQuaternion(0, 0, 0, 1), btVector3(-.55*scale, 2.5*scale, 0)));
    //btVector3 fallInertia2(0, 0, 0);
    //fallShape->calculateLocalInertia(mass, fallInertia2);
    btRigidBody::btRigidBodyConstructionInfo fallRigidBodyCI2(mass, fallMotionState2, fallShape2, fallInertia);
    fallRigidBody2 = new btRigidBody(fallRigidBodyCI2);
    fallRigidBody2->setRestitution(.3);
    //fallRigidBody2->setFriction(.5);
    fallRigidBody2->setDamping(0.9,0.3);
    //diceRigidBody->setLinearFactor(btVector3(1,1,1));
    fallRigidBody2->setAngularFactor(btVector3(1,1,1));

    fallRigidBody2->setAngularVelocity(btVector3(0, -10, 5));
    fallRigidBody2->setLinearVelocity(btVector3(-10*scale, 0, -5*scale));
    dynamicsWorld->addRigidBody(fallRigidBody2);

//    for (int i = 0; i < 300; i++) {
//            dynamicsWorld->stepSimulation(1 / 60.f, 10);

//            btTransform trans;
//            fallRigidBody->getMotionState()->getWorldTransform(trans);

//            qDebug() << "sphere height: " << trans.getOrigin().getX() << trans.getOrigin().getY() << trans.getOrigin().getZ();
//    }
}
/*
 * - (void) setupPhysics {

    broadphase = new btDbvtBroadphase();
    collisionConfiguration = new btDefaultCollisionConfiguration();
    dispatcher = new btCollisionDispatcher(collisionConfiguration);
    solver = new btSequentialImpulseConstraintSolver();
    dynamicsWorld = new btDiscreteDynamicsWorld(dispatcher,broadphase,solver,collisionConfiguration);
    dynamicsWorld->setGravity(btVector3(0,0,-18.8));

    //WALL SETUP

    //FLOOR


    wallShape[0] = new btStaticPlaneShape(btVector3(0,0,1),1);
    wallMotionShape[0] = new btDefaultMotionState(btTransform(btQuaternion(0,0,0,1),btVector3(0,0,0)));
    btRigidBody::btRigidBodyConstructionInfo wallRigidBodyCI(0,wallMotionShape[0],wallShape[0],btVector3(0,0,0));
    wallRigidBodyCI.m_restitution = 0.3;
    wallRigidBody[0] = new btRigidBody(wallRigidBodyCI);
    dynamicsWorld->addRigidBody(wallRigidBody[0]);

    //CEILING
    wallShape[1] = new btStaticPlaneShape(btVector3(0,0,-1),1);
    wallMotionShape[1] = new btDefaultMotionState(btTransform(btQuaternion(0,0,0,1),btVector3(0,0,12)));
    btRigidBody::btRigidBodyConstructionInfo wallRigidBodyCIC(0,wallMotionShape[1],wallShape[1],btVector3(0,0,0));
    wallRigidBodyCIC.m_restitution = 0.3;
    wallRigidBody[1] = new btRigidBody(wallRigidBodyCIC);
    dynamicsWorld->addRigidBody(wallRigidBody[1]);

    //NORTH
    wallShape[2] = new btStaticPlaneShape(btVector3(0,-1,0),1);
    wallMotionShape[2] = new btDefaultMotionState(btTransform(btQuaternion(0,0,0,1),btVector3(0,boundary.w,0)));
    btRigidBody::btRigidBodyConstructionInfo wallRigidBodyCIN(0,wallMotionShape[2],wallShape[2],btVector3(0,0,0));
    wallRigidBodyCIN.m_restitution = 0.3;
    wallRigidBody[2] = new btRigidBody(wallRigidBodyCIN);
    dynamicsWorld->addRigidBody(wallRigidBody[2]);

    //WEST
    wallShape[3] = new btStaticPlaneShape(btVector3(1,0,0),1);
    wallMotionShape[3] = new btDefaultMotionState(btTransform(btQuaternion(0,0,0,1),btVector3(boundary.x,0,0)));
    btRigidBody::btRigidBodyConstructionInfo wallRigidBodyCIW(0,wallMotionShape[3],wallShape[3],btVector3(0,0,0));
    wallRigidBodyCIW.m_restitution = 0.3;
    wallRigidBody[3] = new btRigidBody(wallRigidBodyCIW);
    dynamicsWorld->addRigidBody(wallRigidBody[3]);

    //SOUTH
    wallShape[4] = new btStaticPlaneShape(btVector3(0,1,0),1);
    wallMotionShape[4] = new btDefaultMotionState(btTransform(btQuaternion(0,0,0,1),btVector3(0,boundary.z,0)));
    btRigidBody::btRigidBodyConstructionInfo wallRigidBodyCIS(0,wallMotionShape[4],wallShape[4],btVector3(0,0,0));
    wallRigidBodyCIS.m_restitution = 0.3;
    wallRigidBody[4] = new btRigidBody(wallRigidBodyCIS);
    dynamicsWorld->addRigidBody(wallRigidBody[4]);

    //EAST
    wallShape[5] = new btStaticPlaneShape(btVector3(-1,0,0),1);
    wallMotionShape[5] = new btDefaultMotionState(btTransform(btQuaternion(0,0,0,1),btVector3(boundary.y,0,0)));
    btRigidBody::btRigidBodyConstructionInfo wallRigidBodyCIE(0,wallMotionShape[5],wallShape[5],btVector3(0,0,0));
    wallRigidBodyCIE.m_restitution = 0.3;
    wallRigidBody[5] = new btRigidBody(wallRigidBodyCIE);
    dynamicsWorld->addRigidBody(wallRigidBody[5]);

}- (void) applyForceInDirection: (GLKVector3) dir {

    btVector3 v = btVector3(dir.x/3, dir.y/3, dir.z/3);

    diceRigidBody->applyForce(v, btVector3(0, 0, 0));

    btVector3 t = v.cross(btVector3(0, 0, -1));
    t.normalized();
    t *= 0.65f;

    diceRigidBody->applyTorque(t);

}*/
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

            //groundRigidBody->getMotionState()->getWorldTransform(trans);

            //qDebug()<<trans.getOrigin().getX()/scale<<trans.getOrigin().getY()/scale<<trans.getOrigin().getZ()/scale;
            i++;
            if(i>500){
                i=0;
                fallRigidBody->setWorldTransform(btTransform(btQuaternion(0, 0, 0, 1), btVector3(.15*scale, 2*scale, 0)));
                fallRigidBody->setAngularVelocity(btVector3(0, 10, 30));
                fallRigidBody->setLinearVelocity(btVector3(1*scale, 0, 1*scale));

                fallRigidBody2->setWorldTransform(btTransform(btQuaternion(0, 0, 0, 1), btVector3(-.15*scale, 2*scale, 0)));
                fallRigidBody2->setAngularVelocity(btVector3(0, -20, 10));
                fallRigidBody2->setLinearVelocity(btVector3(3*scale, 0, 1*scale));
                qDebug()<<"Reset state";
            }
            QThread::msleep(330);
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
