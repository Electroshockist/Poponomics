extends Control

class_name DartGun

@export var rotation_speed: float = 1.0

@export var max_rotation: float = 75

var can_fire := true

@export var projectile_scene: PackedScene

const loaded_texture := preload("res://Assets/Art/kenney_scribble-dungeons/PNG/Double (128px)/Items/weapon_bow_arrow.png")
const unloaded_texture := preload("res://Assets/Art/kenney_scribble-dungeons/PNG/Double (128px)/Items/weapon_bow.png")

func _input(event):
	if event.is_action("Fire") and can_fire:
		disable_firing()

		var projectile := projectile_scene.instantiate()
		projectile.global_position = global_position
		projectile.global_rotation = rotation
		get_tree().root.add_child(projectile)

func _process(delta):
	var input = Input.get_axis("Left", "Right")

	rotation += input * rotation_speed * delta
	rotation = clampf(rotation, deg_to_rad(- max_rotation), deg_to_rad(max_rotation))

func _on_timer_timeout() -> void:
	enable_firing()

func disable_firing():
	$Gun.texture = unloaded_texture
	can_fire = false
	$Timer.start()

func enable_firing():
	$Gun.texture = loaded_texture
	can_fire = true
	$Timer.stop()
