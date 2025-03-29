extends Resource

class_name MarketResource

@export var icon: Texture2D
@export var quantity := 100
@export var price := 1

var total_per_round := 0

func _on_new_round():
    total_per_round = 0

func get_max_affordable(budget: float) -> int:
    # Get the lowest round number that the user can afford
    var max_affordable := floori(budget / (price as float))

    # Make sure they can't buy more than are in supply 
    var val = min(max_affordable, quantity)
    return val