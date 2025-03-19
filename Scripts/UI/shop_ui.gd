extends Node
class_name Shop_UI
@export var market: GameManager.MARKETS

@onready var market_resource: MarketResource = GameManager.market_resources[market]
#--- Nodes ---#
@onready var supply_label: Label = $Supply

@onready var price_label: Label = $Price

@onready var total_cost_label: Label = $Total

@onready var spinbox: SpinBox = $SpinBox

@export var shop: Shop
#-------------#

func _ready():
	$Icon.texture = market_resource.icon

	_update_supply_text(market_resource.quantity)
	_update_price_text(market_resource.price)

	total_cost_label.text = GameManager.price_string.format({"price": spinbox.value * market_resource.price})

	GameManager.cart_updated.connect(_on_cart_updated)

	spinbox.max_value = market_resource.get_max_affordable(GameManager.points)

func _on_spin_box_value_changed(value: float) -> void:
	$Total.text = GameManager.price_string.format({"price": value * market_resource.price})
	GameManager.cart_updated.emit()

func _on_cart_updated():
	# Set spinbox maximum to max affordable
	spinbox.max_value = market_resource.get_max_affordable(shop.remaining_buget)

	# Update supply remaining text
	# upply remaining = total supply - amount in cart
	_update_supply_text((market_resource.quantity - spinbox.value) as int)

	# Update total cost label
	# total cost = amount in cart * price 
	total_cost_label.text = GameManager.price_string.format({"price": spinbox.value * market_resource.price})

func _update_supply_text(supply: int):
	$Supply.text = "%s" % supply

func _update_price_text(value: float):
	price_label.text = GameManager.price_string.format({"price": value})
