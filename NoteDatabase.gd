extends Node



var notes_database:=[]

func _ready() -> void:
	notes_database.append_array(random_last_year_notes())
	
static func random_note(date:DateTime,text:String) -> NoteResource:
	return NoteResource.new(
			Utils.randi_range(0,NoteResource.Mood.size()),
			date,
			text)

static func generate_random_notes_in_day(day:DateTime,min_notes:int,max_notes:int) ->Array:
	var notes:=[]
	var rand := Utils.randi_range(min_notes,max_notes)
	for i in range(rand):
		var note:= random_note(day,"Random Note")
	return []
	
static func generate_random_notes_between(start_date:DateTime, end_date:DateTime) -> Array:
	if Utils.compare_dates(start_date,end_date) < 0:
		printerr("End date is before start date")
		return []
	
	var notes:=[]
	var date_iter:DateTime= start_date.duplicate()
	
	while Utils.compare_dates(end_date, date_iter) < 0:
		var note:= random_note(date_iter.duplicate(),"Random Note")
		notes.append(note)
		date_iter.next_day()
	
	return notes

static func random_last_week_notes() -> Array:
	var last_week_notes:=[]
	
	var last_week:DateTime=DateTime.new()
	last_week.move_to_week_beginning()
	
	var next_week:DateTime=last_week.duplicate()
	next_week.move_day_relative(7)
	
	return generate_random_notes_between(last_week,next_week)
		
static func random_last_month_notes() -> Array:
	var last_month_notes:=[]
	
	var last_month:DateTime=DateTime.new()
	last_month.move_to_month_beginning()
	
	var next_month:DateTime=last_month.duplicate()
	next_month.next_month()
	
	return generate_random_notes_between(last_month,next_month)
	
static func random_last_year_notes() -> Array:
	var last_year_notes:=[]
	
	var last_year:DateTime=DateTime.new()
	last_year.move_to_year_beginning()
	
	var next_year:DateTime=last_year.duplicate()
	next_year.next_year()
		
	return generate_random_notes_between(last_year,next_year)
	
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
