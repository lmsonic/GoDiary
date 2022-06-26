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

func load_notes() -> Array:
	return notes_database

func save_notes():
	pass
