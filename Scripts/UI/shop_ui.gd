extends Node
class_name Shop_UI
@export var market: GameManager.MARKETS

@onready var market_resource: MarketResource = GameManager.market_resources[market]

#--- Nodes ---#
@onready var supply_label: Label = $Supply

@onready var total_cost_label: Label = $Total

@onready var spinbox: TempSpinBox = $MarginContainer/SpinBox

# @export var shop: Shop
# #-------------#
var oldspinboxval := 0.0

signal spinbox_updated(value: float, market: GameManager.MARKETS)

func _ready():
	$Icon.texture = market_resource.icon

	$Price.text = GameManager.price_string.format({"price": market_resource.price})

	update_text()

## --- Value Updaters --- ##

## Updates total supply and total cost text
func update_text():
	# Update supply remaining text
	# Supply remaining = total supply - amount in cart
	var v := market_resource.quantity - spinbox.value
	var t := ((v) as int)
	supply_label.text = "%s" % t
	total_cost_label.text = "Subtotal: %s" % GameManager.price_string.format({"price": (spinbox.value * market_resource.price)})

func update_max():
	spinbox.max_value = market_resource.get_max_affordable(GameManager.shop.remaining_buget) + spinbox.value

## --- Signal Callbacks --- ##

func _on_spin_box_value_changed(value: int) -> void:
	spinbox_updated.emit(value, market)
	oldspinboxval = value
