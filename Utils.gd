extends Node
class_name Utils

#excludes max_value
static func randi_range(min_value:int, max_value:int) -> int:
	var n := max_value - min_value 
	return randi() % n + min_value


static func days_between_dates(date_a:DateTime,date_b:DateTime) -> int:
	var n:=0
	var a:=date_a.duplicate()
	var b:=date_b.duplicate()
	if compare_dates(a,b) > 0: # b > a
		while compare_dates(a,b) > 0:
			a.next_day()
			n+=1
		return n
	elif compare_dates(a,b) < 0: # a > b
		while compare_dates(a,b) < 0:
			a.prev_day()
			n-=1
		return n
	else: return 0

static func date_to_date_time(date:Date)->DateTime:
	return DateTime.new(date.day(),date.month(),date.year(),0,0)

static func date_time_equal(a:DateTime, b:DateTime)->bool:
	return a.day == b.day and a.month == b.month and a.year == b.year
		
static func date_time_equal_date(date_time:DateTime, date:Date)->bool:
	return date_time.day == date.day() and date_time.month == date.month() and date_time.year == date.year()


static func compare_dates(base:DateTime , comparison:DateTime) -> int:
	if comparison.year < base.year:
		return -1
	elif comparison.year > base.year:
		return +1
	else:
		if comparison.month < base.month:
			return -1
		elif comparison.month > base.month:
			return +1
		else:
			if comparison.day < base.day:
				return -1
			elif comparison.day > base.day:
				return +1
			else:
				return 0


static func average_colors(colors:Array) -> Color:
	if colors.size() == 0: return Color(0,0,0,1)
	var average:=Color(0,0,0,1)
	for color in colors:
		average.r += color.r 
		average.g += color.g 
		average.b += color.b
		
	return average/colors.size()

static func average_moods(moods:Array) -> float: 
	if moods.size() == 0: return 0.0
	
	var average_mood:=0.0
	for mood in moods:
		average_mood += float(mood) + 1
	return average_mood/moods.size()
