extends CharacterBody2D

# := means that godot will autimatically set the right datatype
@export var SPEED := 100.0
@export var HEALTH := 100.0
@export var DAMAGE := 5.0

@onready var body: AnimatedSprite2D = $body
@onready var top_clothes: AnimatedSprite2D = $top_clothes
@onready var jeans: AnimatedSprite2D = $jeans
@onready var head: AnimatedSprite2D = $head
@onready var haircut: AnimatedSprite2D = $haircut

@onready var animated_sprites := [body, top_clothes, jeans, head, haircut]

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
			for sprite in animated_sprites:
				sprite.play("run_down")
		elif direction.y < 0:
			for sprite in animated_sprites:
				sprite.play("run_up")
		if direction.x > 0:
			for sprite in animated_sprites:
				sprite.play("run_right")
		elif direction.x < 0:
			for sprite in animated_sprites:
				sprite.play("run_left")
	else:
		if last_direction.y > 0:
			for sprite in animated_sprites:
				sprite.play("idle_down")
		elif last_direction.y < 0:
			for sprite in animated_sprites:
				sprite.play("idle_up")
		elif last_direction.x > 0:
			for sprite in animated_sprites:
				sprite.play("idle_right")
		elif last_direction.x < 0:
			for sprite in animated_sprites:
				sprite.play("idle_left")

	# normalize the directional movement
	direction = direction.normalized()
	# setup the actual movement
	velocity = (direction * SPEED)
	move_and_slide()
