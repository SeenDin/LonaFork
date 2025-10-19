extends CharacterBody2D

const SPEED = 100.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



func _physics_process(delta):
# setup direction of movement
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
# stop diagonal movement by listening for input then setting axis to zero
	if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left"):
		direction.y = 0
	elif Input.is_action_pressed("move_up") || Input.is_action_pressed("move_down"):
		direction.x = 0
	else:
		direction = Vector2.ZERO
		animated_sprite.play("idle_down")
	
	if direction.y > 0:
		animated_sprite.play("run_down")
	elif direction.y < 0:
		animated_sprite.play("run_up")
	if direction.x > 0:
		animated_sprite.play("run_right")
	elif direction.x < 0:
		animated_sprite.play("run_left")

#normalize the directional movement
	direction = direction.normalized()
# setup the actual movement
	velocity = (direction * SPEED)
	move_and_slide()
