extends Node

const bubble_scene := preload("res://Bubble.tscn")

var bubbles := []

@export var max_size: int = 50
@export var min_size: int = 250

@export var max_bubbles: int = 15
@export var min_bubbles: int = 7

@export var spawn_deadzone: int = 250

func _ready():
    for i in range(min_bubbles, max_bubbles):
        var bubble: Bubble = bubble_scene.instantiate()
        add_child(bubble)

        if randomize_bubble(bubble):
            bubbles.append(bubble)

func randomize_bubble(bubble: Bubble, recursions: int = 3) -> bool:
	
	#break recursions, bubble failed to place
    if recursions == 0:
        bubble.free()
        return false

    var vp_end := get_window().size

    bubble.radius = randi_range(min_size, max_size)

    bubble.global_position = Vector2(
        randi_range(bubble.radius, vp_end.x - bubble.radius),
        randi_range(bubble.radius, vp_end.y - bubble.radius - spawn_deadzone)
    )

    for bubble2 in bubbles:
        if intersects(bubble, bubble2):
            if not randomize_bubble(bubble, recursions - 1):
                return false
    
    return true

func intersects(bubble1: Bubble, bubble2: Bubble) -> bool:
    var radii_sum_sq = (bubble1.radius + bubble2.radius) * (bubble1.radius + bubble2.radius)
    return bubble1.global_position.distance_squared_to(bubble2.global_position) < radii_sum_sq
