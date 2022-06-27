extends Node
class_name Utils

static func date_time_equal_date(date_time:DateTime, date:Date)->bool:
	return date_time.day == date.day() and date_time.month == date.month() and date_time.year == date.year()

static func average_colors(colors:Array) -> Color:
	var average:=Color(0,0,0,1)
	for color in colors:
		average.r += color.r * color.r
		average.g += color.g * color.g
		average.b += color.b * color.b 
		
	return average/colors.size()
