extends Node
## Keeps track of game hiscore, unlocked levels
## and saving/loading system.
## Saved data is save to the User Data folder
## --------------------------------------------------
## There are 25 levels on the campaign.
## Progress goes from 1 to 26. 26 meaning all levels were completed.


const FILE_NAME = "hiscores.dat"
var progress: int = 1
var hiscores: Array = []


func _ready():
	load_game()


func save_game():
	var save_file := FileAccess.open("user://"+FILE_NAME, FileAccess.WRITE)
	save_file.store_var(progress)
	save_file.store_var(hiscores)


func load_game():
	if not FileAccess.file_exists("user://"+FILE_NAME):
		print_debug("Save data does not exist, using default values instead.")
		progress = 1
		hiscores.resize(25)
		hiscores.fill(0)
		return
	
	var load_file := FileAccess.open("user://"+FILE_NAME, FileAccess.READ)
	progress = load_file.get_var()
	hiscores = load_file.get_var()


func delete_game():
	# There is no need to delete the file.
	# I can just set the values back to default
	var save_file := FileAccess.open("user://"+FILE_NAME, FileAccess.WRITE)
	var local_hiscores: Array = []
	local_hiscores.resize(25)
	local_hiscores.fill(0)
	save_file.store_var(1)
	save_file.store_var(local_hiscores)


