extends CharacterBody2D

const SPEED = 100.0

@onready var body: AnimatedSprite2D = $body
@onready var top_clothes: AnimatedSprite2D = $top_clothes
@onready var jeans: AnimatedSprite2D = $jeans
@onready var head: AnimatedSprite2D = $head
@onready var haircut: AnimatedSprite2D = $haircut

var last_direction: Vector2 = Vector2.DOWN

func _physics_process(delta):
	# setup direction of movement
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# stop diagonal movement by listening for input then setting axis to zero
	if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left"):
		direction.y = 0
	elif Input.is_action_pressed("move_up") || Input.is_action_pressed("move_down"):
		direction.x = 0
	
	if direction != Vector2.ZERO:
		last_direction = direction
		if direction.y > 0:
			body.play("run_down")
			top_clothes.play("run_down")
			jeans.play("run_down")
			head.play("run_down")
			haircut.play("run_down")
		elif direction.y < 0:
			body.play("run_up")
			top_clothes.play("run_up")
			jeans.play("run_up")
			head.play("run_up")
			haircut.play("run_up")
		if direction.x > 0:
			body.play("run_right")
			top_clothes.play("run_right")
			jeans.play("run_right")
			head.play("run_right")
			haircut.play("run_right")
		elif direction.x < 0:
			body.play("run_left")
			top_clothes.play("run_left")
			jeans.play("run_left")
			head.play("run_left")
			haircut.play("run_left")
	else:
		if last_direction.y > 0:
			body.play("idle_down")
			top_clothes.play("idle_down")
			jeans.play("idle_down")
			head.play("idle_down")
			haircut.play("idle_down")
		elif last_direction.y < 0:
			body.play("idle_up")
			top_clothes.play("idle_up")
			jeans.play("idle_up")
			head.play("idle_up")
			haircut.play("idle_up")
		elif last_direction.x > 0:
			body.play("idle_right")
			top_clothes.play("idle_right")
			jeans.play("idle_right")
			head.play("idle_right")
			haircut.play("idle_right")
		elif last_direction.x < 0:
			body.play("idle_left")
			top_clothes.play("idle_left")
			jeans.play("idle_left")
			head.play("idle_left")
			haircut.play("idle_left")

	# normalize the directional movement
	direction = direction.normalized()
	# setup the actual movement
	velocity = (direction * SPEED)
	move_and_slide()
