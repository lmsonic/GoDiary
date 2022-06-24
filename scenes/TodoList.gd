extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var old_pos :float = $Input.rect_position.y

# Called when the node enters the scene tree for the first time.
	
func _process(delta):
	if is_virtual_keyboard_shown():
		var kb_pos = OS.get_virtual_keyboard_height()
		$Input.rect_position.y -= kb_pos.y
	else:
		$Input.rect_position.y = old_pos

func add_todo(text):
	var todo_item = Label.new()
	todo_item.text = text
	$VBoxContainer/TodoList.add_child(todo_item)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func is_virtual_keyboard_shown():
	return OS.get_virtual_keyboard_height() != 0
