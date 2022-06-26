extends PanelContainer

onready var title_day :=$VBoxContainer/DayTitle
onready var notes_container:=$VBoxContainer/ScrollContainer/NotesContainer
var note_prefab:=preload("res://scenes/Note.tscn")
var add_note:=preload("res://scenes/AddNote.tscn")

var notes_resources:Array=[]

func _ready() -> void:
	var selected_date:= CalendarSingleton.selected_date
	if  selected_date == null:
		get_tree().change_scene("res://scenes/Main/Main.tscn")
		printerr("The date isn't selected")
		return
		
	get_tree().set_quit_on_go_back(false)
	title_day.text = "Notes for " + selected_date.get_date_string()
	notes_resources = NoteDatabase.get_notes_for_date(selected_date)
		
	for note_resource in notes_resources:
		var note:Note=note_prefab.instance()
		note.note =note_resource
		notes_container.add_child(note)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		CalendarSingleton.selected_date = null
		get_tree().change_scene("res://scenes/Main/Main.tscn")

func _on_NewNoteButton_pressed() -> void:
	get_tree().change_scene_to(add_note)
