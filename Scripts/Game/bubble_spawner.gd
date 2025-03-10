extends Control

class_name BubbleSpawner

@export var bubble_scene: PackedScene

var bubbles := []

@export var max_size: int = 50
@export var min_size: int = 250

@export var max_bubbles: int = 15
@export var min_bubbles: int = 7

func _ready():
	Globals.bubble_spawner = self

	var rand = randi_range(min_bubbles, max_bubbles)

	for i in rand:
		create_bubble()

func create_bubble():
	var bubble: Bubble
	bubble = bubble_scene.instantiate()
	call_deferred("_add", bubble)

func _add(bubble: Bubble):
	if not bubble.is_queued_for_deletion():
		add_child(bubble)