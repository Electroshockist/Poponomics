extends Button

@export var prev_scene: PackedScene

func _on_pressed():
	get_tree().change_scene_to_packed(prev_scene)
