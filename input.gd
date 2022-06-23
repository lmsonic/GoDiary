extends HBoxContainer

signal new_todo

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Button_pressed():
	emit_signal('new_todo', $TextEdit.text)
	$TextEdit.text = ''
