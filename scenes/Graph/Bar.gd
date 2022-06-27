extends Control
class_name Bar

onready var bar:TextureProgress=$TextureProgress
onready var label:Label = $Label
	

func set_label(text:String): 
	label.text = text
	
func set_value(value:float): 
	bar.value = value
	update_bar()

func update_bar():
	var percent = inverse_lerp(bar.min_value,bar.max_value,bar.value) 
	bar.tint_progress = lerp(Color.red,Color.blue,percent)
