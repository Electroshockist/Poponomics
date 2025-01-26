extends Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_instructions_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/Instructions.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/Credits.tscn")
