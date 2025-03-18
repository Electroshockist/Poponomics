extends Area2D

class_name Bubble

signal bubble_popped(market: GameManager.MARKETS)

@onready var bubble_sprite: Sprite2D = $BubbleSprite2D

@onready var bubble_spawner := Globals.bubble_spawner

var radius: int = 25:
	get:
		return radius
	set(value):
		var old_scale = scale
		radius = value
		var flaoting_rad: float = radius

		var img_dims := Vector2(bubble_sprite.texture.get_width(), bubble_sprite.texture.get_height())

		scale = Vector2(2.0 / img_dims.x * flaoting_rad, 2.0 / img_dims.x * flaoting_rad)
		$MarketSprite2D.scale *= old_scale / scale

var market: GameManager.MARKETS:
	get:
		return market
	set(value):
		market = value
		$MarketSprite2D.texture = GameManager.market_resources[market].icon

var _spawn_attempts := 100

func _ready():
	randomize_properties()
	bubble_popped.connect(GameManager.on_bubble_popped)

func _on_body_entered(body: Node2D) -> void:
	if body is Projectile:
		bubble_popped.emit(market)

		body.queue_free()
		queue_free()

func randomize_properties():
	radius = randi_range(bubble_spawner.min_size, bubble_spawner.max_size)
	market = randi_range(0, 3) as GameManager.MARKETS

	var spawn_dims: Rect2i = Rect2i(bubble_spawner.position, bubble_spawner.size)
	# Set global position to random num between play area dimensions, with a margin of bubble radius
	global_position = Vector2(
		randi_range(spawn_dims.position.x + radius, spawn_dims.position.x + spawn_dims.size.x - radius),
		randi_range(spawn_dims.position.y + radius, spawn_dims.position.y + spawn_dims.size.y - radius)
	)

	var bubbles := get_tree().get_nodes_in_group("Bubbles")
	for s in _spawn_attempts:
		for b in bubbles:
			if _intersects(self, b):
				_spawn_attempts -= 1
				randomize_properties()

	if not _spawn_attempts >= 0:
		queue_free()

func _intersects(bubble1: Bubble, bubble2: Bubble) -> bool:
	if not bubble2 == bubble1:
		var radii_sum_sq = (bubble1.radius + bubble2.radius) * (bubble1.radius + bubble2.radius)
		return bubble1.global_position.distance_squared_to(bubble2.global_position) < radii_sum_sq
	return false