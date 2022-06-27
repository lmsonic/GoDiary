extends TextureProgress
class_name Bar

func _ready() -> void:
	var percent = inverse_lerp(min_value,max_value,value) 
	tint_progress = lerp(Color.red,Color.blue,percent)
