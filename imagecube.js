Qt.include("three.js")
//Qt.include("ammo.js")
Qt.include("cannon.js")

var camera, scene, renderer;
var cube1,cube2,desk,desk_mat;
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
        console.log(bufferGeometry.boundingBox.min.x,bufferGeometry.boundingBox.max.x);
        var mater = [];
        cube1 = new THREE.Mesh( bufferGeometry, new THREE.MeshFaceMaterial(materials));
        cube1.castShadow=true;
        cube1.scale.set(1.5, 1.5, 1.5);
        cube1.position.set(0.35, 0, 0);
        //cube1.matrixAutoUpdate=true;
        scene.add( cube1 );
//        cube2=cube1.clone();
//        cube2.castShadow=true;
//        cube2.position.set(-0.35, 0, 0);
//        scene.add( cube2 );
        //bullet.start();
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
    scene.add(new THREE.AmbientLight(0x444444));

    directionalLight = new THREE.DirectionalLight(0xffffff, 0.9);

    directionalLight.position.y = 4.5;
    directionalLight.position.z = 7.0;
    directionalLight.position.x = 2.5;
    directionalLight.position.normalize();
    directionalLight.castShadow = true;
    directionalLight.distance = 50;
    directionalLight.shadow.camera.near = 0;
    directionalLight.shadow.camera.far = 500;
    directionalLight.shadow.camera.fov = 50;
    directionalLight.shadow.bias = 0.5;
    directionalLight.shadow.mapSize.width = 1024;
    directionalLight.shadow.mapSize.height = 1024;
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
    if(canvas.width<canvas.height)
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

    var barrier = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), Math.PI / 2);
    barrier.position.set(0, 1.8, 0);
    world.addBody(barrier);

    barrier = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), -Math.PI / 2);
    barrier.position.set(0, -1.8, 0);
    world.addBody(barrier);

    barrier = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(0, 1, 0), -Math.PI / 2);
    barrier.position.set(3.42, 0, 0);
    world.addBody(barrier);

    barrier = new CANNON.Body({mass:0, shape:new CANNON.Plane(), material:barrier_body_material});
    barrier.quaternion.setFromAxisAngle(new CANNON.Vec3(0, 1, 0), Math.PI / 2);
    barrier.position.set(-3.42, 0, 0);
    world.addBody(barrier);
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

    body1.position= new CANNON.Vec3((vector_start.y*3.42)*2-3.42+0.35, vector_start.x*1.8*2-1.8, 4.0);
    body2.position= new CANNON.Vec3((vector_start.y*3.42)*2-3.42-0.35, vector_start.x*1.8*2-1.8, 4.0);

    body1.velocity=new CANNON.Vec3(vector.y*5, vector.x*5, 0);
    body2.velocity=new CANNON.Vec3(vector.y*5, vector.x*5, 0);
    body1.angularVelocity.set(Math.floor(Math.random()*20),Math.floor(Math.random()*10),Math.floor(Math.random()*15));
    body2.angularVelocity.set(Math.floor(Math.random()*20),Math.floor(Math.random()*10),Math.floor(Math.random()*15));


    dice1.pos.copy(body1.position);
    dice2.pos.copy(body2.position);
    dice1.angle.copy(body1.quaternion);
    dice2.angle.copy(body2.quaternion);
    dice1.dice_stopped=false;
    dice2.dice_stopped=false;
    //,angle:new THREE.Quaternion()};
    //var dice2={pos:new THREE.Vec3(),angle:new THREE.Quaternion()};
    console.log("Start drop:",(new Date()).toLocaleTimeString())
    showdrop = true;
}
function is_throw_finished(){
    var e=.01;
    if(!dice1.dice_stopped){
        var a = body1.angularVelocity, v = body1.velocity;
        if (Math.abs(a.x) < e && Math.abs(a.y) < e && Math.abs(a.z) < e &&
                Math.abs(v.x) < e && Math.abs(v.y) < e && Math.abs(v.z) < e) {
            console.log("throw dice1 finished",(new Date()).toLocaleTimeString())
            dice1.dice_stopped=true;
            console.log(cube1.quaternion.x,cube1.quaternion.y,cube1.quaternion.z,cube1.quaternion.w)
            console.log(cube1.rotation.x,cube1.rotation.y,cube1.rotation.z)
            /*

qml: 0.9384128702184783 0.3455159692488641 -0.0000014579469734090158 4.5843683808116274e-7
qml: 3.1415907856958363 -0.0000024195178411924604 -0.7055771129296992

qml: -0.9044742987149188 -0.42652812681190955 0.0000014626380636884039 -5.833275484592096e-7
qml: 3.1415903506678085 -0.0000021482258034682823 -0.8813014825481775


qml: -3.0411137184797285e-8 -0.0000015352297887617028 0.09615933547324441 -0.9953659539079014
qml: 3.557937873210753e-7 0.0000030503822472430342 -0.19261629084790197


            qml: 0.6845736199163348 0.17708511910562263 -0.6845733869018092 0.17708500064031132
            qml: > x: 1.570797071236766 [number]
            qml: > y: -1.0645349506375534 [number]
            qml: > z: -1.5707957554028598 [number]
            */
            //debug(cube1.rotation)
        }
    }
    if(!dice2.dice_stopped){
        var a = body2.angularVelocity, v = body2.velocity;
        if (Math.abs(a.x) < e && Math.abs(a.y) < e && Math.abs(a.z) < e &&
                Math.abs(v.x) < e && Math.abs(v.y) < e && Math.abs(v.z) < e) {
            console.log("throw dice2 finished",(new Date()).toLocaleTimeString())
            dice2.dice_stopped=true;
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

    if(cube1&&showdrop){
        cube1.position.copy(body1.position);
        cube1.quaternion.copy(body1.quaternion);
    }
    if(cube2&&showdrop){
        cube2.position.copy(body2.position);
        cube2.quaternion.copy(body2.quaternion);
    }

    renderer.render(scene, camera);
//    if(showdrop && is_throw_finished()){
//        showdrop=!is_throw_finished();
//        console.log("throw_finished")
//    }
    //desk_mat.alphaMap=directionalLight.shadow.camera.map
}
