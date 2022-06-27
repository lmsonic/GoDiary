extends PanelContainer

onready var time_frame:OptionButton=$VBoxContainer/TimeFrame
onready var bar_container:=$VBoxContainer/BarGraph/MarginContainer/BarContainer

var bar_scene:=preload("res://scenes/Graph/Bar.tscn")

enum{
	Week,Month,Year
}



func _ready() -> void:
	time_frame.add_item("Week",Week)
	time_frame.add_item("Month",Month)
	time_frame.add_item("Year",Year)
	clear_bar_graph()
	refresh_bar_graph()

func clear_bar_graph():
	for bar in bar_container.get_children():
		bar.queue_free()


func _on_TimeFrame_item_selected(index: int) -> void:
	clear_bar_graph()
	refresh_bar_graph()

func refresh_bar_graph() ->void:
	match time_frame.selected:
		Week:
			var week_notes:=NoteDatabase.get_last_week_notes()
			var week_dict:=[]
			for i in range(7):
				week_dict.append([])
			for note in week_notes:
				var date:= note.date_time as DateTime
				var week_day:=Calendar.get_weekday(date.day,date.month,date.year)
				week_dict[week_day].append(note.mood)
			
			for i in week_dict.size():
				var bar:Bar = bar_scene.instance()
				bar.value = Utils.average_moods(week_dict[i])
				bar_container.add_child(bar)
			
		Month:
			var month_notes:=NoteDatabase.get_last_month_notes()
			var now:=DateTime.new()
			var month_dict:=[]
			for i in range(Calendar.get_days_in_month(now.month,now.year)):
				month_dict.append([])
			for note in month_notes:
				month_dict[note.date_time.day - 1].append(note.mood)
			
			for i in month_dict.size():
				var bar:Bar = bar_scene.instance()
				bar.value = Utils.average_moods(month_dict[i])
				bar_container.add_child(bar)
		Year:
			var year_notes:=NoteDatabase.get_last_year_notes()
			var now:=DateTime.new()
			var year_dict:=[]
			for i in range(Calendar.get_days_in_year(now.year)):
				year_dict.append([])
			for note in year_notes:
				year_dict[note.date_time.day - 1].append(note.mood)
			
			for i in year_dict.size():
				var bar:Bar = bar_scene.instance()
				bar.value = Utils.average_moods(year_dict[i])
				bar_container.add_child(bar)
