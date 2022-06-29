extends VBoxContainer

func _ready() ->void:
	add_happy_day_streak_label()
	add_happiest_month_label()
	add_days_passed_from_worst_mood()
	add_longest_happy_day_streak_label()

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
	
func add_longest_happy_day_streak_label():
	add_child(
		create_label(
			"Longest happy day streak : " +
			str(longest_happy_day_streak())
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

func longest_happy_day_streak()->int:
	var notes:=NoteDatabase.load_notes()
	
	var today:=DateTime.new()
	today.move_to_end_day()
	var i := NoteDatabase.find_first_index_for_date(today)
	
	var longest_streak:=0
	var streak := 0
	
	var last_date:= today
	while i < notes.size():
		var date:DateTime = notes[i].date_time
		if Utils.days_between_dates(date,last_date) > 1: 
			streak = 0
			
		var date_moods:=NoteDatabase.get_moods_for_date(date)
		
		var average:= Utils.average_moods(date_moods) - 1
	
		
		if average >= NoteResource.Mood.Content:
			streak += 1
		else:
			streak =0
			
		if streak>longest_streak:
			longest_streak=streak
			
		last_date = date
		i+=date_moods.size()
	
	return longest_streak
	

func happy_day_streak()->int:
	var notes:=NoteDatabase.load_notes()
	
	var today:=DateTime.new()
	today.move_to_end_day()
	var i := NoteDatabase.find_first_index_for_date(today)
	
	if Utils.days_between_dates(notes[i].date_time,today) > 0: 
		return 0

	var streak := 0
	var last_date:= today
	while i < notes.size():
		var date:DateTime = notes[i].date_time
		if Utils.days_between_dates(date,last_date) > 1: 
			return streak
		var date_moods:=NoteDatabase.get_moods_for_date(date)
		
		
		var average:= Utils.average_moods(date_moods) - 1
	
		print(average)
		if average >= NoteResource.Mood.Content:
			streak +=1
		else:
			break
		
		last_date = date
		i+=date_moods.size()
		
	
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
	var notes:=NoteDatabase.load_notes()
	
	var today:=DateTime.new()
	today.move_to_end_day()
	var i := NoteDatabase.find_first_index_for_date(today)
	
	var worst_mood_date:DateTime = today
	
	while i < notes.size():
		var date:DateTime = notes[i].date_time
		var date_moods:=NoteDatabase.get_moods_for_date(date)
		if date_moods.find(NoteResource.Mood.Sad) != -1: 
			worst_mood_date = date
			break
		i+=1
	
	return Utils.days_between_dates(worst_mood_date,today)
