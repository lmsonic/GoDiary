extends PanelContainer

onready var calendar_button:=$VBoxContainer/DateContainer/VBoxContainer/CalendarButton
onready var hour_label:=$VBoxContainer/DateContainer/VBoxContainer/HBoxContainer/HourLabel
onready var minute_label:=$VBoxContainer/DateContainer/VBoxContainer/HBoxContainer/MinuteLabel

onready var text_edit:=$VBoxContainer/TextEdit
onready var camera_button:=$VBoxContainer/HBoxContainer/Camera
onready var audio_button:=$VBoxContainer/HBoxContainer/Microphone

onready var hour_minute_container:=$VBoxContainer/DateContainer/VBoxContainer/HBoxContainer

onready var buttons_container:=$VBoxContainer/ButtonsContainer
onready var tween:Tween=$Tween


var note:NoteResource = NoteResource.new()

func _ready() -> void:
	get_tree().set_quit_on_go_back(false)
	
	if Globals.selected_note != null:
		note = Globals.selected_note
	elif Globals.selected_date != null:
		note.date_time.day = Globals.selected_date.day
		note.date_time.month = Globals.selected_date.month
		note.date_time.year = Globals.selected_date.year
	
		
	
	refresh_date()
	hour_label.text = str(note.date_time.hour).pad_zeros(2)
	minute_label.text = str(note.date_time.minute).pad_zeros(2)
	select_button(note.mood)
	text_edit.text=note.text
	camera_button.pressed = note.photo != null
	audio_button.pressed = note.audio != null


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		if Globals.selected_note:
			Globals.selected_note=null
		if Globals.selected_date == null:
			get_tree().change_scene("res://scenes/Main/Main.tscn")
		else:
			get_tree().change_scene("res://scenes/Calendar/Day.tscn")
	
	

func refresh_date():
	var date_time:DateTime = note.date_time
	calendar_button.text = date_time.get_date_string()
	
	
func _on_CalendarButton_date_selected(date_obj:Date) -> void:
	var date_time:DateTime = note.date_time
	date_time.day = date_obj.day()
	date_time.month = date_obj.month()
	date_time.year = date_obj.year()
	refresh_date()
		
		
func _on_HourLabel_focus_exited() -> void:
	if hour_label.text.is_valid_integer():
		var hour:= int(hour_label.text)
		if hour >= 0  and hour < 24 :
			note.date_time.hour = hour
			return
			
	hour_label.text="00"
	tween_to(hour_label,Color.red)


func _on_MinuteLabel_focus_exited() -> void:
	if minute_label.text.is_valid_integer():
		var minute:= int(minute_label.text)
		if minute >= 0  and minute < 60 :
			note.date_time.minute = minute
			return
	
	minute_label.text="00"
	tween_to(minute_label,Color.red)

	
func tween_to(object:Control,color:Color):
	tween.interpolate_property(object,"modulate",Color.white,color,0.25)
	tween.interpolate_property(object,"modulate",color,Color.white,0.25)
	tween.start()

	
func _on_HourLabel_text_changed(new_text: String) -> void:
	if not new_text.is_valid_integer():
		hour_label.text=""
	elif int(new_text) < 0:
		hour_label.text="00"
	elif int(new_text) >= 24:
		hour_label.text="23"


func _on_MinuteLabel_text_changed(new_text: String) -> void:
	if not new_text.is_valid_integer():
		minute_label.text=""
	elif int(new_text) < 0:
		minute_label.text="00"
	elif int(new_text) >= 60:
		minute_label.text="59"
		

func select_button(mood):
	var mood_buttons:=buttons_container.get_children()
	for button in mood_buttons:
		button.pressed=false
	
	var button_selected:TextureButton=mood_buttons[mood]
	button_selected.pressed = true
	note.mood = mood
	

func _on_SadButton_pressed() -> void:
	select_button(NoteResource.Mood.Sad)
	
func _on_DissatisfiedButton_pressed() -> void:
	select_button(NoteResource.Mood.Dissatisfied)
	
func _on_MehButton_pressed() -> void:
	select_button(NoteResource.Mood.Meh)

func _on_ContentButton_pressed() -> void:
	select_button(NoteResource.Mood.Content)

func _on_HappyButton_pressed() -> void:
	select_button(NoteResource.Mood.Happy)

func _on_SaveButton_pressed() -> void:
	note.text = text_edit.text
	NoteDatabase.add_note(note)
	get_tree().change_scene("res://scenes/Main/Main.tscn")


func _on_Camera_toggled(button_pressed: bool) -> void:
	if button_pressed:
		note.photo = Image.new()
	else:
		note.photo = null

func _on_Microphone_toggled(button_pressed: bool) -> void:
	if button_pressed:
		note.audio = AudioStreamSample.new()
		
	else:
		note.audio = null


func _on_DeleteButton_pressed() -> void:
	NoteDatabase.delete_note(note)
	if Globals.selected_date == null:
		get_tree().change_scene("res://scenes/Main/Main.tscn")
	else:
		get_tree().change_scene("res://scenes/Calendar/Day.tscn")
