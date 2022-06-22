extends HBoxContainer


onready var home_button:Button=$HomeButton
onready var calendar_button:Button=$CalendarButton
onready var graph_button:Button=$GraphButton
onready var tasks_button:Button=$TasksButton

var buttons:=[]

func _ready() -> void:
	buttons.append_array([home_button,calendar_button,graph_button,tasks_button])
	home_button.pressed=true
	
	for button in buttons:
		button.connect("pressed",self,"toggle_button",[button])

func toggle_button(chosen_button:Button):
	for button in buttons:
		button.pressed = button==chosen_button


