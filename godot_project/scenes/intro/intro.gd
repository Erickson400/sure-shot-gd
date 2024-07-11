extends Node2D


const TITLE = "res://scenes/menus/title.tscn"
var frame_counter = 0

func _process(_delta):
	frame_counter += 1
	if frame_counter > 20:
		if Input.is_action_just_pressed("Quit"):
			get_tree().quit()
		if Input.is_action_just_pressed("Enter"):
			finish()
	if frame_counter > 1000:
		finish()
		
	# Nintendo on
	if frame_counter == 100:
		$Bling.play()
		$Logo.show()
		$Logo.position = Vector2(400, 300)
	if frame_counter > 200 and frame_counter < 300:
		var randy = randi_range(0, 5)
		if randy == 1:
			$Shot.play()
		if randy < 3:
			$Logo.position = Vector2(randf_range(390, 410), randf_range(290, 310))
			$P1.frame = randi_range(2, 3)
			$P2.frame = randi_range(2, 3)
	if frame_counter == 300:
		$Logo.hide()
		$P1.frame = 1
		$P2.frame = 1
	
	# Sega on
	if frame_counter == 400:
		$Bling.play()
		$Logo.frame = 1
		$Logo.show()
		$Logo.position = Vector2(400, 300)
	if frame_counter > 500 and frame_counter < 600:
		var randy = randi_range(0, 5)
		if randy == 1:
			$Shot.play()
		if randy < 3:
			$Logo.position = Vector2(randf_range(390, 410), randf_range(290, 310))
			$P1.frame = randi_range(2, 3)
			$P2.frame = randi_range(2, 3)
	if frame_counter == 600:
		$Logo.hide()
		$P1.frame = 1
		$P2.frame = 1
	
	# MDickie on
	if frame_counter == 700:
		$Bling.play()
		$Logo.frame = 2
		$Logo.show()
		$Logo.position = Vector2(400, 300)
	if frame_counter > 750:
		var randy = randi_range(0, 5)
		if randy == 0:
			$P1.frame = randi_range(8, 9)
			$P2.frame = randi_range(8, 9)
	if frame_counter > 990:
		$P1.frame = 4
		$P2.frame = 4


func finish():
	$Loading.show()
	$HoldFire.show()
	get_tree().change_scene_to_file(TITLE)
