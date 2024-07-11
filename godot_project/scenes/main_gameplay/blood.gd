extends Node2D


func _ready():
	$Sprite2D.play()
	await $Sprite2D.animation_finished
	queue_free()

