extends HBoxContainer

class_name TempSpinBox

@onready var label: Label = $ValueLabel

@onready var button_up: Button = $Buttons/Up
@onready var button_down: Button = $Buttons/Down

signal on_value_changed(value: int)

@export var _value := 100
@export var _max_value := 100

var is_ready: bool = false

var value: int:
	get:
		return _value
	set(v):
		_value = v

		if _value >= _max_value:
			_value_surpass_max()
		else:
			button_up.disabled = false

		if _value <= 0:
			_value_surpass_min()
		else:
			button_down.disabled = false
		
		if is_ready:
			on_value_changed.emit(_value)

var max_value: int:
	get: return _max_value
	set(v):
		_max_value = v
		if _value >= _max_value:
			_value_surpass_max()
		else:
			button_up.disabled = false
			
func _ready():
	max_value = _max_value
	value = _value

	_set_label_text(value)

	on_value_changed.connect(_set_label_text)
	is_ready = true

func _set_label_text(v: int):
	label.text = "%0*d" % [3, v]

func _on_down_button_up() -> void:
	value -= 1

func _on_up_button_up() -> void:
	value += 1

func _value_surpass_max():
	_value = _max_value
	button_up.disabled = true

func _value_surpass_min():
	_value = 0
	button_down.disabled = true
