extends Resource

class_name NoteResource

enum Mood{
	Sad,
	Dissatisfied,
	Meh,
	Content,
	Happy
}

export(String) var date :String= "21-11-2021"


export(Mood) var mood

export(String,MULTILINE) var text :String

export(Image) var photo :Image

export(AudioStream) var audio:AudioStream
