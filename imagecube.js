Qt.include("three.js")

var camera, scene, renderer;
var cube;
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
    var aspect = canvas.width / canvas.height;
    var d = 200;
    camera = new THREE.OrthographicCamera( - d * aspect, d * aspect, d, - d, 0.1, 1000 );
    //camera = new THREE.OrthographicCamera( canvas.width / - 2, canvas.width / 2, canvas.height / 2, canvas.height / - 2, 1, 1000 );
    //camera = new THREE.PerspectiveCamera(50, canvas.width / canvas.height, 1, 2000);
    camera.position.z = 650;
    camera.position.x = 100;

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
    var textureLoader = new THREE.TextureLoader();
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
    materials.push(new THREE.MeshLambertMaterial({ map: textureCase2 }));

    // Box geometry to be broken down for MeshFaceMaterial
    var geometry = new THREE.BoxGeometry(100, 100, 100);
    for (var i = 0, len = geometry.faces.length; i < len; i ++) {
        geometry.faces[ i ].materialIndex = i;
    }
    geometry.materials = materials;
    var faceMaterial = new THREE.MeshFaceMaterial(materials);

    //var smooth = THREE.GeometryUtils.clone( geometry );
    //smooth.mergeVertices();
    //    geometry.mergeVertices();
    //    var subdiv = 2;
    //    var modifier = new THREE.SubdivisionModifier(subdiv);
    //    modifier.modify( geometry );

    cube = new THREE.Mesh(geometry, faceMaterial);
    cube.receiveShadow = true;
    cube.castShadow = true;

    scene.add(cube);

    camera.lookAt(cube.position);

    // Lights
    scene.add(new THREE.AmbientLight(0x444444));

    var directionalLight = new THREE.DirectionalLight(0xffffff, 0.9);

    directionalLight.position.y = 130;
    directionalLight.position.z = 700;
    directionalLight.position.x = Math.tan(canvas.angleOffset) * directionalLight.position.z;
    directionalLight.position.normalize();
    scene.add(directionalLight);

    renderer = new THREE.Canvas3DRenderer(
                { canvas: canvas, antialias: true, devicePixelRatio: canvas.devicePixelRatio, alpha: true });
    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFShadowMap;
    renderer.setPixelRatio(canvas.devicePixelRatio);
    renderer.setClearColor( 0x000000, 0 );
    renderer.setSize(canvas.width, canvas.height);
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
    cube.rotation.x = canvas.xRotation * Math.PI / 180;
    cube.rotation.y = canvas.yRotation * Math.PI / 180;
    cube.rotation.z = canvas.zRotation * Math.PI / 180;
    cube.scale.z = canvas.scale;
    cube.scale.x = canvas.scale;
    cube.scale.y = canvas.scale;
    renderer.render(scene, camera);
}
