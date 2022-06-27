extends Resource

class_name DateTime
		
export(int,0,3000) var year :int 
export(Calendar.Month) var month:int
export(int,0,31) var day :int

export(int,0,23) var hour :int
export(int,0,60) var minute :int

func get_date_string() -> String:
	var weekday := Calendar.get_weekday_name(day,month,year)
	return weekday + " " + str(day) + " " + Calendar.get_month_name(month) + " " + str(year)
	
func get_hour_minute_string() -> String:
	return str(hour).pad_zeros(2)+":"+str(minute).pad_zeros(2)

func _to_string() -> String:
	return get_date_string() + " " + get_hour_minute_string()

func _init(day:int=Calendar.day(),month=Calendar.month(),year=Calendar.year(),\
			hour=Calendar.hour(),minute=Calendar.minute()) -> void:
	self.day = day
	self.month = month
	self.year = year
	self.hour = hour
	self.minute = minute
	
func move_to_year_beginning():
	month=0
	day=0
	hour=0
	minute=0

func move_to_month_beginning():
	day=0
	hour=0
	minute=0

func move_to_week_beginning():
	var week_day:=Calendar.get_weekday(day,month,year)
	move_day_relative(-week_day)
	hour=0
	minute=0

func move_day_relative(amount:int):
	var days_in_month := Calendar.get_days_in_month(month,year)
	if day + amount < 0:
		var days_previous_month:= Calendar.get_days_in_month(month-1,year)
		var remainder := (day + amount) % (days_previous_month+1)
		month -=1
		day = days_previous_month - remainder
	elif day + amount > days_in_month:
		var remainder := (day + amount) % (days_in_month+1)
		month +=1
		day = remainder + 1
	else:
		day += amount
