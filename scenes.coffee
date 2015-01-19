

Crafty.scene("play", () ->
	INITIAL_SPEED = 1
	FRAMES_TO_ACCELERATE = 50 #should be 1 secs, 50fps is default
	INITIAL_ACCELERATION = 1
	GRAVITY = 0.4
	JUMP_SPEED = 10

	Crafty.e('Floor, 2D, Canvas, Color, LevelObj')
		.attr({x: 0, y: 250, w: 800, h: 10})
		.color('black');

	playerAttribs =
		x: 70
		y: 0
		w: 50
		h: 50
		vx: INITIAL_SPEED
		vy: 0
		ax: INITIAL_ACCELERATION
		jumping: false
		jumpSpeed: JUMP_SPEED

	player = Crafty.e('2D, Canvas, Color, Fourway, Gravity, Player')
		.attr(playerAttribs)
		.color('green')
		.gravity('Floor')
		.gravityConst(GRAVITY)
		# FIXME THIS LOOKS UGLY
		.bind("EnterFrame", (frame) ->
					console.log("player enter frame vx:" + this.vx)
					this.x += this.vx
					Crafty.viewport.pan(this.vx, 0, 0)

					# this.vx += this.ax
					this.vx += this.ax if frame.frame % FRAMES_TO_ACCELERATE is 0
					# Crafty.viewport.scroll('x', -this.x)

					if this.vy > 0
						# console.log
						this.y -= this.vy
						this.vy -= GRAVITY
						this.vy = 0 if this.vy < 0
		)
		.bind("KeyDown", (e) ->
					if e.keyCode is Crafty.keys.SPACE and not this._falling
						this.vy += this.jumpSpeed
						console.log('player jumped')
		);

	
	);