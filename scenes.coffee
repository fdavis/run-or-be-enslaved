window.loadScene = (sceneName) ->
	console.log("Running loadScene with " + sceneName)

	#Crafty.audio stop all

	#reset persistent data (probably just points?) ??
	#  this could be done on SceneDestroy event

	#any other cleanup checking to be done here?
	#  this could be done on SceneDestroy event (most likely)


	Crafty.scene(sceneName)


Crafty.scene("play", () ->
	INITIAL_SPEED = 1
	FRAMES_TO_ACCELERATE = 50 #should be 1 secs, 50fps is default
	INITIAL_ACCELERATION = 1
	GRAVITY = 0.4
	JUMP_SPEED = 10

	playerAttribs =
		x: 70
		y: 0
		w: 35
		h: 60
		vx: INITIAL_SPEED
		vy: 0
		ax: INITIAL_ACCELERATION
		jumping: false
		jumpSpeed: JUMP_SPEED
		moving: true

	player = Crafty.e('2D, Canvas, Color, Fourway, Gravity, Player, Collision')
		.attr(playerAttribs)
		.color('green')
		.gravity('Floor')
		.gravityConst(GRAVITY)
		.bind("EnterFrame", (frame) ->
			# not moving if hit box
			if this.moving
				this.x += this.vx
				Crafty.viewport.pan(this.vx, 0, 0)
				# this.vx += this.ax
				this.vx += this.ax if frame.frame % FRAMES_TO_ACCELERATE is 0

			# jump logic
			if this.vy > 0
				# console.log
				this.y -= this.vy
				this.vy -= GRAVITY
				this.vy = 0 if this.vy < 0

			# if you have fallen and cannot get up
			if this.y > 460
				console.log
				this.color('red')
				this.antigravity()
				this.vx = this.ax = 0
				# TODO play some animation
				window.loadScene('gameover')
		)
		.bind("KeyDown", (e) ->
			if e.keyCode is Crafty.keys.SPACE and not this._falling
				this.vy += this.jumpSpeed
				console.log('player jumped')
		)
		.bind("HitOn", (e) ->
			console.log('onhit')
			this.moving = false
		)
		.bind("HitOff", (e) ->
			console.log('offhit')
			this.moving = true
		); #end player entity

	FLOOR_HEIGHT = 400
	FLOOR_OBJ_HEIGHT = 10
	JUMP_OBSTACLE_HEIGHT = 50
	X_BEHIND_TO_DESTROY = 200 #safe distance from player to destroy objs
	X_TERRAIN_PIECE_WIDTH = 400

	# init floor pieces
	yVals = terrain(X_TERRAIN_PIECE_WIDTH, 300, 150, 0.3)
	dx = X_TERRAIN_PIECE_WIDTH / yVals.length
	points = []
	points.push([dx * i, yVals[i]]) for i in [1..yVals.length]
	Crafty.e
	# points.push([Crafty.width, Crafty.height])
	# points.push([0, Crafty.height])

	Crafty.e('Floor, 2D, Canvas, Color, LevelObj, Polygon')
		.attr({x: 0, y: FLOOR_HEIGHT, _points:points})
		# .attach(new Crafty.polygon(points))
		.color('black');

	# Crafty.e('Floor, 2D, Canvas, Color, LevelObj')
	# 	.attr({x: 80, y: FLOOR_HEIGHT, w: 110, h: FLOOR_OBJ_HEIGHT})
	# 	.color('black');

	# Crafty.e('2D, Canvas, Color, LevelObj, Collision')
	# 	.attr({x: 180, y: FLOOR_HEIGHT - JUMP_OBSTACLE_HEIGHT, w: FLOOR_OBJ_HEIGHT, h: JUMP_OBSTACLE_HEIGHT})
	# 	.color('black');
	# Crafty.e('Floor, 2D, Canvas, Color, LevelObj')
	# 	.attr({x: 180, y: FLOOR_HEIGHT - JUMP_OBSTACLE_HEIGHT - FLOOR_OBJ_HEIGHT, w: 60, h: FLOOR_OBJ_HEIGHT})
	# 	.color('black');

	# Crafty.e('Floor, 2D, Canvas, Color, LevelObj')
	# 	.attr({x: 260, y: FLOOR_HEIGHT, w: 100, h: FLOOR_OBJ_HEIGHT})
	# 	.color('black');
	# Crafty.e('Floor, 2D, Canvas, Color, LevelObj')
	# 	.attr({x: 500, y: FLOOR_HEIGHT, w: 50, h: FLOOR_OBJ_HEIGHT})
	# 	.color('black');

	Crafty.e('Control')
		.bind("EnterFrame", () ->

			# cleanup old
			Crafty("LevelObj").each((i) ->
				if this.x < player.x and player.x - this.x > X_BEHIND_TO_DESTROY
					console.log("destoying floor piece:" + i + " with x:" + this.x)
					this.destroy()
			)

		); #end control entity

); #end play scene

Crafty.scene("gameover", () ->
	console.log('in gameover scene')
	Crafty.viewport.pan(0, 0, 0)
	finalText = Crafty.e("2D, Canvas, Text")
		.attr({ x: 320, y: 200 })
		.origin('middle center')
		.textFont({ size: '48px', weight: 'bold' })
		.textColor('red')
		.text('Enslaved!!');
	Crafty.viewport.centerOn(finalText, 0)
); #end gameover scene

#steal for block pieces
        # var obj, hit = false,
        #     pos = this.pos(),
        #     q, i = 0,
        #     l;

        # //Increase by 1 to make sure map.search() finds the floor
        # pos._y++;

        # //map.search wants _x and intersect wants x...
        # pos.x = pos._x;
        # pos.y = pos._y;
        # pos.w = pos._w;
        # pos.h = pos._h;

        # q = Crafty.map.search(pos);
        # l = q.length;

        # for (; i < l; ++i) {
        #     obj = q[i];
        #     //check for an intersection directly below the player
        #     if (obj !== this && obj.has(this._anti) && obj.intersect(pos)) {
        #         hit = obj;
        #         break;
        #     }
        # }

        # if (hit) { //stop falling if found and player is moving down
        #     if (this._falling && ((this._gy > this._jumpSpeed) || !this._up)){
        #       this.stopFalling(hit);
        #     }
        # } else {
        #     this._falling = true; //keep falling otherwise
        # }