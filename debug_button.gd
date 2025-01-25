extends Button

func _ready():
    pressed.connect(Globals.reload_scene)
