extends PanelContainer

onready var notes_container:=$VBoxContainer/ScrollContainer/NotesContainer
var note_prefab:=preload("res://scenes/Note.tscn")
var edit_note:=preload("res://scenes/EditNote/EditNote.tscn")

func _ready() -> void:
	var notes_resources := NoteDatabase.load_notes()
	for note_resource in notes_resources:
		var note:Note=note_prefab.instance()
		note.note =note_resource
		notes_container.add_child(note)


func _on_NewNoteButton_pressed() -> void:
	get_tree().change_scene_to(edit_note)
