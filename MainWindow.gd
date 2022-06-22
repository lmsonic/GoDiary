extends Control

onready var home:=$Home
onready var calendar:=$Calendar
onready var graph:=$Graph
onready var tasks:=$Tasks

var windows:=[]

func _ready() -> void:
	windows.append_array([home,calendar,graph,tasks])
	show_window(home)


func show_window(chosen_window:Control):
	for window in windows:
		if window==chosen_window:
			chosen_window.show()
		else:
			window.hide()


func _on_HomeButton_pressed() -> void:
	show_window(home)


func _on_CalendarButton_pressed() -> void:
	show_window(calendar)


func _on_GraphButton_pressed() -> void:
	show_window(graph)


func _on_TasksButton_pressed() -> void:
	show_window(tasks)
