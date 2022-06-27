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

func _init(day:int=Calendar.day(),month:int=Calendar.month(),year:int=Calendar.year(),\
			hour:int=Calendar.hour(),minute:int=Calendar.minute()) -> void:
	self.day = day
	self.month = month
	self.year = year
	self.hour = hour
	self.minute = minute
	
func move_to_year_beginning():
	month=1
	day=1
	hour=0
	minute=0
	
func next_day():
	day +=1
	if day > Calendar.get_days_in_month(month,year):
		day = 1
		next_month()

	
func prev_day():
	day -=1
	if day < 1:
		prev_month()
		day = Calendar.get_days_in_month(month,year) 

func next_month():
	month +=1
	if month > 12:
		month = 1
		next_year()
	
func prev_month():
	month -=1
	if month < 1:
		month = 12
		prev_year()
	

func next_year():
	year +=1
	
func prev_year():
	month -=1

func move_to_month_beginning():
	day=1
	hour=0
	minute=0

func move_to_week_beginning():
	var week_day:=Calendar.get_weekday(day,month,year)
	move_day_relative(-week_day)
	hour=0
	minute=0

func move_day_relative(amount:int):
	if amount > 0:
		for i in amount:
			next_day()
	elif amount < 0:
		for i in amount:
			prev_day()

