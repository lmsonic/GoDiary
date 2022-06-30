extends HBoxContainer
class_name Task

onready var checkbox:=$CheckBox
onready var label:=$Label

var text:=""

func _ready() -> void:
	_on_CheckBox_toggled(checkbox.pressed)

func set_text(text:String):
	self.text=text


func _on_CheckBox_toggled(button_pressed: bool) -> void:
	if button_pressed:
		label.bbcode_text = "[s]" + text + "[/s]"
	else:
		label.bbcode_text = text
