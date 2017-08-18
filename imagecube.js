Qt.include("three.js")
//Qt.include("ammo.js")
Qt.include("cannon.js")

var camera, scene, renderer;
var cube1,cube2,desk,desk_mat,    fishka_obj;
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
var margin = 0.05;
var hinge;
var rope;
var world;
var sphere;
var body1;
var body2;

var dice1={pos:new THREE.Vector3(),angle:new THREE.Quaternion()};
var dice2={pos:new THREE.Vector3(),angle:new THREE.Quaternion()};
//var transformAux1 = new Ammo.btTransform();
var time = 0;
var armMovement = 0;

function initializeGL(canvas) {
    var cw =  canvas.width / 2;
    var ch =  canvas.height / 2;
    var w = cw;
    var h = ch;
    var aspect = Math.min(cw / w, ch / h);
    var scale = Math.sqrt(w * w + h * h) / 13;
    //camera = new THREE.OrthographicCamera( - d * aspect, d * aspect, d, - d, 0.1, 1000 );
    //camera = new THREE.OrthographicCamera(  -1.8, 1.8, 3.45, -3.45, 1, 100 );
    //camera = new THREE.OrthographicCamera( 3.45, -3.45, -1.8, 1.8, .1, 1000 );
    var wh = ch / aspect / Math.tan(10 * Math.PI / 180);
    camera = new THREE.PerspectiveCamera(20, cw / ch, 0.1, wh * 1.3);


    camera.position.z = 20;
    camera.position.y = 0;
    camera.position.x = 0;
    //camera.rotation.set(Math.PI/2.0,0.5,0.5);
    camera.lookAt(new THREE.Vector3(0,0,0));


    scene = new THREE.Scene();
    //scene = new Physijs.Scene({ fixedTimeStep: 1 / 120 });
    //    scene.setGravity(new THREE.Vector3( 0, -30, 0 ));
    //    scene.addEventListener(
    //                'update',
    //                function() {
    //                    scene.simulate( undefined, 2 );
    //                    physics_stats.update();
    //                }
    //            );

    //    var ground_geometry = new THREE.PlaneGeometry( 75, 75, 50, 50 );
    //    var ground = new Physijs.HeightfieldMesh(
    //        ground_geometry,
    //        new THREE.MeshPhongMaterial( { color: 0xFFFFFF } ),
    //        0, // mass
    //        50,
    //        50
    //    );
    //    ground.receiveShadow = true;
    //    scene.add( ground );
    // Load textures
    /*var textureLoader = new THREE.TextureLoader();
    var textureCase1 = textureLoader.load(canvas.image1);
    var textureCase2 = textureLoader.load(canvas.image2);
    var textureCase3 = textureLoader.load(canvas.image3);
    var textureCase4 = textureLoader.load(canvas.image4);
    var textureCase5 = textureLoader.load(canvas.image5);
    var textureCase6 = textureLoader.load(canvas.image6);

    // Materials
    var materials = [];
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase1 }));
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase1 }));
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase3 }));
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase3 }));
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase5 }));
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase5 }));
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase6 }));
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase6 }));
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase4 }));
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase4 }));
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase2 }));
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase2 }));*/

    // Box geometry to be broken down for MeshFaceMaterial
    /*var geometry = new THREE.BoxGeometry(100, 100, 100);
    for (var i = 0, len = geometry.faces.length; i < len; i ++) {
        geometry.faces[ i ].materialIndex = i;
    }
    geometry.materials = materials;
    var faceMaterial = new THREE.MeshFaceMaterial(materials);*/



    //var smooth = THREE.GeometryUtils.clone( geometry );
    //smooth.mergeVertices();
    //    geometry.mergeVertices();
    //    var subdiv = 2;
    //    var modifier = new THREE.SubdivisionModifier(subdiv);
    //    modifier.modify( geometry );

    /*cube = new THREE.Mesh(geometry, faceMaterial);
    cube.receiveShadow = true;
    cube.castShadow = true;

    scene.add(cube);*/
    //var gl = canvas.getContext("canvas3d", {depth:true, antialias:false, alpha:false});
    //gl.clearColor(0.98, 0.98, 0.98, 1.0);
    //gl.clearDepth(1.0);
    var loader = new THREE.JSONLoader();
    loader.useBufferGeometry = true;

    loader.load( "./untitled.json", function ( geometry, materials) {
        geometry.computeVertexNormals();
        var bufferGeometry = new THREE.BufferGeometry();
        bufferGeometry.fromGeometry(geometry);
        bufferGeometry.computeBoundingBox();
        //console.log(bufferGeometry.boundingBox.min.x,bufferGeometry.boundingBox.max.x);
        var mater = [];
        materials[0].transparent=true
        materials[1].transparent=true
        cube1 = new THREE.Mesh( bufferGeometry, new THREE.MeshFaceMaterial(materials));
        cube1.castShadow=true;
        cube1.scale.set(1.5, 1.5, 1.5);
        cube1.position.set(0.35, 0, 0);
        //cube1.matrixAutoUpdate=true;
        scene.add( cube1 );
        cube2=cube1.clone();
        cube2.castShadow=true;
        cube2.position.set(-0.35, 0, 0);
        cube2.material=new THREE.MeshFaceMaterial(materials).clone()
        //cube2.material.materials[0].opacity=0.5
        cube2.material.materials[0].transparent=true
        scene.add( cube2 );
        logic_state=3;
        dice_ready=true;
        chk_ready();
        //bullet.start();
    } );


    var fishkaloader = new THREE.JSONLoader();
    fishkaloader.useBufferGeometry = true;

    fishkaloader.load( "./fishka_new.json", function ( geometry, materials) {//_small2
        geometry.computeVertexNormals();
        var bufferGeometry = new THREE.BufferGeometry();
        bufferGeometry.fromGeometry(geometry);
        bufferGeometry.computeBoundingBox();
        var textureLoader = new THREE.TextureLoader();
        var textureCase1 = textureLoader.load("img/ww_.png");
        var textureCase2 = textureLoader.load("img/bb_.png");
        materials[0].map=textureCase2;
        //console.log(bufferGeometry.boundingBox.min.x,bufferGeometry.boundingBox.max.x);
        fishka_obj = new THREE.Mesh( bufferGeometry, new THREE.MeshFaceMaterial(materials));
        fishka_obj.castShadow=false;
        fishka_obj.receiveShadow=true;
        fishka_obj.rotation.set(Math.PI*0.5,0,0);
        var scale=0.60
        fishka_obj.scale.set(scale, scale, scale);
        //fishka_obj.position.set(1.35, 0, 0);
        for(var i=0;i<15;i++){
            //fishka_obj.position.set(3.0, 1.0, 0);
            fishkas_obj.push(fishka_obj.clone())
            scene.add( fishkas_obj[i] );
        }

        fishka_obj.material=new THREE.MeshFaceMaterial(materials).clone()
        fishka_obj.material.materials[0].map=textureCase1;
        for(var i=0;i<15;i++){
            //fishka_obj.position.set(-3.0, -1.0, 0);
            fishkas_obj.push(fishka_obj.clone())
            scene.add( fishkas_obj[15+i] );
        }
        fiska_ready=true;
        chk_ready();
    } );

    //desk_mat =new THREE.MeshPhongMaterial({ color: 0xffffff,transparent: true, depthWrite: false });//,transparent: true, opacity:0.1,,depthTest: false
    desk_mat =new THREE.ShadowMaterial();//https://github.com/mrdoob/three.js/issues/1791

    desk_mat.opacity = 0.5;
    desk = new THREE.Mesh(new THREE.BoxGeometry(60.8, 30.5, .001), desk_mat);
    desk.position.set(0, 0, 0.0005);
    desk.rotation.set(0,0,0);
    desk.receiveShadow = true;
    scene.add(desk);
    //camera.lookAt(cube.position);

    // Lights
    scene.add(new THREE.AmbientLight(0x808080));

    directionalLight = new THREE.DirectionalLight(0xd0d0d0, 0.75);

    directionalLight.position.y = -6.5;
    directionalLight.position.z = 20.0;
    directionalLight.position.x = -6.5;

    directionalLight.lookAt(new THREE.Vector3(0,0,0));
    //directionalLight.position.normalize();
    directionalLight.castShadow = true;
    directionalLight.distance = 40;
    directionalLight.shadow.camera.near = 0;
    directionalLight.shadow.camera.far = 500;
    directionalLight.shadow.camera.fov = 50;
    directionalLight.shadow.bias = 0.5;
    directionalLight.shadow.mapSize.width = 512;
    directionalLight.shadow.mapSize.height = 512;
    scene.add(directionalLight);
    /*    camera = new THREE.PerspectiveCamera(75, canvas.width / canvas.height, 0.1, 1000);
    camera.position.z = 1.5;


    gl = canvas.getContext("canvas3d", {depth:true, antialias:false, alpha:false});

    renderer = new THREE.Canvas3DRenderer(
                { canvas: canvas, antialias: true, devicePixelRatio: canvas.devicePixelRatio });
    renderer.setSize(canvas.width, canvas.height);*/
    renderer = new THREE.Canvas3DRenderer(
                { canvas: canvas, antialias: true, devicePixelRatio: canvas.devicePixelRatio, alpha: true,antialias: true });
    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFSoftShadowMap;
    renderer.setPixelRatio(canvas.devicePixelRatio);
    renderer.setClearColor( 0x000000, 0 );
    renderer.sortObjects = false;
    //renderer.setSize(canvas.height, canvas.width);

    renderer.setSize(canvas.width, canvas.height);
    if(canvas.orientation)
        camera.rotation.z=+Math.PI/2;

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
    var barrier;
    barrier = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), Math.PI / 2);
    barrier.position.set(0, phy_axis_y2, 0);
    world.addBody(barrier);

//    barrier = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
//    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), -Math.PI / 2);
//    barrier.position.set(0, phy_axis_y1, 0);
//    world.addBody(barrier);

    barrier = new CANNON.Body({mass:0, shape:new CANNON.Box(new CANNON.Vec3(phy_axis_x*2, phy_axis_y1,20.0)), material:barrier_body_material});
    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), 0);
    //barrier.position.set(phy_axis_x*2, phy_axis_y1*2, 0);
    world.addBody(barrier);


    barrier = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), -Math.PI / 2);
    barrier.position.set(0, -phy_axis_y2, 0);
    world.addBody(barrier);

//    barrier = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
//    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), Math.PI / 2);
//    barrier.position.set(0, -phy_axis_y1, 0);
//    world.addBody(barrier);

    barrier = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(0, 1, 0), -Math.PI / 2);
    barrier.position.set(phy_axis_x, 0, 0);
    world.addBody(barrier);

    barrier = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(0, 1, 0), Math.PI / 2);
    barrier.position.set(-phy_axis_x, 0, 0);
    world.addBody(barrier);


    /*var wall = new THREE.Mesh(new THREE.BoxGeometry(10, 10, .01), new THREE.MeshPhongMaterial({ color: 0xffffff,transparent: true, opacity:0.8 }));
    wall.rotation.set(0,-Math.PI / 2,0);
    wall.position.set(phy_axis_x, 0, 0);
    scene.add(wall);

    wall = new THREE.Mesh(new THREE.BoxGeometry(10, 10, .01), new THREE.MeshPhongMaterial({ color: 0xffffff,transparent: true, opacity:0.8 }));
    wall.rotation.set(0,Math.PI / 2,0);
    wall.position.set(-phy_axis_x, 0, 0);
    scene.add(wall);



    var wall = new THREE.Mesh(new THREE.BoxGeometry(10, 10, .01), new THREE.MeshPhongMaterial({ color: 0xffffff,transparent: true, opacity:0.8 }));
    wall.rotation.set(-Math.PI / 2,0,0);
    wall.position.set(0, -phy_axis_y2, 0);
    scene.add(wall);

    wall = new THREE.Mesh(new THREE.BoxGeometry(10, 10, .01), new THREE.MeshPhongMaterial({ color: 0xffffff,transparent: true, opacity:0.8 }));
    wall.rotation.set(Math.PI / 2,0,0);
    wall.position.set(0, -phy_axis_y1, 0);
    scene.add(wall);*/
    //    var groundBody = new CANNON.Body({
    //                                         mass: 0 // mass == 0 makes the body static
    //                                     });
    //    var groundShape = new CANNON.Plane();
    //    groundBody.addShape(groundShape);
    //    world.addBody(groundBody);




    //////////////////////////////////////////////////////////////////DICE1
    sphere = new CANNON.Box(new CANNON.Vec3(.15,.15,.15));
    body1 = new CANNON.Body({
                                mass: 5,
                                //position: new CANNON.Vec3(0.35, 0, 1.5), // m
                                //velocity:new CANNON.Vec3(10.25, 10, 0)
                            });
    body1.addShape(sphere);
    //body1.angularVelocity.set(10,2,1);
    body1.angularDamping = 0.5;
    world.addBody(body1);


    //////////////////////////////////////////////////////////////////DICE2
    sphere = new CANNON.Box(new CANNON.Vec3(.15,.15,.15));
    body2 = new CANNON.Body({
                                mass: 5,
                                //position: new CANNON.Vec3(-0.35, 0, 1.9), // m
                                //velocity:new CANNON.Vec3(-10.25, -10, 0)
                            });
    body2.addShape(sphere);
    //body2.angularVelocity.set(1,5,10);
    body2.angularDamping = 0.5;
    world.addBody(body2);
    gl_ready=true;
    chk_ready();
    //dropDice();
}

function initPhysics() {
    //    // Physics configuration
    //    collisionConfiguration = new Ammo.btSoftBodyRigidBodyCollisionConfiguration();
    //    dispatcher = new Ammo.btCollisionDispatcher( collisionConfiguration );
    //    broadphase = new Ammo.btDbvtBroadphase();
    //    solver = new Ammo.btSequentialImpulseConstraintSolver();
    //    softBodySolver = new Ammo.btDefaultSoftBodySolver();
    //    physicsWorld = new Ammo.btSoftRigidDynamicsWorld( dispatcher, broadphase, solver, collisionConfiguration, softBodySolver);
    //    physicsWorld.setGravity( new Ammo.btVector3( 0, -6, 0 ) );
    //    physicsWorld.getWorldInfo().set_m_gravity( new Ammo.btVector3( 0, -6, 0 ) );
}
function dropDice(vector,vector_start){
//    body1.position= new CANNON.Vec3(0.35, 0, 2.0);
//    body2.position= new CANNON.Vec3(-0.35, 0, 2.0);
    cube1.material.materials[0].opacity=op_dice1;
    cube2.material.materials[0].opacity=op_dice2;
    cube1.material.materials[1].opacity=op_dice1;
    cube2.material.materials[1].opacity=op_dice2;

    //body1.position= new CANNON.Vec3((vector_start.y*3.42)*2-3.42+0.35, vector_start.x*1.8*2-1.8, 4.0);
    //body2.position= new CANNON.Vec3((vector_start.y*3.42)*2-3.42-0.35, vector_start.x*1.8*2-1.8, 4.0);

    body1.position= new CANNON.Vec3(vector_start.x+0.35, vector_start.y, 4.0);
    body2.position= new CANNON.Vec3(vector_start.x-0.35, vector_start.y, 4.0);
    var tmp=new CANNON.Vec3(vector.x*2, vector.y*2, 0);

    //body1.position.vsub(tmp,tmp);
    tmp.vsub(body1.position,tmp);

    body1.velocity=tmp;//new CANNON.Vec3(vector.x, vector.y, 0);
    body2.velocity=tmp.clone();//new CANNON.Vec3(vector.x, vector.y, 0);

    //body1.angularVelocity.set(5,5,5);
    //body2.angularVelocity.set(5,5,5);

    body1.angularVelocity.set(Math.floor(Math.random()*20)+5,Math.floor(Math.random()*10)+5,Math.floor(Math.random()*15)+5);
    body2.angularVelocity.set(Math.floor(Math.random()*20)+5,Math.floor(Math.random()*10)+5,Math.floor(Math.random()*15)+5);


    dice1.pos.copy(body1.position);
    dice2.pos.copy(body2.position);
    dice1.angle.copy(body1.quaternion);
    dice2.angle.copy(body2.quaternion);
    dice1.dice_stopped=false;
    dice2.dice_stopped=false;
    //,angle:new THREE.Quaternion()};
    //var dice2={pos:new THREE.Vec3(),angle:new THREE.Quaternion()};
    //console.log("Start drop:",(new Date()).toLocaleTimeString())
    showdrop = true;
}
function is_throw_finished(){
    var e=.01;
    var direction_x,direction_y,direction_z;
    if(!dice1.dice_stopped){
        var a = body1.angularVelocity, v = body1.velocity;
        if (Math.abs(a.x) < e && Math.abs(a.y) < e && Math.abs(a.z) < e &&
                Math.abs(v.x) < e && Math.abs(v.y) < e && Math.abs(v.z) < e) {
            cube1.position.copy(body1.position);
            cube1.quaternion.copy(body1.quaternion);
            //console.log("throw dice1 finished",(new Date()).toLocaleTimeString())
            dice1.dice_stopped=true;
            direction_x = new THREE.Vector3( 1, 0, 0 ).applyQuaternion( cube1.quaternion );
            direction_y = new THREE.Vector3( 0, 1, 0 ).applyQuaternion( cube1.quaternion );
            direction_z = new THREE.Vector3( 0, 0, 1 ).applyQuaternion( cube1.quaternion );

            if(Math.abs(direction_z.x)<0.001&&Math.abs(direction_z.y)<0.001&&Math.abs(direction_z.z)>0.998){
                if(direction_z.z>0)
                    set_dice(2,0)
                else
                    set_dice(5,0)
            }

            if(Math.abs(direction_x.x)<0.001&&Math.abs(direction_x.y)<0.001&&Math.abs(direction_x.z)>0.998){
                if(direction_x.z>0)
                    set_dice(1,0)
                else
                    set_dice(6,0)
            }

            if(Math.abs(direction_y.x)<0.001&&Math.abs(direction_y.y)<0.001&&Math.abs(direction_y.z)>0.998){
                if(direction_y.z>0)
                    set_dice(3,0)
                else
                    set_dice(4,0)
            }
        }
    }
    if(!dice2.dice_stopped){
        var a = body2.angularVelocity, v = body2.velocity;
        if (Math.abs(a.x) < e && Math.abs(a.y) < e && Math.abs(a.z) < e &&
                Math.abs(v.x) < e && Math.abs(v.y) < e && Math.abs(v.z) < e) {
            cube2.position.copy(body2.position);
            cube2.quaternion.copy(body2.quaternion);
            //console.log("throw dice2 finished",(new Date()).toLocaleTimeString())
            dice2.dice_stopped=true;
            direction_x = new THREE.Vector3( 1, 0, 0 ).applyQuaternion( cube2.quaternion );
            direction_y = new THREE.Vector3( 0, 1, 0 ).applyQuaternion( cube2.quaternion );
            direction_z = new THREE.Vector3( 0, 0, 1 ).applyQuaternion( cube2.quaternion );

            if(Math.abs(direction_z.x)<0.001&&Math.abs(direction_z.y)<0.001&&Math.abs(direction_z.z)>0.998){
                if(direction_z.z>0)
                    set_dice(0,2)
                else
                    set_dice(0,5)
            }

            if(Math.abs(direction_x.x)<0.001&&Math.abs(direction_x.y)<0.001&&Math.abs(direction_x.z)>0.998){
                if(direction_x.z>0)
                    set_dice(0,1)
                else
                    set_dice(0,6)
            }

            if(Math.abs(direction_y.x)<0.001&&Math.abs(direction_y.y)<0.001&&Math.abs(direction_y.z)>0.998){
                if(direction_y.z>0)
                    set_dice(0,3)
                else
                    set_dice(0,4)
            }
        }
    }
    return dice1.dice_stopped&&dice2.dice_stopped;
}

function resizeGL(canvas) {
    if (camera === undefined) return;

    camera.aspect = canvas.width / canvas.height;
    camera.updateProjectionMatrix();

    renderer.setPixelRatio(canvas.devicePixelRatio);
    renderer.setSize(canvas.width, canvas.height);
}

function paintGL(canvas) {
    //var timeStep   = 1/180;
    if(showdrop)world.step(1/60);
    // Copy coordinates from Cannon.js to Three.js

    if(cube1){
        if(showdrop){
        cube1.position.copy(body1.position);
        cube1.quaternion.copy(body1.quaternion);
        }
        cube1.material.materials[0].opacity=op_dice1;
        cube1.material.materials[1].opacity=op_dice1;
    }
    if(cube2){
        if(showdrop){
            cube2.position.copy(body2.position);
            cube2.quaternion.copy(body2.quaternion);
        }
        cube2.material.materials[0].opacity=op_dice2;
        cube2.material.materials[1].opacity=op_dice2;
    }
    renderer.render(scene, camera);
//    if(showdrop && is_throw_finished()){
//        showdrop=!is_throw_finished();
//        console.log("throw_finished")
//    }
    //desk_mat.alphaMap=directionalLight.shadow.camera.map
}
function hide_dice1(){
    cube1.position.set(999,999,999);
}
function hide_dice2(){
    cube2.position.set(999,999,999);
}
