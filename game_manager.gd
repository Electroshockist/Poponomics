extends Node
const shop_scene := preload("res://Scenes/Shop.tscn")
const lose_scene := preload("res://Scenes/Menus/Lose.tscn")
const win_scene := preload("res://Win.tscn")

const round_cap := 2
const round_time_sec := 120

const points_text = "{points} pts"

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

signal points_updated
signal market_updated(market: MARKETS)
signal totals_updated
signal round_ended

@onready var timer: Timer = Timer.new()

var points: int = 0:
    get:
        return points
    set(value):
        points = value
        points_updated.emit()

func on_bubble_popped(market: MARKETS):
    var m_r: MarketResource = market_resources[market]
    points += m_r.price

    m_r.total_per_round += 1
    if m_r.total_per_round >= round_cap:
        m_r.price += 1
        m_r.total_per_round = 0

    market_updated.emit(market)

    Globals.bubble_spawner.create_bubble()

func _ready():
    points = points
    round_started()
    for i in market_resources:
        round_ended.connect(market_resources[i]._on_new_round)

func round_started():
    timer.timeout.connect(end_round)
    timer.one_shot = true
    add_child(timer)
    timer.start(round_time_sec)
    

func end_round():
    var loose := points <= 0

    # can buy from market?
    var sum = 0
    for i in market_resources:
        sum += market_resources[i].get_max_buyable()

    if loose or sum <= 0:
        get_tree().change_scene_to_packed(lose_scene)
        return

    round_ended.emit()
