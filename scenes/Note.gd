extends VBoxContainer

export(Resource) var note_resource
onready var _note_resource:NoteResource = note_resource as NoteResource 

export (Array,Texture) var emojis

onready var emoji :=$HBoxContainer2/Emoji
onready var text :=$HBoxContainer2/Text
onready var date_label :=$Date

onready var camera :=$HBoxContainer/Camera
onready var microphone :=$HBoxContainer/Microphone



func _ready() -> void:
	emoji.texture = emojis[_note_resource.mood]
	text.text = _note_resource.text
	if not _note_resource.photo: 
		camera.hide()
	if not _note_resource.audio: 
		microphone.hide()
