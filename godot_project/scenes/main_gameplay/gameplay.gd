extends Node2D


enum {
	FAILED,
	VICTORY,
	PLAYING,
}
# Ambience
const AMB_1 = preload("res://assets/sfx/amb1.wav")
const AMB_2 = preload("res://assets/sfx/amb2.wav")
const AMB_3 = preload("res://assets/sfx/amb3.wav")
const AMB_4 = preload("res://assets/sfx/amb4.wav")

const TITLE = "res://scenes/menus/title.tscn"
const ENEMY = preload("res://scenes/main_gameplay/enemy.tscn")
const PLAYER_TOPGUN_POSITION = [
	Vector2(37, 343),
	Vector2(697, 343),
	]

# Wave variables
var wave_data: WaveData = preload("res://resources/wave_data.tres")
var enemies_remaining = 0
# Note: game mode data indexes start from 1
var active_game_mode_data = {}
var set_index = 0
var schedule_timer = 0
var frame_counter = 0

var score = 40
var game_state = PLAYING
@onready var player_1 = $Player1
@onready var player_2 = $Player2


func _ready():
	wave_data.init()
	wave_data.create_random_wave()
	
	# Debug testing level
	if false:
		GameMode.game_mode = GameMode.CUSTOM
		GameMode.custom_level = {
			"sky": 1,
			"background": 1,
			"foreground": 1,
			"enemy_set": 15,
			"enemy_schedule": 5,
			"tnt_out": 1,
			"host_help": 1,
		}
		
	# Hiscore text
	if GameMode.game_mode == GameMode.CUSTOM:
		$HiScore.hide()
	else:
		$HiScore.text = "Hi Score: " + str(Progress.hiscores[GameMode.active_campaign_level-1])
	
	# Set ambient sound based on background
	if GameMode.game_mode == GameMode.CAMPAIGN:
		active_game_mode_data = GameMode.campaign_level
	else:
		active_game_mode_data = GameMode.custom_level
	match active_game_mode_data["background"]:
		4, 8:
			$Ambience.stream = AMB_1
		5:
			$Ambience.stream = AMB_2
		1, 2:
			$Ambience.stream = AMB_3
		3, 6, 7:
			$Ambience.stream = AMB_4
	$Ambience.play()
	
	$Sky.frame = active_game_mode_data["sky"]-1
	$Foreground.frame = active_game_mode_data["foreground"]-1
	$Background.frame = active_game_mode_data["background"]-1
	
	# Generate enemies
	for i in range(15):
		var enemy = ENEMY.instantiate()
		$Enemies.add_child(enemy)
		var active_set = active_game_mode_data["enemy_set"]-1
		enemy.init(wave_data.sets[active_set]["enemies"][i])
		enemy.player_1_attacked.connect(on_player1_attacked)
		enemy.player_2_attacked.connect(on_player2_attacked)
	
	# Tnt
	$Tnt.visible = active_game_mode_data["tnt_out"] == 1


func _process(_delta):
	# Exits
	frame_counter += 1
	if frame_counter > 20:
		if Input.is_action_just_pressed("Quit"):
			to_title()
		if Input.is_action_just_pressed("Enter") and \
				game_state != PLAYING:
			to_title()
	
	# Enemies remaining
	enemies_remaining = 0
	for e in $Enemies.get_children():
		if e.attributes["attack_type"] != Enum.HOSTAGE and \
				e.attributes["health"] > 0:
			enemies_remaining += 1
	$Remaining.text = "%s Enemies Remaining" % enemies_remaining
	
	# Game endings
	if player_1.health > 0 and player_2.health > 0 and \
			enemies_remaining == 0:
		game_state = VICTORY
		victory()
	elif player_1.health <= 0 or player_2.health <= 0:
		game_state = FAILED
		failed()
	
	# Level Timing
	schedule_timer += 1 if game_state == PLAYING else 0
	var active_schedule = active_game_mode_data["enemy_schedule"]-1
	var last_frame = wave_data.schedules[active_schedule]["timing"].back()
	if schedule_timer <= last_frame:
		if schedule_timer == wave_data.schedules[active_schedule]["timing"][set_index]:
			$Enemies.get_child(set_index).activate()
			set_index += 1
	
	# Score 
	score = player_1.health + player_2.health
	$Score.text = "Score: " + str(score)
	
	
func to_title():
	MenuSoundBus.play_sfx("load")
	if GameMode.game_mode == GameMode.CAMPAIGN:
		Progress.progress += 1
		if score > Progress.hiscores[GameMode.active_campaign_level-1]:
			Progress.hiscores[GameMode.active_campaign_level-1] = score
		Progress.save_game()

	get_tree().change_scene_to_file(TITLE)


func victory():
	$Tnt.is_controls_active = false
	player_1.celebrate()
	player_2.celebrate()
	$Victory.show()
	
	if GameMode.game_mode == GameMode.CAMPAIGN :
		var medal_frame = 0
		if score > 15:
			medal_frame = 0
		if score > 25:
			medal_frame = 1
		if score > 35:
			medal_frame = 2
		$Medal1.frame = medal_frame
		$Medal2.frame = medal_frame
		$Medal1.show()
		$Medal2.show()


func failed():
	$Tnt.is_controls_active = false
	$Fail.show()
	for e in $Enemies.get_children():
		if e.state != Enum.DEAD and e.state != Enum.DYING and \
				e.attributes["attack_type"] != Enum.HOSTAGE:
			e.state = Enum.OVER


func _on_player_1_on_died():
	player_2.get_pissed()
	game_state = FAILED
	failed()
	

func _on_player_2_on_died():
	player_1.get_pissed()
	game_state = FAILED
	failed()


func on_player1_attacked(damage:int):
	$Player1.hurt_by_enemy(damage)


func on_player2_attacked(damage:int):
	$Player2.hurt_by_enemy(damage)


func _on_ambience_finished():
	$Ambience.play()

