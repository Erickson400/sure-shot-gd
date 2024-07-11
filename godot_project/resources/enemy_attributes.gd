extends Resource
class_name EnemyAttributes


const SPRITE_PATH = "res://assets/gfx/"
const SFX_PATH = "res://assets/sfx/"
var enemies = []


func _init():
	enemies = [
		_create_attributes("Soldier", SPRITE_PATH+"enemy1.png", Vector2(25, 40), 1, 25, 1.5, 200, 3, SFX_PATH+"shot2.wav"),
		_create_attributes("Armoured", SPRITE_PATH+"enemy2.png", Vector2(25, 40), 1, 60, 0.5, 400, 3, SFX_PATH+"shot2.wav"),
		_create_attributes("Knifeman", SPRITE_PATH+"enemy3.png", Vector2(25, 40), 1, 25, 2.5, 30, 3, SFX_PATH+"hit1.wav"),
		_create_attributes("Captain", SPRITE_PATH+"enemy4.png", Vector2(25, 40), 1, 25, 1.6, 50, 3, SFX_PATH+"shot1.wav"),
		
		_create_attributes("Traitor", SPRITE_PATH+"enemy5.png", Vector2(25, 40), 1, 25, 1.5, 200, 3, SFX_PATH+"shot2.wav"),
		_create_attributes("SAS", SPRITE_PATH+"enemy6.png", Vector2(25, 40), 1, 40, 1.5, 30, 4, SFX_PATH+"shot2.wav"),
		_create_attributes("Muscle", SPRITE_PATH+"enemy7.png", Vector2(25, 40), 1, 20, 1, 400, 1, SFX_PATH+"hit3.wav"),
		_create_attributes("TNT", SPRITE_PATH+"enemy8.png", Vector2(25, 40), 3, 20, 1.5, 200, 100, SFX_PATH+"hit2.wav"),
		
		_create_attributes("Soldier2", SPRITE_PATH+"enemy1.png", Vector2(25, 40), 1, 25, 1.5, 200, 3, SFX_PATH+"shot2.wav"),
		_create_attributes("Hostage1", SPRITE_PATH+"hostage.png", Vector2(25, 40), 2, 25, 1, 200, 0, ""),
		_create_attributes("Hostage2", SPRITE_PATH+"hostage2.png", Vector2(25, 40), 2, 25, 1, 200, 0, ""),
	]


func _create_attributes(name: String, 
		anim_sprite_path: String, 
		hitbox: Vector2,
		type: int, 
		health: int, 
		speed: float, 
		evade: int, 
		damage: int, 
		attack_sfx_path: String):
	return {
		"name": name,
		"animation_sprite": anim_sprite_path,
		"hitbox_size": hitbox,
		"attack_type": type,
		"health": health,
		"speed": speed,
		"evade": evade,
		"damage": damage,
		"attack_sfx": attack_sfx_path,
	}


