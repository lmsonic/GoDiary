extends PanelContainer

onready var time_frame:OptionButton=$VBoxContainer/TimeFrame
onready var bar_container:GridContainer=$VBoxContainer/BarGraph/MarginContainer/BarContainer
onready var period_label:=$VBoxContainer/PeriodLabel
onready var stats_container:=$VBoxContainer/StatisticsContainer

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

func draw_week_notes():
	var last_week:=DateTime.new()
	last_week.move_to_week_beginning()

	
	var next_week:DateTime=last_week.duplicate()
	next_week.move_day_relative(+7)
	
	period_label.text = "From " + last_week.get_date_string() +\
				" to " + next_week.get_date_string()
	
	var week_notes:=NoteDatabase.get_notes_between(last_week,next_week)
	
	var week_dict:=[]
	for i in range(7):
		week_dict.append([])
		
	for note in week_notes:
		var date:= note.date_time as DateTime
		var week_day:=Calendar.get_weekday(date.day,date.month,date.year)
		week_dict[week_day].append(note.mood)
	
	draw_mood_bars(week_dict,Calendar.WEEKDAY_NAME)
	
func draw_month_notes():
	
	var last_month:=DateTime.new()
	last_month.move_to_month_beginning()
	
	var next_month:DateTime=last_month.duplicate()
	next_month.next_month()
	
	period_label.text = "From " + last_month.get_date_string() +\
				" to " + next_month.get_date_string()
	
	var month_notes:=NoteDatabase.get_notes_between(last_month,next_month)
	
				
	var month_dict:=[]
	for i in range(Calendar.get_days_in_month(last_month.month,last_month.year)):
		month_dict.append([])
		
	for note in month_notes:
		month_dict[note.date_time.day - 1].append(note.mood)
	
	draw_mood_bars(month_dict)
	
func draw_year_notes():
	var last_year:=DateTime.new()
	last_year.move_to_year_beginning()
	
	var next_year:DateTime=last_year.duplicate()
	next_year.next_year()
	
	period_label.text = "From " + last_year.get_date_string() +\
				" to " + next_year.get_date_string()
	
	var year_notes:=NoteDatabase.get_notes_between(last_year,next_year)
	
	var year_dict:=[]
	for i in range(12):
		year_dict.append([])
		
	for note in year_notes:
		year_dict[note.date_time.month - 1].append(note.mood)
	
	draw_mood_bars(year_dict,Calendar.MONTH_NAME)

		
func draw_mood_bars(mood_dict:Array, string_array=null):
	bar_container.columns = mood_dict.size()
	for i in mood_dict.size():
		var bar:Bar = bar_scene.instance()
		bar_container.add_child(bar)
		bar.set_value(Utils.average_moods(mood_dict[i]))
		if string_array == null:
			bar.set_label(str(i+1))
		else:
			bar.set_label(string_array[i])


func refresh_bar_graph() ->void:
	match time_frame.selected:
		Week:
			draw_week_notes()
		Month:
			draw_month_notes()
		Year:
			draw_year_notes()
			
			
