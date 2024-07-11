extends Node
## Used for sounds that must play through menu transitions.


const SHOT_1 = preload("res://assets/sfx/shot1.wav")
const SHOT_2 = preload("res://assets/sfx/shot2.wav")
const LOAD = preload("res://assets/sfx/load.wav")
@onready var sfx = $Sfx as AudioStreamPlayer

	
func play_sfx(sound: String):
	match sound:
		"shot1":
			sfx.stream = SHOT_1
			sfx.play()
		"shot2":
			sfx.stream = SHOT_2
			sfx.play()
		"load":
			sfx.stream = LOAD
			sfx.play()
		"explode":
			$Explotion.play()
		_:
			push_warning("Sound %s not found" % sound)	
	



