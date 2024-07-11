extends Node
## Screenshot feature
## They're saved on the User Data folder


func _input(event):
	if event.is_action_pressed("Screenshot"):
		var capture: Image = get_viewport().get_texture().get_image()
		var time := int(Time.get_ticks_msec()/10.0)
		var filename: String = "user://screen%s.png" % time
		capture.save_png(filename)

