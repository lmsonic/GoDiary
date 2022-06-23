extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_todo(text):
	var todo_item = Label.new()
	todo_item.text = text
	$VBoxContainer/TodoList.add_child(todo_item)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


