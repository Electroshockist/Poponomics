extends Control

class_name Shop

@onready var remaining_buget := GameManager.points

# @export var price: Label

# @export var supply: Label

@export var shops: Dictionary[GameManager.MARKETS, Shop_UI]

# signal update_shops(market: GameManager.MARKETS)

func _ready():
	pass
#     for shop_path in shop_paths:
#         var s: Shop_UI = get_node(shop_path)
#         _shops.append(s)
# # func _on_cart_updated():
# #     remaining_buget = GameManager.points
# #     var price_sum := 0
# #     var quantity_sum := 0
# #     for s in _shops:
# #         var market_resource: MarketResource = s.market_resource
# #         var spinbox: SpinBox = s.spinbox
# #         remaining_buget -= spinbox.value as int * market_resource.price
# #         price_sum += market_resource.price * spinbox.value as int
# #         quantity_sum += market_resource.quantity
# #     price.text = GameManager.price_string.format({"price": price_sum})
# #     supply.text = "%s" % quantity_sum
# func _on_buy_pressed() -> void:
#     var quantity_sum = 0
#     for s in _shops:
#         var market_resource: MarketResource = s.market_resource
#         var spinbox: SpinBox = s.spinbox
#         GameManager.points -= spinbox.value as int * market_resource.price
#         market_resource.quantity -= spinbox.value as int
#         quantity_sum += market_resource.quantity
#     if quantity_sum == 0:
#         MenuManager.load_scene(MenuManager.SCENE.WIN)
#     MenuManager.load_scene(MenuManager.SCENE.GAME)
#     GameManager.round_started()
func _on_shop_ui_spinbox_updated(value: float, market: GameManager.MARKETS) -> void:
	for m in shops:
		var shop := shops[m]
		shop.update_text(remaining_buget)
		
		# Update budget
		var dif := shop.spinbox.value - shop.oldspinboxval
		remaining_buget -= dif as int * shop.market_resource.price

		if m != market:
			shop.update_max(remaining_buget)


#     # _on_cart_updated()
#     update_shops.emit(market)
#     # TODO: Update Totals
