extends Node


const round_cap := 5

enum MARKETS {
	APPLE,
	FISH,
	STEW,
	WHEAT
}

var market_resources = {
	MARKETS.APPLE: preload("res://Resources/Apple.tres"),
	MARKETS.FISH: preload("res://Resources/Fish.tres"),
	MARKETS.STEW: preload("res://Resources/Stew.tres"),
	MARKETS.WHEAT: preload("res://Resources/Wheat.tres")
}

signal market_updated(market: MARKETS)
signal round_ended

var points = 0

func on_bubble_popped(market: MARKETS):
    var m_r: MarketResource = market_resources[market]
    points += m_r.price

    m_r.total_per_round += 1
    if m_r.total_per_round >= round_cap:
        m_r.price += 1
        m_r.total_per_round = 0
    # m_r.price += 1
    # m_r.quantity -= 1

    market_updated.emit(market)

    Globals.bubble_spawner.create_bubble()

func _ready():
    for i in market_resources:
        round_ended.connect(market_resources[i]._on_new_round)

func end_round():
    round_ended.emit()
    # TODO start buy phase