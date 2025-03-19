extends Control

class_name Shop

@onready var remaining_buget := GameManager.points

@export var price: Label

@export var supply: Label

@export var shop_paths = []

var _shops = []

func _ready():
    GameManager.cart_updated.connect(_on_cart_updated)
    
    for shop_path in shop_paths:
        var s: Shop_UI = get_node(shop_path)

        _shops.append(s)
    

func _on_cart_updated():
    remaining_buget = GameManager.points

    var price_sum := 0
    var quantity_sum := 0

    for s in _shops:
        var market_resource: MarketResource = s.market_resource
        var spinbox: SpinBox = s.find_child("SpinBox")

        remaining_buget -= spinbox.value as int * market_resource.price

        price_sum += market_resource.price * spinbox.value as int
        quantity_sum += market_resource.quantity
    
    price.text = GameManager.price_string.format({"price": price_sum})
    supply.text = "%s" % quantity_sum

func _on_buy_pressed() -> void:
    var sum = 0
    for s in _shops:
        var market_resource: MarketResource = s.market_resource

        var spinbox: SpinBox = s.find_child("SpinBox")

        GameManager.points -= spinbox.value as int * market_resource.price
        market_resource.quantity -= spinbox.value as int

        sum += market_resource.quantity

    if sum <= 0:
        MenuManager.load_scene(MenuManager.SCENE.WIN)
    
    MenuManager.load_scene(MenuManager.SCENE.GAME)
    GameManager.round_started()
