extends Node2D


var frame_counter = 0


func _ready():
	$Boom.play()


func _process(_delta):
	frame_counter += 1
	$Sprite.frame = 0
	$Sprite.show()
	if frame_counter > 10:
		$Sprite.frame = 1
	if frame_counter > 20:
		$Sprite.frame = 2
	if frame_counter > 30:
		$Sprite.frame = 1
	if frame_counter > 40:
		$Sprite.frame = 2
	if frame_counter > 50:
		$Sprite.frame = 1
	if frame_counter > 60:
		$Sprite.frame = 0
	if frame_counter > 70:
		hide()
		

func _on_audio_stream_player_finished():
	queue_free()
