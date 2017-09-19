.pragma library
Qt.include("cannon.js")

var canvas_obj,camera, scene, renderer;
//var cube1,cube2
var desk,desk_mat, fishka_obj;
//var body1;
//var body2;

//vars for cubics
var cubes=[],bodys=[],op_dice=[];

var fishkas_obj = [];
var pointLight;
var directionalLight;
// Physics variables
var collisionConfiguration;
var dispatcher;
var broadphase;
var solver;
var softBodySolver;
var physicsWorld;
var rigidBodies = [];
var barriers = [];
var margin = 0.05;
var hinge;
var rope;
var world = null;
var sphere;
var dice_stopped = [true,true];
var dice_roll = [0,0];
//var op_dice1=1;
//var op_dice2=1;

function setOrientation(orientation){
    if(orientation)
        camera.rotation.z=Math.PI/2; ///=+
    else
        camera.rotation.z=0;
}

function get3dObj(player){
    if(fishkas_obj.length>0){
        for(var i=0;i<fishkas_obj.length;i++){
            if(fishkas_obj[i].color==player){
                var ret=fishkas_obj[i];
                fishkas_obj.splice(i, 1);
                return ret;
            }
        }
    }
    return null;
}
function opacity_dice1(opacity){
    cubes[0].material.materials[0].opacity=opacity;
    cubes[0].material.materials[1].opacity=opacity;
}
function opacity_dice2(opacity){
    cubes[1].material.materials[0].opacity=opacity;
    cubes[1].material.materials[1].opacity=opacity;
}
function hide_dice1(){
    cubes[0].position.set(999,999,999);
}
function hide_dice2(){
    cubes[1].position.set(999,999,999);
}
function initPhysics() {
    //////////////////////////////////////////////////////////////////WORLD
    world = new CANNON.World();
    world.gravity.set(0,0,-18.82);
    world.broadphase = new CANNON.NaiveBroadphase();
    world.solver.iterations = 16;

    //////////////////////////////////////////////////////////////////BOUNDING BOX
    var dice_body_material = new CANNON.Material();
    var desk_body_material = new CANNON.Material();
    var barrier_body_material = new CANNON.Material();
    world.addContactMaterial(new CANNON.ContactMaterial(
                                 desk_body_material, dice_body_material,{
                                     friction: 0.01,
                                     restitution: 0.3
                                 }));
    world.addContactMaterial(new CANNON.ContactMaterial(
                                 barrier_body_material, dice_body_material,{
                                     friction: 0.0,
                                     restitution:1.0
                                 }));
    world.addContactMaterial(new CANNON.ContactMaterial(
                                 dice_body_material, dice_body_material,{
                                     friction: 0.0,
                                     restitution: 0.5
                                 }));

    world.addBody(new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:desk_body_material}));

    barriers = [];
    barriers["top"] = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barriers["top"].quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), Math.PI / 2);
    barriers["top"].position.set(0, 1.8, 0);
    world.addBody(barriers["top"]);

    //!    barrier = new CANNON.Body({mass:0, shape:new CANNON.Box(new CANNON.Vec3(phy_axis_x*2, phy_axis_y1,20.0)), material:barrier_body_material});
    //!    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), 0);
    //!    //barrier.position.set(phy_axis_x*2, phy_axis_y1*2, 0);
    //!    world.addBody(barrier);


    barriers["bottom"] = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barriers["bottom"].quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), -Math.PI / 2);
    barriers["bottom"].position.set(0, -1.8, 0);
    world.addBody(barriers["bottom"]);

    barriers["right"] = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barriers["right"].quaternion.setFromAxisAngle(new CANNON.Vec3(0, 1, 0), -Math.PI / 2);
    barriers["right"].position.set(1.8, 0, 0);
    world.addBody(barriers["right"]);

    barriers["left"] = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barriers["left"].quaternion.setFromAxisAngle(new CANNON.Vec3(0, 1, 0), Math.PI / 2);
    barriers["left"].position.set(-1.8, 0, 0);
    world.addBody(barriers["left"]);


    //////////////////////////////////////////////////////////////////DICE1
    sphere = new CANNON.Box(new CANNON.Vec3(.15,.15,.15));
    bodys[0] = new CANNON.Body({
                                   mass: 5,
                                   //position: new CANNON.Vec3(0.35, 0, 1.5), // m
                                   //velocity:new CANNON.Vec3(10.25, 10, 0)
                               });
    bodys[0].addShape(sphere);
    //body1.angularVelocity.set(10,2,1);
    bodys[0].angularDamping = 0.5;
    world.addBody(bodys[0]);


    //////////////////////////////////////////////////////////////////DICE2
    sphere = new CANNON.Box(new CANNON.Vec3(.15,.15,.15));
    bodys[1] = new CANNON.Body({
                                   mass: 5,
                                   //position: new CANNON.Vec3(-0.35, 0, 1.9), // m
                                   //velocity:new CANNON.Vec3(-10.25, -10, 0)
                               });
    bodys[1].addShape(sphere);
    //body2.angularVelocity.set(1,5,10);
    bodys[1].angularDamping = 0.5;
    world.addBody(bodys[1]);
}

function dropDice(vector,vector_start){
    if(world==null)return;
    console.log("dropDice",arguments[2],arguments[3]);
    //    body1.position= new CANNON.Vec3(0.35, 0, 2.0);
    //    body2.position= new CANNON.Vec3(-0.35, 0, 2.0);
    for(var i=2;i<arguments.length;i++){
        op_dice[arguments[i]]=1;
        cubes[arguments[i]].material.materials[0].opacity=op_dice[arguments[i]];
        cubes[arguments[i]].material.materials[1].opacity=op_dice[arguments[i]];
        //cube2.material.materials[0].opacity=op_dice2;
        //cube1.material.materials[1].opacity=op_dice1;
        //cube2.material.materials[1].opacity=op_dice2;

        //body1.position= new CANNON.Vec3((vector_start.y*3.42)*2-3.42+0.35, vector_start.x*1.8*2-1.8, 4.0);
        //body2.position= new CANNON.Vec3((vector_start.y*3.42)*2-3.42-0.35, vector_start.x*1.8*2-1.8, 4.0);

        bodys[arguments[i]].position= new CANNON.Vec3(vector_start.x+0.35-(0.7*arguments[i]), vector_start.y, 4.0);
        //body2.position= new CANNON.Vec3(vector_start.x-0.35, vector_start.y, 4.0);
        var tmp=new CANNON.Vec3(vector.x*2, vector.y*2, 0);

        //body1.position.vsub(tmp,tmp);
        tmp.vsub(bodys[arguments[i]].position,tmp);

        bodys[arguments[i]].velocity=tmp;//new CANNON.Vec3(vector.x, vector.y, 0);
        //body2.velocity=tmp.clone();//new CANNON.Vec3(vector.x, vector.y, 0);
        //body1.angularVelocity.set(5,5,5);
        //body2.angularVelocity.set(5,5,5);

        bodys[arguments[i]].angularVelocity.set(Math.floor(Math.random()*20)+5,Math.floor(Math.random()*10)+5,Math.floor(Math.random()*15)+5);
        //body2.angularVelocity.set(Math.floor(Math.random()*20)+5,Math.floor(Math.random()*10)+5,Math.floor(Math.random()*15)+5);


        //    dice1.pos.copy(body1.position);
        //    dice2.pos.copy(body2.position);
        //    dice1.angle.copy(body1.quaternion);
        //    dice2.angle.copy(body2.quaternion);
        dice_stopped[arguments[i]]=false;
        dice_roll[arguments[i]]=0;
        //,angle:new THREE.Quaternion()};
        //var dice2={pos:new THREE.Vec3(),angle:new THREE.Quaternion()};
        //console.log("Start drop:",(new Date()).toLocaleTimeString())
        canvas_obj.showdrop = true;
    }
}
function is_throw_finished(){
    if(world==null)return false;
    var e=.01;
    var delta=0.05
    var direction_x = new CANNON.Vec3();
    var direction_y = new CANNON.Vec3();
    var direction_z = new CANNON.Vec3();
    for(var i=0;i<2;i++){
        if(!dice_stopped[i]){
            var a = bodys[i].angularVelocity, v = bodys[i].velocity;
            if (Math.abs(a.x) < e && Math.abs(a.y) < e && Math.abs(a.z) < e &&
                    Math.abs(v.x) < e && Math.abs(v.y) < e && Math.abs(v.z) < e) {
                cubes[i].position.copy(bodys[i].position);
                cubes[i].quaternion.copy(bodys[i].quaternion);
                //console.log("throw dice1 finished",(new Date()).toLocaleTimeString())
                dice_stopped[i]=true;
                //            direction_x = new THREE.Vector3( 1, 0, 0 ).applyQuaternion( cube1.quaternion );
                //            direction_y = new THREE.Vector3( 0, 1, 0 ).applyQuaternion( cube1.quaternion );
                //            direction_z = new THREE.Vector3( 0, 0, 1 ).applyQuaternion( cube1.quaternion );
                bodys[i].quaternion.vmult(new CANNON.Vec3( 1, 0, 0 ),direction_x);
                bodys[i].quaternion.vmult(new CANNON.Vec3( 0, 1, 0 ),direction_y);
                bodys[i].quaternion.vmult(new CANNON.Vec3( 0, 0, 1 ),direction_z);
                //!Vec3.prototype.almostEquals = function(v,precision){
                //q.vmult(v)
                if(Math.abs(direction_z.x)<delta&&Math.abs(direction_z.y)<delta&&Math.abs(direction_z.z)>1-delta){
                    if(direction_z.z>0)
                        dice_roll[i]=2;//set_dice(2,0)
                    else
                        dice_roll[i]=5;//set_dice(5,0)
                }

                if(Math.abs(direction_x.x)<delta&&Math.abs(direction_x.y)<delta&&Math.abs(direction_x.z)>1-delta){
                    if(direction_x.z>0)
                        dice_roll[i]=1;//set_dice(1,0)
                    else
                        dice_roll[i]=6;//set_dice(6,0)
                }

                if(Math.abs(direction_y.x)<delta&&Math.abs(direction_y.y)<delta&&Math.abs(direction_y.z)>1-delta){
                    if(direction_y.z>0)
                        dice_roll[i]=3;//set_dice(3,0)
                    else
                        dice_roll[i]=4;//set_dice(4,0)
                }
            }
        }
    }
    //    if(!dice_stopped[1]){
    //        var a = body2.angularVelocity, v = body2.velocity;
    //        if (Math.abs(a.x) < e && Math.abs(a.y) < e && Math.abs(a.z) < e &&
    //                Math.abs(v.x) < e && Math.abs(v.y) < e && Math.abs(v.z) < e) {
    //            cube2.position.copy(body2.position);
    //            cube2.quaternion.copy(body2.quaternion);
    //            //console.log("throw dice2 finished",(new Date()).toLocaleTimeString())
    //            dice_stopped[1]=true;
    ////            direction_x = new THREE.Vector3( 1, 0, 0 ).applyQuaternion( cube2.quaternion );
    ////            direction_y = new THREE.Vector3( 0, 1, 0 ).applyQuaternion( cube2.quaternion );
    ////            direction_z = new THREE.Vector3( 0, 0, 1 ).applyQuaternion( cube2.quaternion );
    //            body2.quaternion.vmult(new CANNON.Vec3( 1, 0, 0 ),direction_x);
    //            body2.quaternion.vmult(new CANNON.Vec3( 0, 1, 0 ),direction_y);
    //            body2.quaternion.vmult(new CANNON.Vec3( 0, 0, 1 ),direction_z);

    //            if(Math.abs(direction_z.x)<delta&&Math.abs(direction_z.y)<delta&&Math.abs(direction_z.z)>1-delta){
    //                if(direction_z.z>0)
    //                    set_dice(0,2)
    //                else
    //                    set_dice(0,5)
    //            }

    //            if(Math.abs(direction_x.x)<delta&&Math.abs(direction_x.y)<delta&&Math.abs(direction_x.z)>1-delta){
    //                if(direction_x.z>0)
    //                    set_dice(0,1)
    //                else
    //                    set_dice(0,6)
    //            }

    //            if(Math.abs(direction_y.x)<delta&&Math.abs(direction_y.y)<delta&&Math.abs(direction_y.z)>1-delta){
    //                if(direction_y.z>0)
    //                    set_dice(0,3)
    //                else
    //                    set_dice(0,4)
    //            }
    //        }
    //    }
    return dice_stopped[0]&&dice_stopped[1];
}
//function set_dice(a,b){
//    if(a>0)dice_roll[0]=a;
//    if(b>0)dice_roll[1]=b;
//}
function get_dice(){
    if(dice_stopped[0]&&dice_stopped[1])
        return dice_roll;
    return null;
}
