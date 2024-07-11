extends Node2D


const BULLET_SPEED = 10
@export var is_player_1_bullet = true
var played_rico = false

func _ready():
	$BulletSprite.frame = 0 if is_player_1_bullet else 1
	RicoSound.rico.finished.connect(_on_rico_finished)


func _process(_delta):
	if is_player_1_bullet:
		translate(Vector2.RIGHT * BULLET_SPEED)
	else:
		translate(Vector2.LEFT * BULLET_SPEED)


func _on_area_entered(area):
	if area.is_in_group("Bullet") and not played_rico:
		played_rico = true
		RicoSound.play()
		hide()


func _on_rico_finished():
	queue_free()
