extends Control
const game := preload("res://Scenes/Game.tscn")

@export var shops = []

func _on_buy_pressed() -> void:

    var sum = 0
    for shop_path in shops:
        var shop: Shop_UI = get_node(shop_path)

        var market_resource: MarketResource = shop.market_resource

        var spinbox := shop.find_child("SpinBox")

        GameManager.points -= spinbox.value * market_resource.price
        market_resource.quantity -= spinbox.value

        sum += market_resource.quantity

    if sum <= 0:
        get_tree().change_scene_to_packed(GameManager.win_scene)
        return
    get_tree().change_scene_to_packed(game)
    GameManager.round_started()