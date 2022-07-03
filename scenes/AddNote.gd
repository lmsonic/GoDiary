extends PanelContainer

onready var calendar_button:=$VBoxContainer/DateContainer/VBoxContainer/CalendarButton
onready var hour_minute_button:=$VBoxContainer/DateContainer/VBoxContainer/HourMinuteButton


onready var confirmation_dialog:ConfirmationDialog=$Control/ConfirmationDialog
onready var hour_minute_popup:Popup=$Control/HourMinutePopup

onready var text_edit:=$VBoxContainer/TextEdit
onready var camera_button:=$VBoxContainer/HBoxContainer/Camera
onready var audio_button:=$VBoxContainer/HBoxContainer/Microphone

onready var buttons_container:=$VBoxContainer/ButtonsContainer


var note:NoteResource

func _ready() -> void:
	get_tree().set_quit_on_go_back(false)
	
	if Globals.selected_note != null:
		note = Globals.selected_note
	else:
		note = NoteResource.new()
		if Globals.selected_date != null:
			note.date_time.day = Globals.selected_date.day
			note.date_time.month = Globals.selected_date.month
			note.date_time.year = Globals.selected_date.year
	
		
	
	refresh_date()
	select_button(note.mood)
	update_hour_minute_text(note.date_time.hour,note.date_time.minute)
	text_edit.text=note.text
	camera_button.pressed = note.photo != null
	audio_button.pressed = note.audio != null
	
	confirmation_dialog.get_cancel().connect("pressed", self, "cancelled")


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		if Globals.selected_note:
			Globals.selected_note=null
		confirmation_dialog.popup()

	
	

func refresh_date():
	var date_time:DateTime = note.date_time
	calendar_button.text = date_time.get_date_string()
	
	
func _on_CalendarButton_date_selected(date_obj:Date) -> void:
	var date_time:DateTime = note.date_time
	date_time.day = date_obj.day()
	date_time.month = date_obj.month()
	date_time.year = date_obj.year()
	refresh_date()
		


		

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
	if not Globals.selected_note:
		NoteDatabase.add_note(note)
	switch_to_previous_scene()

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


func switch_to_previous_scene():
	if Globals.selected_date == null:
		get_tree().change_scene("res://scenes/Main/Main.tscn")
	else:
		get_tree().change_scene("res://scenes/Calendar/Day.tscn")

var scheduled_deletion:=false

func _on_DeleteButton_pressed() -> void:
	scheduled_deletion = true
	confirmation_dialog.popup()

func _on_ConfirmationDialog_confirmed() -> void:
	if scheduled_deletion:
		NoteDatabase.delete_note(note)
	switch_to_previous_scene()

func cancelled():
	scheduled_deletion = false

func _on_text_entered(new_text: String) -> void:
	OS.hide_virtual_keyboard()

func _on_HourMinuteButton_pressed() -> void:
	hour_minute_popup.popup()
	hour_minute_popup.set_hour_minute(note.date_time.hour,note.date_time.minute)

func update_hour_minute_text(hour:int, minute:int):
	hour_minute_button.text =str(hour).pad_zeros(2) + " : " + str(minute).pad_zeros(2)

func _on_HourMinutePopup_hour_minute_changed(hour:int, minute:int) -> void:
	update_hour_minute_text(hour,minute)
	note.date_time.hour = hour 
	note.date_time.minute = minute 
