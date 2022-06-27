extends Node

var notes_database:=[
	NoteResource.new(
		NoteResource.Mood.Happy,
		DateTime.new(21,11,2021),
		"È il mio compleanno"),
	NoteResource.new(
		NoteResource.Mood.Meh,
		DateTime.new(22,7,2022),
		"Spero di laurearmi"),
	NoteResource.new(
		NoteResource.Mood.Sad,
		DateTime.new(25,12,2021),
		"Natale....")
]

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
