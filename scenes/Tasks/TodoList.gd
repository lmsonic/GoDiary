extends PanelContainer

onready var tasks:VBoxContainer= $VBoxContainer/Tasks
onready var line_edit:LineEdit= $VBoxContainer/Input/LineEdit
onready var input:= $VBoxContainer/Input

var task_scene := preload("res://scenes/Tasks/Task.tscn")

var old_height

func _ready() -> void:
	add_todo("Task1")
	add_todo("Task2")
	add_todo("Task3")
	add_todo("Task4")
	add_todo("Task5")

func _process(delta):
	if not old_height:
		old_height = input.rect_position.y
	
	var kb_height := OS.get_virtual_keyboard_height()


	if kb_height > 0:
		input.rect_position.y = old_height - kb_height
	else:
		input.rect_position.y = old_height

func add_todo(text):
	var task := task_scene.instance()
	task.set_text(text)
	tasks.add_child(task)
	
	OS.hide_virtual_keyboard()

var selected_task:Task

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			selected_task = get_task_over_position(event.position)
			if selected_task == null: return
			selected_task.modulate = Color.aqua
		else:
			var drop_task:= get_task_over_position(event.position)
			if drop_task == null or selected_task == null: return
			tasks.move_child(selected_task,drop_task.get_index()-1)
	elif event is InputEventScreenDrag:
		var drop_task:= get_task_over_position(event.position)
		if drop_task == null or selected_task == null: return
		tasks.move_child(selected_task,drop_task.get_index())
		

func get_task_over_position(position:Vector2) -> Task:
	for task in tasks.get_children():
		if task.get_global_rect().has_point(position):
			return task
	return null
	
func get_task_over_y(y:float) -> Task:
	var center:= tasks.rect_global_position + tasks.rect_size/2
	for task in tasks.get_children():
		if task.get_global_rect().has_point(center.x, y):
			return task
	return null

func _on_Button_pressed() -> void:
	add_todo(line_edit.text)
	line_edit.clear()
