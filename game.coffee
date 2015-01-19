# entry point
window.onload = () ->
	WIDTH = 640
	HEIGHT = 480
	
	Crafty.init(WIDTH, HEIGHT)
	Crafty.viewport.init(WIDTH, HEIGHT)
	Crafty.viewport.bounds = {min:{x:0, y:0}, max:{x:+Infinity, y:480}};
	Crafty.settings.modify('autoPause', true)
	loadScene('play')

loadScene = (sceneName) ->
	console.log("Running loadScene with" + sceneName)

	#Crafty.audio stop all

	#reset persistent data (probably just points?) ??
	#  this could be done on SceneDestroy event

	#any other cleanup checking to be done here?
	#  this could be done on SceneDestroy event (most likely)


	Crafty.scene(sceneName)
