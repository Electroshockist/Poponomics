extends Label

func _ready():
	update_points()
	GameManager.points_updated.connect(update_points)

func update_points():
	text = GameManager.price_string.format({"price": GameManager.points})
