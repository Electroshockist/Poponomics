extends Node2D

const bubble_scene := preload("res://Bubble/Bubble.tscn")

# var bubbles := []

@export var max_size: int = 50
@export var min_size: int = 250

@export var max_bubbles: int = 15
@export var min_bubbles: int = 7

@export var spawn_deadzone: Vector2i = Vector2i(300, 150)

@onready var vp_end := get_window().size

func _ready():
    Globals.bubble_spawner = self

    var rand = randi_range(min_bubbles, max_bubbles)

    for i in rand:
        create_bubble()

func _draw():
    draw_rect(Rect2(0, 0, vp_end.x - spawn_deadzone.x, vp_end.y - spawn_deadzone.y), Color.ALICE_BLUE, false)

func randomize_bubble(bubble: Bubble, recursions: int = 100) -> bool:
	#break recursions, bubble failed to place
    if recursions == 0:
        printerr("Failed to create bubble")
        bubble.free()
        return false

    bubble.radius = randi_range(min_size, max_size)

    bubble.market = randi_range(0, 3) as GameManager.MARKETS

    bubble.global_position = Vector2(
        randi_range(bubble.radius, vp_end.x - bubble.radius - spawn_deadzone.x),
        randi_range(bubble.radius, vp_end.y - bubble.radius - spawn_deadzone.y)
    )

    var bubbles := get_tree().get_nodes_in_group("Bubbles")

    for bubble2 in bubbles:
        var inter := intersects(bubble, bubble2)
        if inter:
            if not randomize_bubble(bubble, recursions - 1):
                return false
    
    return true

func intersects(bubble1: Bubble, bubble2: Bubble) -> bool:
    if not bubble2 == bubble1:
        var radii_sum_sq = (bubble1.radius + bubble2.radius) * (bubble1.radius + bubble2.radius)
        return bubble1.global_position.distance_squared_to(bubble2.global_position) < radii_sum_sq
    return false

func create_bubble():
    var bubble: Bubble = bubble_scene.instantiate()
    add_child(bubble)

    randomize_bubble(bubble)