extends PanelContainer

onready var time_frame:=$VBoxContainer/TimeFrame

func _ready() -> void:
	time_frame.add_item("Week")
	time_frame.add_item("Month")
	time_frame.add_item("Year")
