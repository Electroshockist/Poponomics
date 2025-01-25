extends Node2D

class_name DartGun

@export var rotation_speed: float = 1.0

@export var max_rotation: float = 75


func _process(delta):
    var input = Input.get_axis("Left", "Right")

    rotate(input * rotation_speed * delta)
    rotation = clampf(rotation, deg_to_rad(-max_rotation), deg_to_rad(max_rotation))