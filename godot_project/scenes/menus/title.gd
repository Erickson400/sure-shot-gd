extends Control


const STORY = "res://scenes/menus/story.tscn"
const CAMPAIGN = "res://scenes/menus/campaign.tscn"
const TRAINING = "res://scenes/menus/training.tscn"
const HOWTO = "res://scenes/menus/howto.tscn"
const DEFAULT_TAB_COLOR = Color8(0, 105, 0)
const DEFAULT_TAB_DESC_COLOR = Color8(0, 75, 0)
var selected = 0
var key_delay = 0
var frame_counter = 0


func _ready():
	selected = TitleMemory.title_cursor
	if Progress.progress >= 26:
		$Options/StoryDesc.text = "Find out what happened once the Coast was liberated..."
		$Options/BattleGround.text = "Victory Ground"
		$Options/BattleGroundDesc.text = "Return to any of the 25 preset areas..."
	

func _process(_delta):
	# Reset the tab colors to default
	for tab in $Options.get_children():
		if tab.name.ends_with("Desc"):
			tab.modulate = DEFAULT_TAB_DESC_COLOR
		else:
			tab.modulate = DEFAULT_TAB_COLOR
	
	# Exits
	frame_counter += 1
	if frame_counter > 20:
		if Input.is_action_just_pressed("Quit"):
			get_tree().quit()
		if Input.is_action_just_pressed("Enter"):
			finish()
	
	# Selection
	key_delay -= 1 if key_delay > 0 else 0
	if key_delay == 0:
		if Input.is_action_just_pressed("Up"):
			selected -= 1
			key_delay = 15
			$Shuffle.play()
			
		elif Input.is_action_just_pressed("Down"):
			selected += 1
			key_delay = 15
			$Shuffle.play()
		selected = wrapi(selected, 0, 4)
	
	match selected:
		0:
			$Options/Story.modulate = Color8(255, randi_range(140, 230), 0)
			$Options/StoryDesc.modulate = Color.WHITE
			
		1:
			$Options/BattleGround.modulate = Color8(255, randi_range(140, 230), 0)
			$Options/BattleGroundDesc.modulate = Color.WHITE
		2:
			
			$Options/TrainingGround.modulate = Color8(255, randi_range(140, 230), 0)
			$Options/TrainingGroundDesc.modulate = Color.WHITE
		3:
			$Options/HowToPlay.modulate = Color8(255, randi_range(140, 230), 0)
			$Options/HowToPlayDesc.modulate = Color.WHITE
	
	# Reset
	if Input.is_action_just_pressed("Delete Save"):
		MenuSoundBus.play_sfx("explode")
		Progress.delete_game()
		Progress.progress = 0
		for i in Progress.hiscores.size():
			Progress.hiscores[i] = 0
		

func finish():
	MenuSoundBus.play_sfx("shot2")
	TitleMemory.title_cursor = selected
	match selected:
		0:
			get_tree().change_scene_to_file(STORY)
		1:
			get_tree().change_scene_to_file(CAMPAIGN)
		2:
			get_tree().change_scene_to_file(TRAINING)
		3:
			get_tree().change_scene_to_file(HOWTO)


func _on_ambience_finished():
	$Ambience.play()
	






