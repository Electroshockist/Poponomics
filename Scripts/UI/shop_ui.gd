extends Node
class_name Shop_UI
@export var market: GameManager.MARKETS

@onready var market_resource: MarketResource = GameManager.market_resources[market]

#--- Nodes ---#
@onready var supply_label: Label = $Supply

@onready var total_cost_label: Label = $Total

@onready var spinbox: SpinBox = $SpinBox

# @export var shop: Shop
# #-------------#
var oldspinboxval := 0.0

signal spinbox_updated(value: float, market: GameManager.MARKETS)

func _ready():
	$Icon.texture = market_resource.icon

	$Price.text = GameManager.price_string.format({"price": market_resource.price})
	
	update_text(GameManager.points)
	update_max(GameManager.points)

# 	total_cost_label.text = GameManager.price_string.format({"price": spinbox.value * market_resource.price})

# 	spinbox.max_value = market_resource.get_max_affordable(GameManager.points)

# ## --- Value Updaters --- ##
func update_text(remaining_buget: int):
	# Update supply remaining text
	# Supply remaining = total supply - amount in cart
	supply_label.text = "%s" % ((market_resource.quantity - spinbox.value) as int)

func update_max(remaining_buget: int):
	spinbox.max_value = market_resource.get_max_affordable(remaining_buget)
# 	# Set spinbox maximum to max affordable
# 	spinbox.max_value = market_resource.get_max_affordable(shop.remaining_buget)


# 	# Update total cost label
# 	# total cost = amount in cart * price 
# 	total_cost_label.text = GameManager.price_string.format({"price": spinbox.value * market_resource.price})

# ## --- Signal Callbacks --- ##
func _on_spin_box_value_changed(value: float) -> void:
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
