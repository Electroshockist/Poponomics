extends Node
class_name Shop_UI
@export var market: GameManager.MARKETS

@onready var market_resource: MarketResource = GameManager.market_resources[market]

@onready var spinbox := $SpinBox

const price_string = "{price} pts"

func _ready():
	spinbox.max_value = market_resource.get_max_buyable()
    
	$Icon.texture = market_resource.icon
	GameManager.market_updated.connect(market_changed)
	
	market_changed(market)

func market_changed(m: GameManager.MARKETS):
	if m == market:
		$Supply.text = "%s" % market_resource.quantity
		$Price.text = price_string.format({"price": market_resource.price})
		GameManager.totals_updated.emit()


func _on_spin_box_value_changed(value: float) -> void:
	$Total.text = price_string % (value * market_resource.price)