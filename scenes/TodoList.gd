extends PanelContainer

onready var todo_list:= $VBoxContainer/TodoList
onready var input:= $VBoxContainer/Input
onready var old_height:int = input.rect_position.y

func _process(delta):
	var kb_height = OS.get_virtual_keyboard_height()
	if kb_height > 0:
		print(kb_height)
		input.rect_position.y = old_height - kb_height
	else:
		input.rect_position.y = old_height

func add_todo(text):
	var todo_item = Label.new()
	todo_item.text = text
	todo_list.add_child(todo_item)
