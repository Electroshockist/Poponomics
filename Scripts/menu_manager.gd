extends Node

enum SCENE {
    GAME,
    SHOP,
    INSTRUCTIONS,
    CREDITS,
    WIN,
    LOSE
}

var _scenes = {
    SCENE.GAME: preload("res://Scenes/Game/Game.tscn"),
    SCENE.SHOP: preload("res://Scenes/UI/Shop.tscn"),
    SCENE.INSTRUCTIONS: preload("res://Scenes/UI/Menus/Instructions.tscn"),
    SCENE.CREDITS: preload("res://Scenes/UI/Menus/Credits.tscn"),
    SCENE.WIN: preload("res://Scenes/UI/Menus/Win.tscn"),
    SCENE.LOSE: preload("res://Scenes/UI/Menus/Lose.tscn")
}

func load_scene(scene: SCENE):
    get_tree().change_scene_to_packed(_scenes[scene])