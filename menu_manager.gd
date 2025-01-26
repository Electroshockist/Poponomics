extends Node
const shop_scene := preload("res://Scenes/Shop.tscn")

func _ready():
    GameManager.round_ended.connect(_on_round_end)

func _on_round_end():
    get_tree().change_scene_to_packed(shop_scene)
