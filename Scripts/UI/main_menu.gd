extends Control

func _on_play_button_pressed() -> void:
	MenuManager.load_scene(MenuManager.SCENE.GAME)
	GameManager.round_started()

func _on_instructions_pressed() -> void:
	MenuManager.load_scene(MenuManager.SCENE.INSTRUCTIONS)

func _on_credits_pressed() -> void:
	MenuManager.load_scene(MenuManager.SCENE.CREDITS)
