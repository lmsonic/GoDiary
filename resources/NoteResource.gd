extends Resource

class_name NoteResource

enum Mood{
	Sad = 0,
	Dissatisfied,
	Meh,
	Content,
	Happy
}

func _to_string() -> String:
	return str(date_time) + " " + str(mood) + " " + str(text)
 
func _init(date_time:DateTime=DateTime.new(),mood=Mood.Meh,\
				text:String="", photo:Image=null, audio:AudioStream=null):
	self.date_time = date_time
	self.mood = mood
	self.text = text
	self.photo = photo
	self.audio = audio


export var date_time:Resource = date_time as DateTime

export(Mood) var mood

export(String,MULTILINE) var text :String

export(Image) var photo :Image

export(AudioStreamSample) var audio:AudioStream
