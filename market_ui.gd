extends HBoxContainer

@export var market: GameManager.MARKETS

@onready var market_resource = GameManager.market_resources[market]

const price_string = "{price} pts"

signal totals_updated

func _ready():
    $Icon.texture = market_resource.icon
    GameManager.market_updated.connect(market_changed)
    market_changed(market)

func market_changed(m: GameManager.MARKETS):
    if m == market:
        $Supply.text = "%s" % market_resource.quantity
        $Price.text = price_string.format({"price": market_resource.price})
        totals_updated.emit()
