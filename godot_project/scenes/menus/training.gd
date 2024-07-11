extends Control


const TITLE = "res://scenes/menus/title.tscn"
const GAMEPLAY = "res://scenes/main_gameplay/gameplay.tscn"
const NUMBER_OF_SETS = 34
const NUMBER_OF_ENEMIES = 15
const NUMBER_OF_SCHEDULES = 9
const NUMBER_OF_SKYS = 4
const NUMBER_OF_BACKGROUNDS = 8
const NUMBER_OF_FOREGROUNDS = 7
const DEFAULT_NAME_COLOR = Color8(0, 105, 0)
const DEFAULT_DESC_COLOR = Color8(0, 75, 0)
var focus = 2
var frame_counter = 0
var key_delay = 0
var wave_data = preload("res://resources/wave_data.tres")


func _ready():
	wave_data.init()
	$EnemySet.text = "Enemy Set %s" % GameMode.custom_level["enemy_set"]
	$EnemySetDesc.text = wave_data.sets[GameMode.custom_level["enemy_set"]-1]["name"]
	$EnemySetDesc.size = Vector2.ZERO
	$EnemySetDesc.position = Vector2(400 - $EnemySetDesc.size.x/2, 190-7)
	
	$EnemyWave.text = "Enemy Wave %s" % GameMode.custom_level["enemy_schedule"]
	$EnemyWaveDesc.text = wave_data.schedules[GameMode.custom_level["enemy_schedule"]-1]["name"]
	
	$EnemyWaveDesc.size = Vector2.ZERO
	$EnemyWaveDesc.position = Vector2(400 - $EnemyWaveDesc.size.x/2, 240-7)
	
	$TNTDeviceDesc.text = "On" if GameMode.custom_level["tnt_out"] else "Off"
	$TNTDeviceDesc.size = Vector2.ZERO
	$TNTDeviceDesc.position = Vector2(400 - $TNTDeviceDesc.size.x/2, 290-7)
	
	$HostageHelpDesc.text = "On" if GameMode.custom_level["hostage_help"] else "Off"
	$HostageHelpDesc.size = Vector2.ZERO
	$HostageHelpDesc.position = Vector2(400 - $HostageHelpDesc.size.x/2, 340-7)

	$SkyText.text = "Sky %s" % GameMode.custom_level["sky"]
	$BackgroundText.text = "Background %s" % GameMode.custom_level["background"]
	$ForegroundText.text = "Foreground %s" % GameMode.custom_level["foreground"]


func _process(_delta):
	# Exits
	frame_counter += 1
	if frame_counter > 20:
		if Input.is_action_just_pressed("Quit"):
			to_title()
		if Input.is_action_just_pressed("Enter"):
			to_game()
	
	# Vertical selection
	key_delay -= 1 if key_delay > 0 else 0
	if key_delay == 0:
		if Input.is_action_just_pressed("Up"):
			key_delay = 15
			focus -= 1
			$Shuffle.play()
		if Input.is_action_just_pressed("Down"):
			key_delay = 15
			focus += 1
			$Shuffle.play()
	focus = wrapi(focus, 2, 9)
	
	# Horizontal selection
	var move_direction = 0
	if key_delay == 0:
		if Input.is_action_just_pressed("Left"):
			move_direction = -1
			key_delay = 15
			$Shuffle.play()
		elif Input.is_action_just_pressed("Right"):
			move_direction = 1
			key_delay = 15
			$Shuffle.play()
		
	match focus:
		2:
			GameMode.custom_level["enemy_set"] += move_direction
		3:
			GameMode.custom_level["enemy_schedule"] += move_direction
		4:
			GameMode.custom_level["tnt_out"] += move_direction
		5:
			GameMode.custom_level["hostage_help"] += move_direction
		6:
			GameMode.custom_level["sky"] += move_direction
		7:
			GameMode.custom_level["background"] += move_direction
		8:
			GameMode.custom_level["foreground"] += move_direction
			
	GameMode.custom_level["enemy_set"] = wrapi(GameMode.custom_level["enemy_set"], 1, NUMBER_OF_SETS+1)
	GameMode.custom_level["enemy_schedule"] = wrapi(GameMode.custom_level["enemy_schedule"], 1, NUMBER_OF_SCHEDULES+1)
	GameMode.custom_level["tnt_out"] = wrapi(GameMode.custom_level["tnt_out"], 0, 2)
	GameMode.custom_level["hostage_help"] = wrapi(GameMode.custom_level["hostage_help"], 0, 2)
	GameMode.custom_level["sky"] = wrapi(GameMode.custom_level["sky"], 1, NUMBER_OF_SKYS)
	GameMode.custom_level["background"] = wrapi(GameMode.custom_level["background"], 1, NUMBER_OF_BACKGROUNDS+1)
	GameMode.custom_level["foreground"] = wrapi(GameMode.custom_level["foreground"], 1, NUMBER_OF_FOREGROUNDS+1)

	# Progress lock
	if Progress.progress < 26:
		GameMode.custom_level["enemy_set"] = 1
		GameMode.custom_level["background"] = 1
		GameMode.custom_level["foreground"] = 1
	
	update_text()


func update_text():
	$EnemySet.modulate = DEFAULT_NAME_COLOR
	$EnemySetDesc.modulate = DEFAULT_DESC_COLOR
	$EnemyWave.modulate = DEFAULT_NAME_COLOR
	$EnemyWaveDesc.modulate = DEFAULT_DESC_COLOR
	$TNTDevice.modulate = DEFAULT_NAME_COLOR
	$TNTDeviceDesc.modulate = DEFAULT_DESC_COLOR
	$HostageHelp.modulate = DEFAULT_NAME_COLOR
	$HostageHelpDesc.modulate = DEFAULT_DESC_COLOR
	$SkyText.modulate = DEFAULT_NAME_COLOR
	$BackgroundText.modulate = DEFAULT_NAME_COLOR
	$ForegroundText.modulate = DEFAULT_NAME_COLOR
	
	$Sky.frame = GameMode.custom_level["sky"]-1
	$Foreground.frame = GameMode.custom_level["foreground"]-1
	$Background.frame = GameMode.custom_level["background"]-1
	
	if Progress.progress < 26:
		$Complete.visible = true
		$Complete.modulate = Color8(255, randi_range(130, 230), 0)
	else:
		$Complete.visible = false
	
	match focus:
		2:
			$EnemySet.text = "Enemy Set %s" % GameMode.custom_level["enemy_set"]
			$EnemySet.modulate = Color8(255, randi_range(130, 230), 0)
			$EnemySetDesc.text = wave_data.sets[GameMode.custom_level["enemy_set"]-1]["name"]
			$EnemySetDesc.modulate = Color.WHITE
			$EnemySetDesc.size = Vector2.ZERO
			$EnemySetDesc.position = Vector2(400 - $EnemySetDesc.size.x/2, 190-7)
		3:
			$EnemyWave.text = "Enemy Wave %s" % GameMode.custom_level["enemy_schedule"]
			$EnemyWave.modulate = Color8(255, randi_range(130, 230), 0)
			$EnemyWaveDesc.text = wave_data.schedules[GameMode.custom_level["enemy_schedule"]-1]["name"]
			$EnemyWaveDesc.modulate = Color.WHITE
			$EnemyWaveDesc.size = Vector2.ZERO
			$EnemyWaveDesc.position = Vector2(400 - $EnemyWaveDesc.size.x/2, 240-7)
		4:
			$TNTDevice.modulate = Color8(255, randi_range(130, 230), 0)
			$TNTDeviceDesc.text = "On" if GameMode.custom_level["tnt_out"] else "Off"
			$TNTDeviceDesc.modulate = Color.WHITE
			$TNTDeviceDesc.size = Vector2.ZERO
			$TNTDeviceDesc.position = Vector2(400 - $TNTDeviceDesc.size.x/2, 290-7)
		5:
			$HostageHelp.modulate = Color8(255, randi_range(130, 230), 0)
			$HostageHelpDesc.text = "On" if GameMode.custom_level["hostage_help"] else "Off"
			$HostageHelpDesc.modulate = Color.WHITE
			$HostageHelpDesc.size = Vector2.ZERO
			$HostageHelpDesc.position = Vector2(400 - $HostageHelpDesc.size.x/2, 340-7)
		6:
			$SkyText.modulate = Color8(255, randi_range(130, 230), 0)
			$SkyText.text = "Sky %s" % GameMode.custom_level["sky"]
		7:
			$BackgroundText.modulate = Color8(255, randi_range(130, 230), 0)
			$BackgroundText.text = "Background %s" % GameMode.custom_level["background"]
		8:
			$ForegroundText.modulate = Color8(255, randi_range(130, 230), 0)
			$ForegroundText.text = "Foreground %s" % GameMode.custom_level["foreground"]


func to_title():
	MenuSoundBus.play_sfx("shot1")
	get_tree().change_scene_to_file(TITLE)


func to_game():
	MenuSoundBus.play_sfx("load")
	GameMode.game_mode = GameMode.CUSTOM
	get_tree().change_scene_to_file(GAMEPLAY)


func _on_ambience_finished():
	$Ambience.play()


