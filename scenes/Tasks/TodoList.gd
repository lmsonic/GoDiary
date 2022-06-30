extends PanelContainer

onready var todo_list:= $VBoxContainer/Tree
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
	todo_list.create_item()
	var todo_item = HBoxContainer.new()
	todo_list.add_child(todo_item)
	var todo_check = CheckBox.new()
	todo_item.add_child(todo_check)
	var todo_text = Label.new()
	todo_text.text = text
	todo_item.add_child(todo_text)
	
	OS.hide_virtual_keyboard()


func _on_Button_pressed() -> void:
	add_todo(line_edit.text)
	line_edit.clear()
