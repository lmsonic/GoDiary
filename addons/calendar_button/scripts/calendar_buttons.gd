class_name CalendarButtons

const BUTTONS_COUNT = 42
var calendar = load("res://addons/calendar_button/class/calendar.gd").new()
var buttons_container : GridContainer


var mood_colors:=[
	Color.red,Color.orange,Color.yellow,Color.yellow,Color.blue]

func _init(var calendar_script, var buttons_container : GridContainer):
	self.buttons_container = buttons_container
	setup_button_signals(calendar_script)

func setup_button_signals(var calendar_script):
	for i in range(BUTTONS_COUNT):
		var btn_node = buttons_container.get_node("btn_" + str(i))
		btn_node.connect("pressed", calendar_script, "day_selected", [btn_node])



func update_calendar_buttons(var selected_date : Date):
	_clear_calendar_buttons()
	
	
	var days_in_month : int = calendar.get_days_in_month(selected_date.month(), selected_date.year())
	var start_day_of_week : int = calendar.get_weekday(1, selected_date.month(), selected_date.year())
	for i in range(days_in_month):
		var btn_node : Button = buttons_container.get_node("btn_" + str(i + start_day_of_week))
		btn_node.set_text(str(i + 1))
		btn_node.set_disabled(false)
		
		# If the day entered is "today"
		if(i + 1 == calendar.day() && selected_date.year() == calendar.year() && selected_date.month() == calendar.month() ):
			btn_node.set_flat(true)
		else:
			btn_node.set_flat(false)
		
		var date :=Date.new(i+1,selected_date.month(),selected_date.year())
		var notes:=NoteDatabase.get_notes_for_date(date)
		var colors:= get_colors_moods(notes)
		if notes.size()>0:
			btn_node.modulate = average_colors(colors)
		else:
			btn_node.modulate = Color.white

func average_colors(colors:Array) -> Color:
	var average:=Color(0,0,0,1)
	for color in colors:
		average.r += color.r
		average.g += color.g
		average.b += color.b
		
	return average
		
func get_colors_moods(notes:Array) -> Array:
	var colors:=[]
	for note in notes:
		note = note as NoteResource
		colors.append(mood_colors[note.mood])
	return colors

func _clear_calendar_buttons():
	for i in range(BUTTONS_COUNT):
		var btn_node : Button = buttons_container.get_node("btn_" + str(i))
		btn_node.set_text("")
		btn_node.set_disabled(true)
		btn_node.set_flat(false)
		btn_node.modulate = Color.white
		
