extends Label

func _ready():
    update_points()
    GameManager.points_updated.connect(update_points)

func update_points():
    text = GameManager.points_text.format({"points": GameManager.points})