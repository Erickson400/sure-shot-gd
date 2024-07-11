extends AnimatedSprite2D


signal on_died


enum {
	WAITING,
	HURT,
	DYING,
	DEAD,
	PISSED_OFF,
	VICTORY,
}
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
const BULLET = preload("res://scenes/main_gameplay/bullet.tscn")
const BLOOD = preload("res://scenes/main_gameplay/blood.tscn")
var state = WAITING 
var health: int = 20:
	set(value):
		health = value
		if value < 0:
			health = 0
var wait_timer = 0
var fire_timer = 0
var hurt_timer = 0
var die_timer = 0
var fiddle_timer = 0
@export var is_player_1 := true
@export var tnt: Node2D


func _ready():
	animation = "p1" if is_player_1 else "p2"
	


func _process(_delta):
	$Health.text = str(health)
	
	# Waiting
	if state == WAITING:
		wait_timer += 1
		frame = 1
		if wait_timer > 2:
			fire_timer = 0
		if wait_timer > 50:
			frame = 0
		if wait_timer > 250:
			frame = 4

	# Hurt
	if state == HURT:
		hurt_timer += 1
		frame = 5
		if hurt_timer > 25:
			state = WAITING
			wait_timer = 0

	# Dying
	if state == DYING:
		die_timer += 1
		frame = 5
		if die_timer > 10:
			frame = 10
		if die_timer > 17:
			frame = 11
			state = DEAD
			on_died.emit()
		if die_timer == 3:
			var randy = randi_range(1, 2)
			if randy == 1:
				$Die1.play()
			else:
				$Die2.play()

	# Dead
	if state == DEAD:
		frame = 11
	
	# Pissed off
	if state == PISSED_OFF:
		frame = 5
		
	# Victory
	if state == VICTORY:
		wait_timer += 1
		frame = 8
		if wait_timer > 20:
			frame = 9
		if wait_timer > 40:
			wait_timer = 0

	# Fire
	var shooting_key = "Player 1 shoot" if is_player_1 else "Player 2 shoot"
	var fiddle_key = "Tnt Left" if is_player_1 else "Tnt Right"
	if Input.is_action_pressed(shooting_key) and \
			not Input.is_action_pressed(fiddle_key) and \
			state == WAITING:
		wait_timer = 0
		fire_timer += 1
		if fire_timer > 12:
			fire_timer = 1
		
		frame = 2 if fire_timer <= 6 else 3
		
		if fire_timer == 1 or fire_timer == 7:
			var randy = randi_range(1, 5)
			if randy == 1:
				$Shoot2.play()
			else:
				$Shoot1.play()
			var bullet = BULLET.instantiate()
			get_parent().add_child(bullet)
			if is_player_1:
				bullet.is_player_1_bullet = true
				bullet.global_position = Vector2(123, randi_range(411, 421))
			else:
				bullet.is_player_1_bullet = false
				bullet.global_position = Vector2(677, randi_range(411, 421))
				
			
	# Tnt fiddle
	if Input.is_action_pressed(fiddle_key) and state == WAITING and \
			tnt.visible and tnt.is_controls_active:
		wait_timer = 0
		fiddle_timer += 1
		if fiddle_timer > 12:
			fiddle_timer = 1
		frame = 6 if fiddle_timer <= 6 else 7


func get_pissed():
	state = PISSED_OFF


func celebrate():
	state = VICTORY


func hurt_by_enemy(damage: int):
	state = HURT
	health -= damage
	
	$Hit.stream = HIT[1]
	$Hit.play()
	$Pain.stream = PAIN[1]
	$Pain.play()
	var blood = BLOOD.instantiate()
	add_child(blood)
	var randx = randf_range(global_position.x-5, global_position.x+5)
	blood.global_position = Vector2(randx, randf_range(395, 405))


func _on_hitbox_area_entered(area):
	if area.is_in_group("Explotion"):
		health = 0
		state = DYING
	elif area.is_in_group("Bullet"):
		if state == VICTORY:
			area.queue_free()
			return 
		health -= 1
		if health <= 0:
			state = DYING
		else:
			state = HURT
			hurt_sfx()
		
		var blood = BLOOD.instantiate()
		add_child(blood)
		blood.global_position = Vector2(global_position.x, area.global_position.y)
		area.queue_free()
		



func hurt_sfx():
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







