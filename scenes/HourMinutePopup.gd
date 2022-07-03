extends Popup

signal hour_minute_changed(hour,minute)

onready var hour_scroll:VScrollBar= $PanelContainer/VBoxContainer/HBoxContainer/HourScroll
onready var minute_scroll:VScrollBar= $PanelContainer/VBoxContainer/HBoxContainer/MinuteScroll

func _on_OkButton_pressed() -> void:
	emit_signal("hour_minute_changed",hour_scroll.value,minute_scroll.value)
	hide()

func set_hour_minute(hour:int,minute:int):
	hour_scroll.value = hour
	minute_scroll.value = minute

func _on_CancelButton_pressed() -> void:
	hide()
