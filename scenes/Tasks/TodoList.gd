extends PanelContainer

onready var todo_list:= $VBoxContainer/TodoList
onready var line_edit:LineEdit= $VBoxContainer/Input/LineEdit
onready var input:= $VBoxContainer/Input
 
var old_height

func _process(delta):
	if not old_height:
		old_height = input.rect_position.y
	
	var kb_height := OS.get_virtual_keyboard_height()


	if kb_height > 0:
		input.rect_position.y = old_height - kb_height
	else:
		input.rect_position.y = old_height

func add_todo(text):
	var todo_item = Label.new()
	todo_item.text = text
	todo_list.add_child(todo_item)
	OS.hide_virtual_keyboard()


func _on_Button_pressed() -> void:
	add_todo(line_edit.text)
	line_edit.clear()
