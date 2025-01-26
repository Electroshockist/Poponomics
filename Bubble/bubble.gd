extends Node2D

class_name Bubble

signal bubble_popped(market: GameManager.MARKETS)

@onready var bubble_sprite: Sprite2D = $BubbleSprite2D

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

func _ready():
    bubble_popped.connect(GameManager.on_bubble_popped)
    radius = radius
    market = market

func _on_body_entered(body: Node2D) -> void:
    if body is Projectile:
        bubble_popped.emit(market)
        # body.disable()
        # $CollisionShape2D.disabled = true

        body.queue_free()
        queue_free()
