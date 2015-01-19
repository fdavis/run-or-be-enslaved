window.onload = () ->
	WIDTH = 640
	HEIGHT = 480
	INITIAL_SPEED = 2
	ACCELERATION = 0.05
	GRAVITY = 1
	JUMP_SPEED = 10
	Crafty.DrawManager.debug()

	Crafty.init(WIDTH, HEIGHT);
	console.log("crafty inited");

	Crafty.e('Floor, 2D, Canvas, Color, LevelObj')
		.attr({x: 0, y: 250, w: 500, h: 10})
		.color('black');
	console.log("floor defined");


	Crafty.e('2D, Canvas, Color, Fourway, Gravity, Player')
		.attr(playerAttribs:
				x: 0,
				y: 0,
				w: 50,
				h: 50,
				vx: INITIAL_SPEED,
				ax: ACCELERATION,
				jumping: false
		)
		.color('green')
		.gravity('Floor')
		.gravityConst(GRAVITY)
		# FIXME THIS LOOKS UGLY
		.bind("EnterFrame", () ->
					Crafty("LevelObj").each( () ->
						this.x -= Crafty("Player").vx
					)
					this.vx += this.ax
		);
		# .bind("KeyDown", () ->
		# 			if this.isDown('SPACE') and ! _falling
		# 				this.vy += JUMP_SPEED
		# );
	console.log(" player defined ");
	Crafty.DrawManager.debug()