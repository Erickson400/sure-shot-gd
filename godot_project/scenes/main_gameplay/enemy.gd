extends Area2D


signal hostage_killed
signal player_1_attacked(damage: int)
signal player_2_attacked(damange: int)
signal explosive_kill

const ANIM_NAMES = [
	"enemy1",
	"enemy2",
	"enemy3",
	"enemy4",
	"enemy5",
	"enemy6",
	"enemy7",
	"enemy8",
	"enemy9",
	"hostage1",
	"hostage2"
]
const HIT = [
	preload("res://assets/sfx/hit1.wav"),
	preload("res://assets/sfx/hit2.wav"),
	preload("res://assets/sfx/hit3.wav"),
]
const IMPACT = [
	preload("res://assets/sfx/impact1.wav"),
	preload("res://assets/sfx/impact2.wav"),
	preload("res://assets/sfx/impact3.wav"),
]
const PAIN = [
	preload("res://assets/sfx/pain1.wav"),
	preload("res://assets/sfx/pain2.wav"),
]

const ENEMY_ATTRIBUTES: EnemyAttributes = preload("res://resources/enemy_attributes.tres")
const BLOOD = preload("res://scenes/main_gameplay/blood.tscn")
const EXPLOTION = preload("res://scenes/main_gameplay/explotion.tscn")
var attributes = {}
var state = Enum.WAITING
var attack_direction = Enum.UP
var flip_direction = 0
var active = false
var gameover = false

# Timers
var wait_timer = 0
var evade_timer = 0
var run_timer = 0
var hurt_timer = 0
var die_timer = 0
var dead_timer = 0
var fire_timer = 0
@onready var sprite = $Sprite


func init(type: int):
	# Initialize attributes, animation, collision,
	# position, and attack sfx.
	type -= 1
	attributes = ENEMY_ATTRIBUTES.enemies[type].duplicate()
	sprite.animation = ANIM_NAMES[type]
	$CollisionShape2D.shape.size = attributes["hitbox_size"]
	
	if not attributes["attack_sfx"].is_empty() and type < 8:
		$Attack.stream = load(attributes["attack_sfx"])
	position = Vector2(randf_range(300, 500), 700)


func _process(_delta):
	if not active:
		return
	process_states()
	flip()


func activate():
	active = true


func hurt():
	if attributes["health"] <= 0:
		state = Enum.DYING
		die_timer = 0
		return
	else:
		attributes["health"] -= 1
		if attributes["health"] <= 0:
			hurt()
			return
		else:
			state = Enum.HURT
			hurt_timer = 0
		
	
	var randy = randi_range(1, 5)
	match randy:
		1:
			$Hit.stream = HIT[0]
			$Hit.play()
		2:
			$Hit.stream = HIT[1]
			$Hit.play()
		3:
			$Hit.stream = HIT[2]
			$Hit.play()
	$Impact.stream = IMPACT.pick_random()
	$Impact.play()
	randy = randi_range(1, 10)
	if randy < 4:
		$Pain.stream = PAIN.pick_random()
		$Pain.play()
	

func flip():
	sprite.flip_h = flip_direction == 12


func process_states():
	if position.y > 400:
		translate(Vector2(0, -1))
		state = Enum.RUNNING
		attack_direction = Enum.UP
	
	if position.y == 400 and attack_direction == Enum.UP:
		@warning_ignore("int_as_enum_without_cast")
		attack_direction = randi_range(1, 2)
		$CollisionShape2D.disabled = false
		
	if position.y == 400 and attributes["health"] > 0 and (state == Enum.WAITING or state == Enum.RUNNING):
		var randy = randi_range(0, 200)
		if randy == 200:
			state = Enum.WAITING
		elif randy < 3:
			state = Enum.RUNNING
		randy = randi_range(0, attributes["evade"])
		if randy == 0:
			state = Enum.EVADEDOWN
			evade_timer = 0
	
	if gameover == true and attributes["health"] > 0 and position.y == 400:
		state = Enum.OVER


	# Kill
	if position.x < 120:
		flip_direction = 12
		if attributes["attack_type"] == Enum.HOSTAGE:
			position.x = 30
			state = Enum.RESCUEDP1
			flip_direction = 0
		else:
			position.x = 120
			state = Enum.FIREP1
			fire_timer = 0
			sprite.frame = 4
		flip()
	elif position.x > 680:
		flip_direction = 0
		if attributes["attack_type"] == Enum.HOSTAGE:
			position.x = 770
			state = Enum.RESCUEDP2
			flip_direction = 12
		else:
			position.x =680
			state = Enum.FIREP2
			fire_timer = 0
			sprite.frame = 4
		flip()

	# Waiting
	if state == Enum.WAITING:
		wait_timer += 1
		if wait_timer > 100:
			var randy = randi_range(0, 2)
			match randy:
				0:
					sprite.frame = 0
				1:
					sprite.frame = 3
				2:
					sprite.frame = 6
			wait_timer = 0
		return
	
	# Running
	if state == Enum.RUNNING:
		run_timer += 1
		sprite.frame = 0
		if run_timer > 8:
			sprite.frame = 1
		if run_timer > 16:
			sprite.frame = 0
		if run_timer > 24:
			sprite.frame = 2
		if run_timer > 32:
			run_timer = 0
		var randy = randi_range(0, 50)
		if randy == 0:
			@warning_ignore("int_as_enum_without_cast")
			attack_direction = randi_range(1, 2)
		if attack_direction == Enum.LEFT:
			translate(Vector2(-attributes["speed"], 0))
			flip_direction = 12
		elif attack_direction == Enum.RIGHT:
			translate(Vector2(attributes["speed"], 0))
			flip_direction = 0
		return
	
	# Evade down
	if state == Enum.EVADEDOWN:
		evade_timer += 1
		sprite.frame = 7
		if evade_timer > 25:
			sprite.frame = 8
			state = Enum.EVADE
			evade_timer = 0
		return
	
	# Evading
	if state == Enum.EVADE:
		sprite.frame = 8
		var randy = randi_range(0, 200)
		if randy == 0:
			state = Enum.EVADEUP
			evade_timer = 0
		return
	
	# Evade up
	if state == Enum.EVADEUP:
		evade_timer += 1
		sprite.frame = 7
		if evade_timer > 25:
			sprite.frame = 6
			state = Enum.WAITING
			evade_timer = 0
		return

	# Hurt
	if state == Enum.HURT:
		hurt_timer += 1
		sprite.frame = 9
		if hurt_timer > 15:
			state = Enum.RUNNING
			run_timer = 0
			sprite.frame = 0
			var randy = randi_range(0, (attributes["evade"]/4))
			match randy:
				0:
					state = Enum.EVADEDOWN
					evade_timer = 0
					sprite.frame = 7
				1:
					state = Enum.WAITING
					wait_timer = 0
					sprite.frame = 3
		return

	# Dying
	if state == Enum.DYING:
		die_timer += 1
		sprite.frame = 9
		if die_timer > 10:
			sprite.frame = 10
		if die_timer > 20:
			sprite.frame = 11
			state = Enum.DEAD
		if die_timer == 3:
			var randy = randi_range(1, 2)
			match randy:
				1:
					$Die1.play()
				2:
					$Die2.play()
		# Exploder (inside dying check)
		if attributes["attack_type"] == Enum.EXPLODER and die_timer == 3:
			var explode = EXPLOTION.instantiate()
			add_child(explode)
			explode.position = Vector2(position.x, 370)
		return

	# Dead
	if state == Enum.DEAD:
		sprite.frame = 11
		dead_timer += 1
		if attributes["attack_type"] == Enum.HOSTAGE:
			hostage_killed.emit()
		if die_timer > 1000:
			queue_free()
		return
	
	shoot_player()
	
	# Over
	if state == Enum.OVER:
		sprite.frame = 3
		return
	
	# Hostage saved by Player 1 or 2
	if state == Enum.RESCUEDP1 or state == Enum.RESCUEDP2:
		flip_direction = 0 if state == Enum.RESCUEDP1 else 12
		flip()
		dead_timer += 1
		wait_timer += 1
		if wait_timer > 100:
			var randy = randi_range(0, 2)
			match randy:
				0:
					sprite.frame = 0
				1:
					sprite.frame = 4
				2:
					sprite.frame = 5
			wait_timer = 0
		return


func shoot_player():
	if state == Enum.FIREP1 or state == Enum.FIREP2:
		fire_timer += 1
		sprite.frame = 4
		if fire_timer > 10:
			sprite.frame = 5
		if fire_timer > 20:
			fire_timer = 0
		if fire_timer == 10:
			$Attack.play()
			match state:
				Enum.FIREP1:
					player_1_attacked.emit(attributes["damage"])
				Enum.FIREP2:
					player_2_attacked.emit(attributes["damage"])
		if attributes["attack_type"] == Enum.EXPLODER:
			var explode = EXPLOTION.instantiate()
			add_child(explode)
			explode.position = Vector2(position.x, 370)


func _on_area_entered(area):
	if area.is_in_group("Explotion"):
		if state != Enum.DEAD and \
				attack_direction != Enum.UP and \
				position.x < area.position.x + 90 and \
				position.x > area.position.x - 90:
			attributes["health"] = -1
			hurt()

	if area.is_in_group("Bullet"):
		if state != Enum.DYING and state != Enum.DEAD and \
				state != Enum.EVADE and \
				state != Enum.EVADEDOWN and \
				state != Enum.EVADEUP:
			var blood = BLOOD.instantiate()
			add_child(blood)
			if area.is_player_1_bullet:
				translate(Vector2(5, 0))
				blood.global_position = Vector2(global_position.x, global_position.y)
			else:
				translate(Vector2(-5, 0))
				blood.global_position = Vector2(global_position.x, area.global_position.y - 5)
			hurt()
			area.queue_free()




