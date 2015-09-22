# ----------------------------------------------------------
# HELPERS
# ----------------------------------------------------------

getRandomInt = (min, max)->
	rand = Math.floor(Math.random() * (max - min + 1)) + min
	return rand


BODY = document.body

# BODY.onload = ->

container = document.createElement 'div'
BODY.appendChild container

W = parseInt window.innerWidth
H = parseInt window.innerHeight

CAMERA 	= new THREE.PerspectiveCamera 45, W/H, 1, 10000
CAMERA.position.z = 2300

SCENE 	= new THREE.Scene()


# EARH
cubeGeo = new THREE.CubeGeometry 600, 600, 600
cubeMat = new THREE.MeshNormalMaterial()
cube 		= new THREE.Mesh cubeGeo, cubeMat


cubeTexture = new THREE.Texture()
loader = new THREE.ImageLoader()
loader.addEventListener 'load', (e)->
	cubeTexture.image = e.content
	cubeTexture.needsUpdate = true


SCENE.add cube

# --------------------------------------------------------
# WEBGL / CANVAS
# --------------------------------------------------------

webglAvailable = ->
	try
		canvas = document.createElement 'canvas'
		return !!(window.WebGLRenderingContext && (canvas.getContext( 'webgl' ) || canvas.getContext( 'experimental-webgl' ) ))
	catch e
		return false

if webglAvailable()
	RENDER = new THREE.WebGLRenderer()
else
	RENDER = new THREE.CanvasRenderer()

RENDER.setSize W, H

container.appendChild RENDER.domElement

t = 0
y = 0

document.addEventListener 'mousemove', (e)->
	y = parseInt e.offsetY

# -------------------------------------------------------
# ANIMATE
# -------------------------------------------------------

animate = ->
	requestAnimationFrame animate
	cube.rotation.y += 0.01
	cube.rotation.x += 0.01
	RENDER.render SCENE, CAMERA
animate()