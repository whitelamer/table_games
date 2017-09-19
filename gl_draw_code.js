Qt.include("three.js")
//Qt.include("ammo.js")
//Qt.include("gl_logic.js")

var dice1={pos:new THREE.Vector3(),angle:new THREE.Quaternion()};
var dice2={pos:new THREE.Vector3(),angle:new THREE.Quaternion()};
//var transformAux1 = new Ammo.btTransform();
var time = 0;
var armMovement = 0;

function initializeGL(canvas) {
    GLLogic.canvas_obj=canvas
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
    GLLogic.camera = new THREE.PerspectiveCamera(20, cw / ch, 0.1, wh * 1.3);
    GLLogic.camera.position.z = 20;
    GLLogic.camera.position.y = 0;
    GLLogic.camera.position.x = 0;
    //camera.rotation.set(Math.PI/2.0,0.5,0.5);
    GLLogic.camera.lookAt(new THREE.Vector3(0,0,0));
    GLLogic.scene = new THREE.Scene();

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
        GLLogic.cubes[0] = new THREE.Mesh( bufferGeometry, new THREE.MeshFaceMaterial(materials));
        GLLogic.cubes[0].castShadow=true;
        GLLogic.cubes[0].scale.set(1.5, 1.5, 1.5);
        GLLogic.cubes[0].position.set(0.35, 0, 0);
        //cube1.matrixAutoUpdate=true;
        GLLogic.scene.add( GLLogic.cubes[0] );
        GLLogic.cubes[1]=GLLogic.cubes[0].clone();
        GLLogic.cubes[1].castShadow=true;
        GLLogic.cubes[1].position.set(-0.35, 0, 0);
        GLLogic.cubes[1].material=new THREE.MeshFaceMaterial(materials).clone()
        //cube2.material.materials[0].opacity=0.5
        GLLogic.cubes[1].material.materials[0].transparent=true
        GLLogic.scene.add( GLLogic.cubes[1] );
        //!        logic_state=3;
        //!        dice_ready=true;
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
        GLLogic.fishka_obj = new THREE.Mesh( bufferGeometry, new THREE.MeshFaceMaterial(materials));
        GLLogic.fishka_obj.castShadow=false;
        GLLogic.fishka_obj.receiveShadow=true;
        GLLogic.fishka_obj.rotation.set(Math.PI*0.5,0,0);
        var scale=0.60
        GLLogic.fishka_obj.scale.set(scale, scale, scale);
        //fishka_obj.position.set(1.35, 0, 0);
        for(var i=0;i<15;i++){
            //fishka_obj.position.set(3.0, 1.0, 0);
            var obj=GLLogic.fishka_obj.clone()
            obj.color=1
            GLLogic.fishkas_obj.push(obj)
            GLLogic.scene.add(obj);
        }

        GLLogic.fishka_obj.material=new THREE.MeshFaceMaterial(materials).clone()
        GLLogic.fishka_obj.material.materials[0].map=textureCase1;
        for(var i=0;i<15;i++){
            //fishka_obj.position.set(-3.0, -1.0, 0);
            var obj=GLLogic.fishka_obj.clone()
            obj.color=0
            GLLogic.fishkas_obj.push(obj)
            GLLogic.scene.add( obj );
        }
        //!        fiska_ready=true;
        //!        fiskaLoadReady();
    } );

    //var desk_mat =new THREE.MeshPhongMaterial({ color: 0xffffff,transparent: true, depthWrite: false });//,transparent: true, opacity:0.1,,depthTest: false
    var desk_mat =new THREE.ShadowMaterial();//https://github.com/mrdoob/three.js/issues/1791

    desk_mat.opacity = 0.5;
    GLLogic.desk = new THREE.Mesh(new THREE.BoxGeometry(60.8, 30.5, .001), desk_mat);
    GLLogic.desk.position.set(0, 0, 0.0005);
    GLLogic.desk.rotation.set(0,0,0);
    GLLogic.desk.receiveShadow = true;
    GLLogic.scene.add(GLLogic.desk);
    //camera.lookAt(cube.position);

    // Lights
    GLLogic.scene.add(new THREE.AmbientLight(0x808080));

    GLLogic.directionalLight = new THREE.DirectionalLight(0xd0d0d0, 0.75);

    GLLogic.directionalLight.position.y = -6.5;
    GLLogic.directionalLight.position.z = 20.0;
    GLLogic.directionalLight.position.x = -6.5;

    GLLogic.directionalLight.lookAt(new THREE.Vector3(0,0,0));
    //directionalLight.position.normalize();
    GLLogic.directionalLight.castShadow = true;
    GLLogic.directionalLight.distance = 40;
    GLLogic.directionalLight.shadow.camera.near = 0;
    GLLogic.directionalLight.shadow.camera.far = 500;
    GLLogic.directionalLight.shadow.camera.fov = 50;
    GLLogic.directionalLight.shadow.bias = 0.5;
    GLLogic.directionalLight.shadow.mapSize.width = 512;
    GLLogic.directionalLight.shadow.mapSize.height = 512;
    GLLogic.scene.add(GLLogic.directionalLight);
    /*    camera = new THREE.PerspectiveCamera(75, canvas.width / canvas.height, 0.1, 1000);
    camera.position.z = 1.5;


    gl = canvas.getContext("canvas3d", {depth:true, antialias:false, alpha:false});

    renderer = new THREE.Canvas3DRenderer(
                { canvas: canvas, antialias: true, devicePixelRatio: canvas.devicePixelRatio });
    renderer.setSize(canvas.width, canvas.height);*/
    GLLogic.renderer = new THREE.Canvas3DRenderer(
                { canvas: canvas, antialias: true, devicePixelRatio: canvas.devicePixelRatio, alpha: true,antialias: true });
    GLLogic.renderer.shadowMap.enabled = true;
    GLLogic.renderer.shadowMap.type = THREE.PCFSoftShadowMap;
    GLLogic.renderer.setPixelRatio(canvas.devicePixelRatio);
    GLLogic.renderer.setClearColor( 0x000000, 0 );
    GLLogic.renderer.sortObjects = false;
    //renderer.setSize(canvas.height, canvas.width);

    GLLogic.renderer.setSize(canvas.width, canvas.height);
}

function resizeGL(canvas) {
    //if (GLLogic.camera === undefined) return;

    GLLogic.camera.aspect = canvas.width / canvas.height;
    GLLogic.camera.updateProjectionMatrix();

    //GLLogic.renderer.setPixelRatio(canvas.devicePixelRatio);
    GLLogic.renderer.setSize(canvas.width, canvas.height);
    console.log("camera",GLLogic.camera);
}

function paintGL(canvas) {
    //var timeStep   = 1/180;
    if(GLLogic.canvas_obj.showdrop&&GLLogic.world!=null){
        GLLogic.world.step(1/60);
        // Copy coordinates from Cannon.js to Three.js
        for(var i=0;i<2;i++){
            if(GLLogic.cubes[i]){
                GLLogic.cubes[i].position.copy(GLLogic.bodys[i].position);
                GLLogic.cubes[i].quaternion.copy(GLLogic.bodys[i].quaternion);
                //cube1.material.materials[0].opacity=op_dice1;
                //cube1.material.materials[1].opacity=op_dice1;
            }
        }
    }
    //    if(GLLogic.cube2){
    //        if(GLLogic.canvas_obj.showdrop&&GLLogic.world!=null){
    //            GLLogic.cube2.position.copy(GLLogic.body2.position);
    //            GLLogic.cube2.quaternion.copy(GLLogic.body2.quaternion);
    //        }
    //    }
    GLLogic.renderer.render(GLLogic.scene, GLLogic.camera);
}
