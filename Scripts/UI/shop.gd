extends Control

class_name Shop

@onready var remaining_buget := GameManager.points

@onready var price: Label = $"MarginContainer/List/Total/Total Cost"

@onready var supply: Label = $MarginContainer/List/Total/Supply

@export var shops: Dictionary[GameManager.MARKETS, Shop_UI]

# signal update_shops(market: GameManager.MARKETS)
func _ready():
	GameManager.shop = self

	update_totals(0, null)

func _on_shop_ui_spinbox_updated(value: float, market: GameManager.MARKETS) -> void:
	update_totals(value, market)


func update_totals(value: float, market):
	var shop: Shop_UI
	if market != null:
		shop = shops[market]

		var dif := value - shop.oldspinboxval

		# Update budget
		remaining_buget -= dif as int * shop.market_resource.price
		shop.update_text()
	
	var supply_total: int = 0
	var price_total: int = 0
	for m in shops:
		shop = shops[m]

		## do not update the max of the spinbox that triggered
		if market != null and m != market:
			shop.update_max()
		else:
			shop.update_max()

		var mr := shop.market_resource
		supply_total += mr.quantity - shop.spinbox.value
		price_total += mr.price * shop.spinbox.value

	supply.text = "%s" % supply_total
	price.text = "Total: %s" % GameManager.price_string.format({"price": price_total})


func _on_buy_pressed() -> void:
	var quantity_sum = 0

	for m in shops:
		var shop := shops[m]
		
		var market_resource: MarketResource = shop.market_resource
		var spinbox := shop.spinbox

		GameManager.points -= spinbox.value as int * market_resource.price

		market_resource.quantity -= spinbox.value as int
		quantity_sum += market_resource.quantity

	if quantity_sum == 0:
		MenuManager.load_scene(MenuManager.SCENE.WIN)

	MenuManager.load_scene(MenuManager.SCENE.GAME)
	GameManager.round_started()
