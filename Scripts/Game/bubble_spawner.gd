extends Control

class_name BubbleSpawner

@export var bubble_scene: PackedScene

# var bubbles := []

@export var max_size: int = 50
@export var min_size: int = 250

@export var max_bubbles: int = 15
@export var min_bubbles: int = 7

func _ready():
	Globals.bubble_spawner = self

	# var rand = randi_range(min_bubbles, max_bubbles)

	# for i in rand:
	# 	create_bubble()

func randomize_bubble(bubble: Bubble, recursions: int = 100) -> bool:
	#break recursions, bubble failed to place
	if recursions == 0:
		printerr("Failed to create bubble")
		bubble.queue_free()
		return false


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
	var bubble: Bubble
	set_deferred("bubble", bubble_scene.call_deferred("instantiate"))
	call_deferred("add_child", bubble)

	randomize_bubble(bubble)
