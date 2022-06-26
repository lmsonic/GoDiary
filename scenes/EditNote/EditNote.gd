extends PanelContainer

onready var date_label:=$VBoxContainer/DateContainer/VBoxContainer/DateLabel
onready var hour_label:=$VBoxContainer/DateContainer/VBoxContainer/HBoxContainer/HourLabel
onready var minute_label:=$VBoxContainer/DateContainer/VBoxContainer/HBoxContainer/MinuteLabel

onready var hour_minute_container:=$VBoxContainer/DateContainer/VBoxContainer/HBoxContainer

onready var buttons_container:=$VBoxContainer/ButtonsContainer
onready var tween:Tween=$Tween


var note:=NoteResource.new()

func _ready() -> void:
	refresh_date()
	hour_label.text = str(note.date_time.hour).pad_zeros(2)
	minute_label.text = str(note.date_time.minute).pad_zeros(2)

func refresh_date():
	var date_time:DateTime = note.date_time
	date_label.text = date_time.get_date_string()
	
	
func _on_CalendarButton_date_selected(date_obj:Date) -> void:
	var date_time:DateTime = note.date_time
	date_time.day = date_obj.day()
	date_time.month = date_obj.month()
	date_time.year = date_obj.year()
	refresh_date()
	
func _on_Button_pressed() -> void:
	if hour_label.text.is_valid_integer() and minute_label.text.is_valid_integer():
		var hour:= int(hour_label.text)
		var minute:= int(minute_label.text)
		if hour >= 0  and hour <= 24 and minute >=0 and minute<=60:
			note.date_time.hour = hour
			note.date_time.minute = minute
			tween_to(Color.green)
			return
			
	tween_to(Color.red)
	
func tween_to(color:Color):
	tween.interpolate_property(hour_minute_container,"modulate",Color.white,color,0.25)
	tween.interpolate_property(hour_minute_container,"modulate",color,Color.white,0.25)
	tween.start()
	
func _on_HourLabel_text_changed(new_text: String) -> void:
	if not new_text.is_valid_integer():
		hour_label.text="00"
	elif int(new_text) < 0:
		hour_label.text="00"
	elif int(new_text) > 24:
		hour_label.text="24"


func _on_MinuteLabel_text_changed(new_text: String) -> void:
	if not new_text.is_valid_integer():
		minute_label.text="00"
	elif int(new_text) < 0:
		minute_label.text="00"
	elif int(new_text) > 60:
		minute_label.text="60"
		

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
