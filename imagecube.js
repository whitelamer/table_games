Qt.include("three.js")
//Qt.include("cannon.js")

var camera, scene, renderer;
var cube1,cube2;
var pointLight;
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
    //camera = new THREE.OrthographicCamera( canvas.width / - 2, canvas.width / 2, canvas.height / 2, canvas.height / - 2, 1, 1000 );
    var wh = ch / aspect / Math.tan(10 * Math.PI / 180);
    camera = new THREE.PerspectiveCamera(75, cw / ch, 0.1, wh * 1.3);


    camera.position.z = 0;
    camera.position.y = 5;
    camera.position.x = 0;
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
        cube1.scale.set(2.0, 2.0, 2.0);
        cube1.position.set(0.35, 0, 0);

        scene.add( cube1 );
        cube2=cube1.clone();
        cube2.position.set(-0.35, 0, 0);
        scene.add( cube2 );
        bullet.start();
    } );

    var desk = new THREE.Mesh(new THREE.PlaneGeometry(2, 2, 1, 1), new THREE.MeshPhongMaterial({ color: 0xdfdfdf }));
    desk.position.set(0, 0, 0);
    desk.rotation.set(45,0,90);
    desk.receiveShadow = true;
    scene.add(desk);
    //camera.lookAt(cube.position);

    // Lights
    scene.add(new THREE.AmbientLight(0x444444));

    var directionalLight = new THREE.DirectionalLight(0xffffff, 0.9);

    directionalLight.position.y = 7.0;
    directionalLight.position.z = 2.5;
    directionalLight.position.x = 2.5;
    directionalLight.position.normalize();
    scene.add(directionalLight);
    /*    camera = new THREE.PerspectiveCamera(75, canvas.width / canvas.height, 0.1, 1000);
    camera.position.z = 1.5;


    gl = canvas.getContext("canvas3d", {depth:true, antialias:false, alpha:false});

    renderer = new THREE.Canvas3DRenderer(
                { canvas: canvas, antialias: true, devicePixelRatio: canvas.devicePixelRatio });
    renderer.setSize(canvas.width, canvas.height);*/
    renderer = new THREE.Canvas3DRenderer(
                { canvas: canvas, antialias: true, devicePixelRatio: canvas.devicePixelRatio, alpha: true });
    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFShadowMap;
    renderer.setPixelRatio(canvas.devicePixelRatio);
    renderer.setClearColor( 0x000000, 0 );
    renderer.setSize(canvas.width, canvas.height);


    /*var world = new CANNON.World();
    world.gravity.set(0, 0, -9.82); // m/s²

    // Create a sphere
    var radius = 1; // m
    var sphereBody = new CANNON.Body({
       mass: 5, // kg
       position: new CANNON.Vec3(0, 0, 10), // m
       shape: new CANNON.Sphere(radius)
    });
    world.addBody(sphereBody);

    // Create a plane
    var groundBody = new CANNON.Body({
        mass: 0 // mass == 0 makes the body static
    });
    var groundShape = new CANNON.Plane();
    groundBody.addShape(groundShape);
    world.addBody(groundBody);
*/
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

function resizeGL(canvas) {
    if (camera === undefined) return;

    camera.aspect = canvas.width / canvas.height;
    camera.updateProjectionMatrix();

    renderer.setPixelRatio(canvas.devicePixelRatio);
    renderer.setSize(canvas.width, canvas.height);
}

function paintGL(canvas) {
    if(cube1){
        var pos=bullet.getCube1pos();
        var quat=bullet.getCube1quat();
        var rot=bullet.getCube1rot();
        //console.log(pos,quat,rot);
        cube1.position.set(pos.x,pos.y,pos.z);
        //cube1.quaternion.set(quat.x,quat.y,quat.z,quat.w)
        cube1.rotation.set(rot.x,rot.y,rot.z);

    }
    if(cube2){
        var pos=bullet.getCube2pos();
        var quat=bullet.getCube2quat();
        var rot=bullet.getCube2rot();
        cube2.position.set(pos.x,pos.y,pos.z);
        //cube2.quaternion.set(quat.x,quat.y,quat.z,quat.w)
        cube2.rotation.set(rot.x,rot.y,rot.z);
        //cube2.rotation.set(canvas.xR2 * Math.PI / 180,canvas.yR2 * Math.PI / 180,canvas.zR2 * Math.PI / 180);
    }
    renderer.render(scene, camera);
}
