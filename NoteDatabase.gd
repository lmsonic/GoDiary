extends Node



var notes_database:=[]

func _ready() -> void:
	notes_database.append_array(random_last_week_notes())
	for note in notes_database:
		print(note)

static func random_last_week_notes() -> Array:
	var last_week_notes:=[]
	var last_week := DateTime.new()
	last_week.move_to_week_beginning()
	
	for i in range(7):
		var note:= NoteResource.new(randi() % NoteResource.Mood.size(),
				last_week.duplicate(),"Texto")
		last_week_notes.append(note)
		last_week.move_day_relative(1)
	return last_week_notes
		


func get_last_week_notes() -> Array:
	var last_week_notes:=[]
	var now := DateTime.new()
	var last_week:DateTime=now.duplicate()
	last_week.move_to_week_beginning()
	
	for note in notes_database:
		if Utils.compare_dates(last_week, note.date_time) >= 0:
			last_week_notes.append(note)
	return last_week_notes
	
func get_last_month_notes() -> Array:
	var last_month_notes:=[]
	var now := DateTime.new()
	var last_month:DateTime=now.duplicate()
	last_month.move_to_month_beginning()
	
	for note in notes_database:
		if Utils.compare_dates(last_month, note.date_time) > 0:
			last_month_notes.append(note)
	return last_month_notes
	
func get_last_year_notes() -> Array:
	var last_year_notes:=[]
	var now := DateTime.new()
	var last_year:DateTime=now.duplicate()
	last_year.move_to_year_beginning()
	
	for note in notes_database:
		if Utils.compare_dates(last_year, note.date_time) > 0:
			last_year_notes.append(note)
	return last_year_notes

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
