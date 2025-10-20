extends Area2D
@export var target_scene: String = "res://main.tscn"


var entered := false

func _on_body_entered(body) -> void:
	entered = true
	GlobalPos.original_position = body.global_position

func _on_body_exited(_body) -> void:
	entered = false

func _process(_delta: float) -> void:
	if entered and Input.is_action_just_pressed("enter"):
		GlobalPos.should_restore_position = true
		get_tree().change_scene_to_file(target_scene)
