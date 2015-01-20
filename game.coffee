# entry point
window.onload = () ->
	WIDTH = 640
	HEIGHT = 480
	
	Crafty.init(WIDTH, HEIGHT)
	Crafty.viewport.init(WIDTH, HEIGHT)
	Crafty.viewport.bounds = {min:{x:0, y:0}, max:{x:+Infinity, y:480}};
	Crafty.settings.modify('autoPause', true)
	window.loadScene('play')
