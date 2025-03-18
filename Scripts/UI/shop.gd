extends Control

class_name Shop

@export var shops = []

@onready var remaining_buget := GameManager.points

@export var _total_cost_label: Label

func _ready():
    GameManager.totals_updated.connect(_on_totals_updated)

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
        MenuManager.load_scene(MenuManager.SCENE.WIN)
        return
    MenuManager.load_scene(MenuManager.SCENE.GAME)
    GameManager.round_started()

func _on_totals_updated():
    remaining_buget = GameManager.points - int(_total_cost_label.text)