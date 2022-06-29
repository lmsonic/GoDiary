extends Node



var notes_database:=[] setget set_notes,get_notes

func _ready() -> void:
	notes_database.append_array(random_last_year_notes())
	sort_database()
	print("sorted")
	
func set_notes(notes:Array) ->void:
	notes_database=notes
	sort_database()

func get_notes() -> Array:
	return notes_database
	
func find_first_index_for_date(date:DateTime) ->int:
	var note:=NoteResource.new(date)
	return notes_database.bsearch_custom(note,self,"compare_notes")
	
func find_last_index_for_date(date:DateTime) ->int:
	var note:=NoteResource.new(date)
	return notes_database.bsearch_custom(note,self,"compare_notes",false)
	
func sort_database():
	notes_database.sort_custom(self,"compare_notes")
	

static func compare_notes(note_a:NoteResource, note_b:NoteResource) -> bool:
	var a:DateTime = note_a.date_time
	var b:DateTime = note_b.date_time
	if a.year > b.year: return true
	elif a.year < b.year: return false
	else:
		if a.month > b.month: return true
		elif a.month < b.month: return false
		else:
			if a.day > b.day: return true
			elif a.day < b.day: return false
			else:
				if a.hour > b.hour: return true
				elif a.hour < b.hour: return false
				else:
					if a.minute > b.minute: return true
					else: return false
			

	
static func random_note(date:DateTime,text:String) -> NoteResource:
	var note:=NoteResource.new(
			date,
			Utils.randi_range(0,NoteResource.Mood.size()),
			text)
	return note

static func generate_random_notes_in_day(day:DateTime,min_notes:int,max_notes:int) ->Array:
	var notes:=[]
	var rand := Utils.randi_range(min_notes,max_notes)
	for i in range(rand):
		day.hour = Utils.randi_range(0,24)
		day.minute = Utils.randi_range(0,60)
		var note:= random_note(day.duplicate(),"Random Note")
		notes.append(note)
	return notes
	
static func generate_random_notes_between(start_date:DateTime, end_date:DateTime,
			min_notes:int,max_notes:int) -> Array:
	if Utils.compare_dates(start_date,end_date) < 0:
		printerr("End date is before start date")
		return []
	
	var notes:=[]
	var date_iter:DateTime= start_date.duplicate()
	
	while Utils.compare_dates(end_date, date_iter) < 0:
		var day_notes:= generate_random_notes_in_day(date_iter.duplicate(),min_notes,max_notes)
		notes.append_array(day_notes)
		date_iter.next_day()
	
	return notes

static func random_last_week_notes() -> Array:
	var last_week_notes:=[]
	
	var last_week:DateTime=DateTime.new()
	last_week.move_to_week_beginning()
	
	var now:DateTime=DateTime.new()

	
	return generate_random_notes_between(last_week,now,0,3)
		
static func random_last_month_notes() -> Array:
	var last_month_notes:=[]
	
	var last_month:DateTime=DateTime.new()
	last_month.move_to_month_beginning()
	
	var now:DateTime=DateTime.new()

	
	return generate_random_notes_between(last_month,now,0,3)
	
static func random_last_year_notes() -> Array:
	var last_year_notes:=[]
	
	var last_year:DateTime=DateTime.new()
	last_year.move_to_year_beginning()
	
	var now:DateTime=DateTime.new()

		
	return generate_random_notes_between(last_year,now,0,3)
	
func get_notes_between(start_date:DateTime, end_date:DateTime) -> Array:
	if Utils.compare_dates(start_date,end_date) < 0:
		printerr("End date is before start date")
		return []
	var notes:=[]
	#logic is backwards because they are ordered from the most recent
	var i:=find_first_index_for_date(end_date)

	var end:=find_last_index_for_date(start_date)

	
	while i<end:
		notes.append(notes_database[i])
		i+=1
		
	return notes

func get_last_week_notes() -> Array:
	var last_week_notes:=[]
	
	var last_week:DateTime=DateTime.new()
	last_week.move_to_week_beginning()
	
	var next_week:DateTime=DateTime.new()
	next_week.move_day_relative(+7)
	
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
	var d:= Utils.date_to_date_time(date)

	var end:=find_last_index_for_date(d)
	d.hour = 23
	d.minute = 59
	var i:=find_first_index_for_date(d)
	
	while i < end:
		day_notes.append(notes_database[i])
		i+=1
	
	return day_notes
		
func delete_note(note:NoteResource) -> void:
	if notes_database.find(note) != -1:
		notes_database.erase(note)
		sort_database()
	else:
		printerr("Note not present in database")

func add_note(note:NoteResource) ->void: 
	notes_database.append(note)
	sort_database()


func load_notes() -> Array:
	return notes_database

func save_notes():
	pass
