extends Node2D

class_name Bubble

@onready var bubble_sprite: Sprite2D = $BubbleSprite2D

@export var value: int = 1

var radius: int = 25:
    get:
         return radius
    set(value):
        radius = value
        var flaoting_rad: float = radius

        var img_dims := Vector2(bubble_sprite.texture.get_width(), bubble_sprite.texture.get_height())

        bubble_sprite.scale = Vector2(2.0 / img_dims.x * flaoting_rad, 2.0 / img_dims.x * flaoting_rad)

enum MARKETS {
	BANANA,
	ORANGE,
	APPLE,
	STRAWBERRY
}

var market: MARKETS

var market_value: int

func _ready():
    radius = radius