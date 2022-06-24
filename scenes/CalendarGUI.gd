extends Control

signal date_selected(date_obj)

var calendar := Calendar.new()
var selected_date := Date.new()
var window_restrictor := WindowRestrictor.new()


var calendar_buttons : CalendarButtons

func _ready():
	calendar_buttons = create_calendar_buttons()
	setup_month_and_year_signals()
	refresh_data()

func create_calendar_buttons() -> CalendarButtons:
	var calendar_container : GridContainer = get_node("vbox/hbox_days")
	return CalendarButtons.new(self, calendar_container)

func setup_month_and_year_signals():
	var month_year_path = "vbox/hbox_month_year/"
	get_node(month_year_path + "button_prev_month").connect("pressed",self,"go_prev_month")
	get_node(month_year_path + "button_next_month").connect("pressed",self,"go_next_month")
	get_node(month_year_path + "button_prev_year").connect("pressed",self,"go_prev_year")
	get_node(month_year_path + "button_next_year").connect("pressed",self,"go_next_year")

func set_month_year_title(title : String):
	var label_month_year_node := get_node("vbox/hbox_month_year/label_month_year") as Label
	label_month_year_node.set_text(title)

func refresh_data():
	var title : String = str(calendar.get_month_name(selected_date.month()) + " " + str(selected_date.year()))
	set_month_year_title(title)
	calendar_buttons.update_calendar_buttons(selected_date)

func day_selected(btn_node):
	var day := int(btn_node.get_text())
	selected_date.set_day(day)
	emit_signal("date_selected", selected_date)

func go_prev_month():
	selected_date.change_to_prev_month()
	refresh_data()

func go_next_month():
	selected_date.change_to_next_month()
	refresh_data()

func go_prev_year():
	selected_date.change_to_prev_year()
	refresh_data()

func go_next_year():
	selected_date.change_to_next_year()
	refresh_data()

