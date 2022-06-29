extends VBoxContainer

func _ready() ->void:
	add_happy_day_streak_label()
	add_happiest_month_label()
	add_days_passed_from_worst_mood()

func clear_statistics():
	for child in get_children():
		child.queue_free()
		
func add_happiest_month_label():
	add_child(
		create_label(
			"Happiest Month : " + 
			Calendar.MONTH_NAME[happiest_month()]
			)
		)

func add_happy_day_streak_label():
	add_child(
		create_label(
			"Happy day streak : " +
			str(happy_day_streak())
		)
	)
	
func add_days_passed_from_worst_mood():
	add_child(
		create_label(
			"Days passed from worst mood : " +
			str(days_passed_from_worst_mood())
		)
	)

func create_label(text:String) -> Label:
	var label:= Label.new()
	label.align = Label.ALIGN_CENTER
	label.valign = Label.VALIGN_CENTER
	label.text = text
	return label

func happy_day_streak()->int:
	var notes:=NoteDatabase.get_notes()
	
	var now:=DateTime.new()
	var i := NoteDatabase.find_first_index_for_date(now)
	
	var streak:=0
	while notes[i].mood==NoteResource.Mood.Happy:
		streak+=1 
		i+=1
	
	return streak
	

func happiest_month()-> int:
	var year_notes:= NoteDatabase.get_last_year_notes()
	
	var months_dict:=[]
	for i in range(12):
		months_dict.append([])
	
	for note in year_notes:
		months_dict[note.date_time.month - 1].append(note.mood)
	
	var happiest_month=0
	var best_month_mood_average=0.0
	
	for i in range(months_dict.size()):
		var month_mood_average:=Utils.average_moods(months_dict[i])
		if month_mood_average > best_month_mood_average:
			happiest_month=i
			best_month_mood_average = month_mood_average
		
	return happiest_month
		
func days_passed_from_worst_mood()->int:
	var notes:=NoteDatabase.get_notes()
	
	var now:=DateTime.new()
	var i := NoteDatabase.find_first_index_for_date(now)
	
	var streak:=0
	while notes[i].mood!=NoteResource.Mood.Sad:
		streak+=1 
		i+=1
	
	return streak