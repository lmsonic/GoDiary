extends VScrollBar

onready var prev_number:Label=$VBoxContainer/PrevNumber
onready var number:Label=$VBoxContainer/Number
onready var next_number:Label=$VBoxContainer/NextNumber

func _ready() -> void:
	_on_NumberScroll_value_changed(value)

func _on_NumberScroll_value_changed(value: float) -> void:
	prev_number.text = str(value-1).pad_zeros(2) if value - 1 > min_value else ""
	number.text = str(value).pad_zeros(2)
	next_number.text = str(value+1).pad_zeros(2) if value + 1 < max_value else ""
