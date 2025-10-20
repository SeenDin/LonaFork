extends Area2D
@export var target_scene: String = "res://new_location.tscn"


var entered := false

func _on_body_entered(body: CharacterBody2D) -> void:
	entered = true

func _on_body_exited(body: CharacterBody2D) -> void:
	entered = false

func _process(_delta: float) -> void:
	if entered and Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_file(target_scene)
