extends Control


const TNT_VERDICT = [
	"I can't get in there to lay down the TNT device! We'll have to do without...",
	"I was able to lay down the TNT device. Spend it wisely...",
]
const TITLE = "res://scenes/menus/title.tscn"
const GAMEPLAY = "res://scenes/main_gameplay/gameplay.tscn"
var selected_level = 1
var head_timer = 0
var frame_counter = 0
var key_delay = 0
#@export var campaign_data: CampaignData
var campaign_data: CampaignData = preload("res://resources/campaign_data.tres")

func _ready():
	campaign_data.init()
	Progress.load_game()
	if Progress.progress < 26:
		selected_level = Progress.progress


func _process(_delta):
	# Exits
	frame_counter += 1
	if frame_counter > 20:
		if Input.is_action_just_pressed("Quit"):
			to_title()
		if Input.is_action_just_pressed("Enter"):
			to_game()
	
	# Heads
	head_timer += 1
	if head_timer > 30:
		head_timer = 0
	if head_timer <= 15:
		$Head1.frame = 0
		$Head2.frame = 3
	if head_timer > 15:
		$Head1.frame = 1
		$Head2.frame = 2
	
	# Selection
	key_delay -= 1 if key_delay > 0 else 0
	if Input.is_action_just_pressed("Left") and key_delay == 0:
		selected_level -= 1
		key_delay = 15
		$Shuffle.play()
	if Input.is_action_just_pressed("Right") and key_delay == 0:
		selected_level += 1
		key_delay = 15
		$Shuffle.play()	
	if Progress.progress < 26:
		selected_level = Progress.progress 
	else:
		selected_level = wrapi(selected_level, 1, 26)
	
	# Stage
	$Sky.frame = campaign_data.level[selected_level-1]["sky"]-1
	$Background.frame = campaign_data.level[selected_level-1]["background"]-1
	$Foreground.frame = campaign_data.level[selected_level-1]["foreground"]-1
	
	$Medal1.visible = true
	$Medal2.visible = true
	
	if Progress.hiscores[selected_level-1] >= 35:
		# Gold
		$Medal1.frame = 2
		$Medal2.frame = 2
	elif Progress.hiscores[selected_level-1] >= 25:
		# Silver
		$Medal1.frame = 1
		$Medal2.frame = 1
	elif Progress.hiscores[selected_level-1] >= 15:
		# Bronze
		$Medal1.frame = 0
		$Medal2.frame = 0
	else:
		$Medal1.visible = false
		$Medal2.visible = false
	
	for c in $LevelType.get_children():
		c.modulate = Color8(0, 85, 0)
	
	for i in range($LevelPreview.get_children().size()):
		$LevelPreview.get_child(i).animation = "b"
		$LevelPreview.get_child(i).frame = i
	
	# Show preview depending on selected level
	if selected_level >= 1 and selected_level <= 5:
		$LevelType/Grasslands.modulate = Color8(255, randi_range(130, 230), 0)
		$LevelPreview.get_child(0).animation = "a"
		$LevelPreview.get_child(0).frame = 0
	elif selected_level >= 6 and selected_level <= 10:
		$LevelType/Plains.modulate = Color8(255, randi_range(130, 230), 0)
		$LevelPreview.get_child(1).animation = "a"
		$LevelPreview.get_child(1).frame = 1
	elif selected_level >= 11 and selected_level <= 15:
		$LevelType/BaseCamp.modulate = Color8(255, randi_range(130, 230), 0)
		$LevelPreview.get_child(2).animation = "a"
		$LevelPreview.get_child(2).frame = 2
	elif selected_level >= 16 and selected_level <= 20:
		$LevelType/Mountains.modulate = Color8(255, randi_range(130, 230), 0)
		$LevelPreview.get_child(3).animation = "a"
		$LevelPreview.get_child(3).frame = 3
	elif selected_level >= 21 and selected_level <= 25:
		$LevelType/Coast.modulate = Color8(255, randi_range(130, 230), 0)
		$LevelPreview.get_child(4).animation = "a"
		$LevelPreview.get_child(4).frame = 4
	
	# Balls
	for i in $Balls.get_children().size():
		$Balls.get_child(i).visible = true
		if Progress.hiscores[i] > 0 and Progress.hiscores[i] < 15:
			$Balls.get_child(i).frame = 0
		elif Progress.hiscores[i] >= 15 and Progress.hiscores[i] < 25:
			$Balls.get_child(i).frame = 1
		elif Progress.hiscores[i] >= 25 and Progress.hiscores[i] < 35:
			$Balls.get_child(i).frame = 2
		elif Progress.hiscores[i] >= 35:
			$Balls.get_child(i).frame = 3
		else:
			$Balls.get_child(i).visible = false
			
	$Hiscore.text = "Hi Score: %s" % Progress.hiscores[selected_level-1]
	$LevelName.text = campaign_data.level_name[selected_level-1]
	
	var ball_pos = $Balls.get_child(selected_level-1).position
	$Highlight.position = Vector2(ball_pos.x, 516.5)
	$Highlight.modulate = Color8(255, randi_range(130, 230), 0)
	
	# Tnt vertict
	$TNTVerdict.text = TNT_VERDICT[campaign_data.level[selected_level-1]["tnt_out"]]
	
	if Progress.progress < 26:
		$Guide.visible = true
		$Guide2.visible = false
		$Congrats.visible  = false
		$Congrats2.visible  = false
	else:
		$Guide.visible = false
		$Guide2.visible = true
		$Congrats.visible  = true
		$Congrats2.visible  = true
		$Congrats.modulate = Color8(255, randi_range(130, 230), 0)
	
	# Level stories
	$Stories1.text = campaign_data.stories[selected_level-1][0]
	$Stories2.text = campaign_data.stories[selected_level-1][1]


func to_title():
	MenuSoundBus.play_sfx("shot2")
	get_tree().change_scene_to_file(TITLE)


func to_game():
	MenuSoundBus.play_sfx("load")
	GameMode.game_mode = GameMode.CAMPAIGN
	GameMode.active_campaign_level = selected_level
	GameMode.campaign_level =  campaign_data.level[selected_level-1]
	get_tree().change_scene_to_file(GAMEPLAY)


func _on_ambience_finished():
	$Ambience.play()


