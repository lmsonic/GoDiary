extends Control

onready var home:Control=$Windows/Home
onready var calendar:Control=$Windows/Calendar
onready var graph:Control=$Windows/Graph
onready var tasks:Control=$Windows/Tasks

onready var tween:Tween=$Tween

onready var windows_container:Container=$Windows

var current_window_index:int
var windows:=[]


func _ready() -> void:
	get_tree().set_quit_on_go_back(true)
	windows = windows_container.get_children()
	move_window(home)
	windows_container.rect_size.x = rect_size.x * windows.size()

func tween_window( target_x:float, duration:float):
	tween.interpolate_property(windows_container, "rect_position:x",
		windows_container.rect_position.x,target_x, duration)
	tween.start() 

func move_window(chosen_window):
	var index := windows.find(chosen_window)
	current_window_index = index
	EventBus.emit_signal("window_moved",index)
	tween_window(-index*rect_size.x,0.2)

	
var start_drag_x:float

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		windows_container.rect_position.x += event.relative.x
	elif event is InputEventScreenTouch:
		if event.pressed:
			start_drag_x=event.position.x
		else:
			var drag_dist = start_drag_x - event.position.x
			if drag_dist > rect_size.x * 0.4 \
				and current_window_index+1 < windows.size():
				move_window(windows[current_window_index+1])
			elif drag_dist < -rect_size.x * 0.4 \
				and current_window_index - 1 >= 0:
				move_window(windows[current_window_index-1])
			else:
				move_window(windows[current_window_index])

func _on_HomeButton_pressed() -> void:
	move_window(home)

func _on_CalendarButton_pressed() -> void:
	move_window(calendar)

func _on_GraphButton_pressed() -> void:
	move_window(graph)

func _on_TasksButton_pressed() -> void:
	move_window(tasks)

func reset_window_container() -> void:
	windows_container.rect_size.x = rect_size.x * windows.size()
