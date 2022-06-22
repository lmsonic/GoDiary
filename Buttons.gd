extends HBoxContainer

var buttons:=[]

func _ready() -> void:
	buttons.append_array(get_children())
	buttons[0].pressed=true
	
	for i in buttons.size():
		buttons[i].connect("pressed",self,"toggle_button",[i])
		
	EventBus.connect("window_moved",self,"toggle_button")

func toggle_button(index:int):
	for i in buttons.size():
		buttons[i].pressed = buttons[i]==buttons[index]


