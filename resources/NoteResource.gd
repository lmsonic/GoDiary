extends Resource

class_name NoteResource

enum Mood{
	Sad,
	Dissatisfied,
	Meh,
	Content,
	Happy
}

func _init(mood=Mood.Meh,date_time:DateTime=DateTime.new(),\
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
