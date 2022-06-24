extends Resource

enum Mood{
	Sad = 1,
	Dissatisfied,
	Meh,
	Content,
	Happy
}

export(Mood) var mood

export(String) var text

export(Image) var photo

export(AudioStream) var audio
