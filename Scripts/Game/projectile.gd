extends PhysicsBody2D
class_name Projectile

@export var speed: float = 1

func _physics_process(_delta):
    move_and_collide(transform.y * -speed)

# delete projectile if it leaves screen
func _on_screen_exited() -> void:
    queue_free()

func disable():
    $CollisionShape2D.disabled = true