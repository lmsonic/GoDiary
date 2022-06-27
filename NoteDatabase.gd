extends Node



var notes_database:=[]

func _ready() -> void:
	notes_database.append_array(random_last_year_notes())
	print(notes_database[0], " ", notes_database[-1])

static func random_last_week_notes() -> Array:
	var last_week_notes:=[]
	var last_week := DateTime.new()
	last_week.move_to_week_beginning()
	
	for i in range(7):
		var note:= NoteResource.new(randi() % NoteResource.Mood.size(),
				last_week.duplicate(),"Texto")
		last_week_notes.append(note)
		last_week.next_day()
	return last_week_notes
		
static func random_last_month_notes() -> Array:
	var last_month_notes:=[]
	var last_month := DateTime.new()
	last_month.move_to_month_beginning()
	
	for i in range(Calendar.get_days_in_month(last_month.month,last_month.year)):
		var note:= NoteResource.new(randi() % NoteResource.Mood.size(),
				last_month.duplicate(),"Texto")
		last_month_notes.append(note)
		last_month.next_day()
	return last_month_notes
	
static func random_last_year_notes() -> Array:
	var last_year_notes:=[]
	var last_year := DateTime.new()
	last_year.move_to_year_beginning()
	
	for i in range(Calendar.get_days_in_year(last_year.year)):
		var note:= NoteResource.new(randi() % NoteResource.Mood.size(),
				last_year.duplicate(),"Texto")
		last_year_notes.append(note)
		last_year.next_day()
		
		
	return last_year_notes

func get_notes_between(start_date:DateTime, end_date:DateTime) -> Array:
	var notes:=[]
	for note in notes_database:
		if Utils.compare_dates(start_date, note.date_time) >= 0 \
			and Utils.compare_dates(end_date, note.date_time) < 0:
			notes.append(note)
	return notes

func get_last_week_notes() -> Array:
	var last_week_notes:=[]
	
	var last_week:DateTime=DateTime.new()
	last_week.move_to_week_beginning()
	
	var next_week:DateTime=last_week.duplicate()
	next_week.move_day_relative(7)
	
	return get_notes_between(last_week,next_week)
	
func get_last_month_notes() -> Array:
	var last_month_notes:=[]
	
	var last_month:DateTime=DateTime.new()
	last_month.move_to_month_beginning()
	
	var next_month:DateTime=last_month.duplicate()
	next_month.next_month()

	return get_notes_between(last_month,next_month)
	
	
func get_last_year_notes() -> Array:
	var last_year_notes:=[]

	var last_year:DateTime=DateTime.new()
	last_year.move_to_year_beginning()
	
	var next_year:DateTime=last_year.duplicate()
	next_year.next_year()
	
	return get_notes_between(last_year,next_year)
	

func get_notes_for_date(date:Date) -> Array:
	var notes:=load_notes()
	var day_notes:= []
	for note in notes:
		note = note as NoteResource
		var date_time : DateTime = note.date_time
		if Utils.date_time_equal_date(date_time,date):
			day_notes.append(note)
	return day_notes
		
func delete_note(note:NoteResource) -> void:
	if notes_database.find(note) != -1:
		notes_database.erase(note)
	else:
		printerr("Note not present in database")

func add_note(note:NoteResource) ->void: 
	notes_database.append(note)

func load_notes() -> Array:
	return notes_database

func save_notes():
	pass
