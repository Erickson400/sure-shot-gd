extends Control
## The stories after 9 are only unlocked after 
## finishing the entire game.


const PAGE_TEXT = [
	[ # 1
		"An army of 50 men was dispatched on this island. We were amongst them.",
		"Our mission was simply to destroy the enemy and liberate the territory...",
	],
	[ # 2
		"However, our Commander had greatly underestimated the enemy.",
		"He led us into a suicidal war against 100's of Troopers...",
	],
	[ # 3
		"The mission was a fatal failure before we had even set up camp.",
		"In the panic, some men ran for their lives - never to be seen again...",
	],
	[ # 4
		"Some surrendered to the enemy and vowed to serve as Traitors...",
	],
	[ # 5
		"Many weren't fortunate enough to make either choice, as they were",
		"captured by the enemy and forced to serve as Hostages...",
	],
	[ # 6
		"Us? We sought refuge in these Grasslands while we planned our next move.",
		"We couldn't hide forever - we needed to make some sort of assault...",
	],
	[ # 7
		"I suggested camping out on either side of the field, with a view to",
		"sandwiching any enemy that passed by in a blaze of machine gun fire!",
	],
	[ # 8
		"It would take perfect marksmanship and co-operation, as the slightest misfire",
		"would see us shoot each other! But that was a risk we simply had to take...",
	],
	[ # 9
		"Only then could we eliminate so many enemies, and liberate each area of the",
		"island. Progressing to the Coast was our only hope to leave this place...",
	],
	[ # 10
		"After we liberated the Coast, we located a nearby chopper that was harboring",
		"a few remaining enemies. We had no trouble seizing the chopper for our getaway...",
	],
	[ # 11
		"The 30 surviving members of our army were safely loaded into the chopper.",
		"We were ready to make our triumphant return home!",
	],
	[ # 12
		"However, just as i was about to board the chopper my partner turned his gun on me!!!",
		"In a manic rage, he warned me away from the door as he joined the rest of our men...",
	],
	[ # 13
		"As the chopper took off, he turned to me and shouted that the army was now under HIS",
		"sole authority! He was overcome with a dangerous and disturbing sense of power...",
	],
	[ # 14
		"So here i am. Stranded on a desolate war torn island.",
		"To think, he and i overcame incredible odds thanks to perfect 'co-operation'.",
		"I sat in front of his gun for 25 areas, but i never thought he would turn it on me!",
		"Whether he planned to do it all along, or decided at the last minute, i'll never know.",
		"What i do know is that his intentions for that army cannot be good. I'm SURE of it...",
	],
]
const TITLE = "res://scenes/menus/title.tscn"
const DEFAULT_NUMBER_COLOR = Color8(0, 75, 0)
var frame_counter = 0
var head_timer = 0
var key_delay = 0
@onready var page = 1 if Progress.progress < 26 else 10

	
func _process(_delta):
	key_delay -= 1 if key_delay > 0 else 0
	frame_counter += 1
	if frame_counter > 20:
		if Input.is_action_just_pressed("Quit"):
			finish()
		if Input.is_action_just_pressed("Enter"):
			finish()
	
	# Head
	head_timer += 1
	if head_timer > 30:
		head_timer = 0
	if head_timer <= 15:
		$Head.frame = 2
	if head_timer > 15:
		$Head.frame = 3
		
	# Flick pages
	if key_delay == 0:
		if Input.is_action_just_pressed("Left"):
			page -= 1
			key_delay = 15
			$Shuffle.play()
		if Input.is_action_just_pressed("Right"):
			page += 1
			key_delay = 15
			$Shuffle.play()
	if page < 1:
		page = 1
	if Progress.progress < 26:
		if page > 9:
			page = 9
	else:
		if page > 14:
			page = 14
	
	if Progress.progress < 26:
		$Goal.visible = true
		$Goal.modulate = Color8(255, randi_range(130, 230), 255)
	else:
		$Goal.visible = false
	
	for d in $Descriptors.get_children():
		d.text = ""
	
	for n in $Numbers.get_children():
		n.modulate = DEFAULT_NUMBER_COLOR
		
	$Numbers.get_child(page-1).modulate = Color8(255, randi_range(130, 230), 255)
	$PageImage.frame = page - 1
	
	for i in range(5):
		if PAGE_TEXT[page-1].size()-1 < i:
			break
		$Descriptors.get_child(i).text = PAGE_TEXT[page-1][i]


func _input(_event):
	if Input.is_action_just_pressed("Cheat"):
		MenuSoundBus.play_sfx("explode")
		Progress.progress = 26
		Progress.hiscores.fill(1)
		Progress.save_game()
		

func finish():
	MenuSoundBus.play_sfx("shot2")
	get_tree().change_scene_to_file(TITLE)


func _on_ambience_finished():
	$Ambience.play()
