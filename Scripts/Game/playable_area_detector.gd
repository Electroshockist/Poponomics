extends Area2D

@export var playable_area: Control
@export var shape: CollisionShape2D

func _on_body_exited(body: Node2D) -> void:
    if body is Projectile:
        body.queue_free()

func _on_game_scene_resized() -> void:
    shape.global_position = playable_area.size / 2
    shape.shape.size = playable_area.size
