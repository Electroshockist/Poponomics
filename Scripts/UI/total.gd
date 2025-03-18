extends HBoxContainer

@export var price: Label
@export var quantity: Label

func _ready():
    GameManager.totals_updated.connect(_on_totals_updated)
    _on_totals_updated()

func _on_totals_updated():
    var price_sum := 0
    var quantity_sum := 0
    for i in GameManager.market_resources:
        price_sum += GameManager.market_resources[i].price
        quantity_sum += GameManager.market_resources[i].quantity
    
    price.text = "%s" % price_sum
    quantity.text = "%s" % quantity_sum