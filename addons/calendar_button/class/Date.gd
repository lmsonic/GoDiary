class_name Date

const MONTH_NAME = [ 
		"Jan", "Feb", "Mar", "Apr", 
		"May", "Jun", "Jul", "Aug", 
		"Sep", "Oct", "Nov", "Dec" ]

const WEEKDAY_NAME = [ 
		"Sunday", "Monday", "Tuesday", "Wednesday", 
		"Thursday", "Friday", "Saturday" ]

var day : int setget set_day
var month : int setget set_month
var year : int setget set_year

func _init(day : int = OS.get_datetime()["day"], 
		month : int = OS.get_datetime()["month"], 
		year : int = OS.get_datetime()["year"]):
	self.day = day
	self.month = month
	self.year = year

# Supported Date Formats:
# DD : Two digit day of month
# MM : Two digit month
# YY : Two digit year
# YYYY : Four digit year
func date(date_format = "DD-MM-YY") -> String:
	if("DD".is_subsequence_of(date_format)):
		date_format = date_format.replace("DD", str(day()).pad_zeros(2))
	if("MM".is_subsequence_of(date_format)):
		date_format = date_format.replace("MM", str(month()).pad_zeros(2))
	if("YYYY".is_subsequence_of(date_format)):
		date_format = date_format.replace("YYYY", str(year()))
	elif("YY".is_subsequence_of(date_format)):
		date_format = date_format.replace("YY", str(year()).substr(2,3))
	return date_format
	
func get_date_string() -> String:
	var weekday := get_weekday_name(day,month,year)
	return weekday + " " + str(day) + " " + get_month_name(month) + " " + str(year)
	
func get_weekday(day : int, month : int, year : int) -> int:
	var t : Array = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
	if(month < 3):
		year -= 1
	return (year + year/4 - year/100 + year/400 + t[month - 1] + day) % 7

func get_weekday_name(day : int, month : int, year : int) -> String:
	var day_num = get_weekday(day, month, year)
	return WEEKDAY_NAME[day_num]
	
func get_month_name(month : int) -> String:
	return MONTH_NAME[month - 1]

func day() -> int:
	return day

func month() -> int:
	return month

func year() -> int:
	return year

func set_day(var _day : int):
	day = _day

func set_month(var _month : int):
	month = _month

func set_year(var _year : int):
	year = _year

func change_to_prev_month():
	var selected_month = month()
	selected_month -= 1
	if(selected_month < 1):
		set_month(12)
		set_year(year() - 1)
	else:
		set_month(selected_month)

func change_to_next_month():
	var selected_month = month()
	selected_month += 1
	if(selected_month > 12):
		set_month(1)
		set_year(year() + 1)
	else:
		set_month(selected_month)

func change_to_prev_year():
	set_year(year() - 1)

func change_to_next_year():
	set_year(year() + 1)
