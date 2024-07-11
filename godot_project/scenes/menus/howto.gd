extends Control


const TITLE = "res://scenes/menus/title.tscn"
var frame_counter = 0


func _process(_delta):
	# Exits
	frame_counter += 1
	if frame_counter > 20:
		if Input.is_action_just_pressed("Quit") or Input.is_action_just_pressed("Enter"):
			MenuSoundBus.play_sfx("shot2")
			get_tree().change_scene_to_file(TITLE)

	






