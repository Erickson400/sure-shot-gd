extends Node
## To prevent the bullet ricochet sfx from 
## burning your ears if played multiple times


var rico: AudioStreamPlayer


func _ready():
	rico = AudioStreamPlayer.new()
	add_child(rico)
	rico.stream = load("res://assets/sfx/rico.wav")


func play():
	rico.play()






