extends Label

const time_format := "%02d:%02d"

@onready var timer = GameManager.timer

func _process(_delta):
    var time = timer.time_left
    
    var sec = fmod(time, 60)
    var minute = time / 60
    

    text = time_format % [minute, sec]