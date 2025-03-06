extends HBoxContainer

class_name MarketListElement

@export var market: GameManager.MARKETS

@onready var market_resource: MarketResource = GameManager.market_resources[market]

const price_string = "{price} pts"

func _ready():
    $Icon.texture = market_resource.icon
    GameManager.market_updated.connect(_on_market_updated)
    _on_market_updated(market)

func _on_market_updated(m: GameManager.MARKETS):
    if m == market:
        $Supply.text = "%s" % market_resource.quantity
        $Price.text = price_string.format({"price": market_resource.price})
        GameManager.totals_updated.emit()
