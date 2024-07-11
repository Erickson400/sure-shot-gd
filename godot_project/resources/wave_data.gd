extends Resource
class_name WaveData


var sets = []
var schedules = []


func init():
	sets = [
		_create_set("All Troopers", [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]),
		_create_set("All Armoured Troopers", [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]),
		_create_set("All Knifemen", [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3]),
		_create_set("All Generals", [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]),
		
		_create_set("All Traitors", [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]),
		_create_set("All Special Troopers", [6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6]),
		_create_set("All Musclemen", [7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7]),
		_create_set("All Explosives Experts", [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8]),
		
		_create_set("Randomized (Without Hostages)", []),
		_create_set("Randomized (With Hostages)", []),
		_create_set("Sure Shot's Ark", [1, 1, 2, 2, 8, 8, 3, 3, 10, 10, 5, 5, 6, 6, 4]),
		_create_set("Mind Games", [4, 5, 10, 11, 5, 3, 10, 10, 5, 11, 4, 5, 5, 10, 6]),
		
		_create_set("Early Hostages", [10, 10, 10, 10, 10, 3, 1, 1, 2, 5, 7, 1, 4, 2, 6]),
		_create_set("Sure Shot's Ark", [1, 1, 2, 2, 3, 3, 4, 4, 10, 10, 5, 5, 6, 6, 6]),
		_create_set("Musclemen & Troopers", [7, 7, 1, 1, 1, 7, 1, 1, 7, 1, 7, 7, 7, 1, 1]),
		_create_set("My First Armoured Trooper", [1, 7, 2, 1, 1, 1, 7, 7, 7, 1, 1, 7, 1, 2, 2]),
	   
		 _create_set("My First Knifeman", [1, 1, 1, 7, 7, 1, 1, 2, 1, 1, 2, 7, 1, 1, 3]),
		_create_set("Novice Mixture", [1, 1, 3, 2, 1, 1, 7, 7, 1, 2, 3, 7, 1, 3, 2]),
		_create_set("My First General", [2, 2, 7, 2, 3, 1, 1, 3, 1, 2, 1, 3, 2, 4, 3]),
		_create_set("My First Hostage", [3, 1, 1, 7, 2, 2, 2, 3, 1, 1, 7, 10, 2, 3, 4]),
		
		_create_set("Easy Mixture", [3, 10, 2, 1, 7, 1, 3, 2, 4, 10, 7, 3, 2, 1, 1]),
		_create_set("My First Group Of Hostages", [4, 10, 10, 10, 2, 7, 1, 1, 2, 1, 7, 1, 3, 2, 1]),
		_create_set("My First Traitor", [3, 1, 1, 10, 2, 7, 1, 10, 2, 1, 1, 3, 4, 10, 5]),
		_create_set("Hostages & Traitors", [5, 10, 5, 10, 2, 7, 5, 1, 3, 5, 4, 5, 10, 3, 5]),
		
		_create_set("My First Explosives Expert", [1, 1, 5, 3, 2, 10, 4, 10, 2, 5, 1, 5, 8, 3, 2]),
		_create_set("Explosives In The Mix", [8, 1, 3, 8, 8, 1, 2, 10, 2, 3, 1, 5, 10, 4, 8]),
		_create_set("My First Decoy Hostage", [4, 10, 1, 5, 10, 1, 2, 11, 10, 5, 1, 3, 8, 2, 3]),
		_create_set("My First Special Trooper", [1, 11, 3, 2, 8, 4, 11, 10, 2, 7, 10, 5, 11, 5, 6]),
		
		_create_set("Normal Mixture", [5, 2, 10, 2, 3, 8, 5, 10, 6, 2, 1, 3, 11, 11, 4]),
		_create_set("Hard Mixture 1", [6, 3, 10, 5, 1, 8, 6, 11, 2, 3, 10, 11, 5, 4, 6]),
		_create_set("Hard Mixture 2", [2, 2, 6, 1, 10, 5, 6, 11, 6, 4, 3, 8, 10, 11, 6]),
		_create_set("Hostages In The Mix", [2, 10, 6, 4, 11, 3, 5, 6, 1, 5, 2, 3, 10, 11, 4]),
		
		_create_set("One Of Each", [7, 1, 2, 3, 4, 11, 10, 5, 6, 8, 7, 1, 2, 3, 6]),
		_create_set("Hostage Mania", [1, 10, 6, 11, 2, 11, 4, 10, 5, 10, 6, 11, 2, 10, 3])
	]
	
	schedules = [
		_create_schedule("Steady Stream", [100, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000]),
		_create_schedule("Big Invasion", [100, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116]),
		_create_schedule("Sure Shot's Ark", [100, 101, 500, 501, 900, 901, 1600, 1601, 2000, 2001, 2700, 2701, 3200, 3201, 3500]),
		_create_schedule("Gradual Stream", [100, 500, 1000, 1400, 1800, 2100, 2400, 2650, 2900, 3100, 3300, 3500, 3600, 3700, 3750]),
		_create_schedule("Steady Groups", [100, 102, 103, 901, 902, 903, 1800, 1801, 1802, 2700, 2701, 3201, 3202, 3203, 3204]),
		_create_schedule("Early Group", [100, 101, 102, 103, 500, 903, 1200, 1801, 2202, 2700, 3001, 3501, 4002, 4203, 4404]),
		_create_schedule("Double Invasion", [100, 110, 120, 130, 140, 150, 160, 2001, 2010, 2011, 2022, 2033, 2044, 2055, 2066]),
		_create_schedule("Irregular Stream", [100, 400, 1100, 1300, 2000, 2500, 3100, 3500, 4000, 4600, 5000, 5100, 6000, 6200, 7000]),
		_create_schedule("Fast Stream", [100, 300, 600, 900, 1200, 1500, 1800, 2100, 2400, 2700, 3000, 3300, 3600, 3900, 4200]),
	]


func _create_set(name: String, enemies: Array[int]):
	return {
		"name": name,
		"enemies": enemies,
	}


func _create_schedule(name: String, timing_array: Array[int]):
	return {
		"name": name,
		"timing": timing_array,
	}


func create_random_wave():
	# Generates random enemies for 
	# "Randomized (Without Hostages)" and
	# "Randomized (With Hostages)"
	
	for i in sets[8]["enemies"].size():
		sets[8]["enemies"][i] = randi_range(1, 8)
	for i in sets[9]["enemies"].size():
		sets[9]["enemies"][i] = randi_range(1, 11)	


