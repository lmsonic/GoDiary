extends Node

var selected_date:Date=null

func date_time_equal_date(date_time:DateTime, date:Date)->bool:
	return date_time.day == date.day() and date_time.month == date.month() and date_time.year == date.year()
