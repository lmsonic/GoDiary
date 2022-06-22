extends Control

onready var home:=$Windows/Home
onready var calendar:=$Windows/Calendar
onready var graph:=$Windows/Graph
onready var tasks:=$Windows/Tasks

onready var tween:Tween=$Tween

onready var windows_container:=$Windows

var windows:=[]

func _ready() -> void:
	windows = windows_container.get_children()
	move_window(home)
	windows_container.rect_size.x = rect_size.x * 4.0



func move_window(chosen_window):
	var order := windows.find(chosen_window)
	tween.interpolate_property(windows_container, "rect_position:x",
		windows_container.rect_position.x,-order * rect_size.x, 0.1)
	tween.start()


	

func _on_HomeButton_pressed() -> void:
	move_window(home)

func _on_CalendarButton_pressed() -> void:
	move_window(calendar)

func _on_GraphButton_pressed() -> void:
	move_window(graph)


func _on_TasksButton_pressed() -> void:
	move_window(tasks)


func _on_MainWindow_resized() -> void:
	windows_container.rect_size.x = rect_size.x * 4.0
