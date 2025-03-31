extends Node
class_name Shop_UI
@export var market: GameManager.MARKETS

@onready var market_resource: MarketResource

#--- Nodes ---#
@onready var supply_label: Label = $Supply

@onready var total_cost_label: Label = $Total

@onready var spinbox: TempSpinBox = $MarginContainer/SpinBox

# @export var shop: Shop
# #-------------#
var oldspinboxval := 0.0

signal spinbox_updated(value: float, market: GameManager.MARKETS)

func _ready():
	market_resource = GameManager.market_resources[market]
	$Icon.texture = market_resource.icon

	$Price.text = GameManager.price_string.format({"price": market_resource.price})


## --- Value Updaters --- ##
## Updates supply
func update_text():
	# Update supply remaining text
	# Supply remaining = total supply - amount in cart
	var v := market_resource.quantity - spinbox.value
	var t := ((v) as int)
	supply_label.text = "%s" % t

func update_max():
	spinbox.max_value = market_resource.get_max_affordable(GameManager.shop.remaining_buget) + spinbox.value
	total_cost_label.text = "Budget: %s / Price: %s = Max: %s" % [GameManager.shop.remaining_buget, market_resource.price, spinbox.max_value]
	# 	total_cost_label.text = "Subtotal: %s" % (spinbox.max_value * market_resource.price)


# 	# Set spinbox maximum to max affordable
# 	spinbox.max_value = market_resource.get_max_affordable(shop.remaining_buget)


# 	# Update total cost label
# 	# total cost = amount in cart * price 
# 	total_cost_label.text = GameManager.price_string.format({"price": spinbox.value * market_resource.price})


## --- Signal Callbacks --- ##
func _on_spin_box_value_changed(value: int) -> void:
	spinbox_updated.emit(value, market)
	oldspinboxval = value


# 	total_cost_label.text = GameManager.price_string.format({"price": value * market_resource.price})

# 	## Update remaining budget
# 	var dif = value - oldspinboxval
# 	shop.remaining_buget -= dif as int
# 	oldspinboxval = value

# 	_update_values()
# 	spinbox_updated.emit(market)

# func _on_update_shops(m: GameManager.MARKETS) -> void:
# 	if market != m:
# 		_update_values()
