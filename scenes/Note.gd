extends VBoxContainer

export(Resource) onready var note:Resource = note as NoteResource

export (Array,Texture) var emojis

onready var emoji :=$HBoxContainer2/Emoji
onready var text :=$HBoxContainer2/Text
onready var date_label :=$Date


onready var camera :=$HBoxContainer/Camera
onready var microphone :=$HBoxContainer/Microphone

func _ready() -> void:
	if note.mood:
		emoji.texture = emojis[note.mood]
	text.text = note.text
	var date_time = note.date_time as DateTime
	date_label.text = date_time.get_date_string() + '\n' +\
					date_time.get_hour_minute_string()
					
	if not note.photo: 
		camera.hide()
	if not note.audio: 
		microphone.hide()
	
