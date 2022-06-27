extends PanelContainer

onready var time_frame:OptionButton=$VBoxContainer/TimeFrame

enum{
	Week,Month,Year
}

func _ready() -> void:
	time_frame.add_item("Week",Week)
	time_frame.add_item("Month",Month)
	time_frame.add_item("Year",Year)
	refresh_bar_graph()



func _on_TimeFrame_item_selected(index: int) -> void:
	refresh_bar_graph()

func refresh_bar_graph() ->void:
	match time_frame.selected:
		Week:
			pass
		Month:
			pass
		Year:
			pass
