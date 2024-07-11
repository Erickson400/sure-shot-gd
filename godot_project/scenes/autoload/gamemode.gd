extends Node
## Used to communicate between the menus and gameplay


enum {
	CAMPAIGN,
	CUSTOM,
}
var game_mode = CAMPAIGN
var active_campaign_level = 1
var campaign_level = {
	"sky": 1,
	"background": 1,
	"foreground": 1,
	"enemy_set": 1,
	"enemy_schedule": 1,
	"tnt_out": 1,
	"hostage_help": 0,
}
var custom_level = {
	"sky": 1,
	"background": 1,
	"foreground": 1,
	"enemy_set": 1,
	"enemy_schedule": 1,
	"tnt_out": 1,
	"hostage_help": 0,
}



