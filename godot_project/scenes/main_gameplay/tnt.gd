extends Sprite2D


signal exploded
signal moving_left(frame:int)
signal moving_right(frame:int)

const EXPLOTION = preload("res://scenes/main_gameplay/explotion.tscn")
var is_controls_active = true
var shuffle_frame_counter = 0


func _process(_delta):
	if visible and is_controls_active:
		var moving_direciton = "none"
		if Input.get_action_strength("Tnt Left") and Input.get_action_strength("Tnt Right"):
			position.y = randi_range(450, 453)
			shuffle_frame_counter += 1
		elif Input.is_action_pressed("Tnt Left"):
			position.x -= 3
			position.y = randi_range(450, 453)
			moving_left.emit()
			shuffle_frame_counter += 1
			moving_direciton = "left"
		elif Input.is_action_pressed("Tnt Right"):
			position.x += 3
			position.y = randi_range(450, 453)
			moving_right.emit()
			shuffle_frame_counter += 1
			moving_direciton = "right"
		
		if shuffle_frame_counter > 12:
			shuffle_frame_counter = 0
			$Fiddle.play()

		match moving_direciton:
			"left":
				moving_left.emit(6 if shuffle_frame_counter <= 6 else 7)
			"right":
				moving_right.emit(6 if shuffle_frame_counter <= 6 else 7)

		position.x = clamp(position.x, 100, 690)
		
		if Input.is_action_just_pressed("Space") and visible:
			var explotion = EXPLOTION.instantiate()
			get_parent().add_child(explotion)
			explotion.position = Vector2(position.x, 370)
			visible = false
			exploded.emit()



	
	
	
