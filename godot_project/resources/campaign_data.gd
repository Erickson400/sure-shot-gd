extends Resource
class_name CampaignData


var level_name = [
	"Area 1:1", "Area 1:2", "Area 1:3", "Area 1:4", "Area 1:5",
	"Area 2:1", "Area 2:2", "Area 2:3", "Area 2:4", "Area 2:5",
	"Area 3:1", "Area 3:2", "Area 3:3", "Area 3:4", "Area 3:5",
	"Area 4:1", "Area 4:2", "Area 4:3", "Area 4:4", "Area 4:5",
	"Area 5:1", "Area 5:2", "Area 5:3", "Area 5:4", "Area 5:5"
]
var stories = [
	[
		"A few groups of Troopers and Musclemen patrol this area. Shouldn't be too much trouble.",
		"This is our first time using the Sure Shot tactic! Be careful until we get used to it.",
	],
	[
		"It looks like they've called out some Armoured Troopers!",
		"They'll take a lot of punishment, but don't be too careless...",
	],
	[
		"They've grown cautious about traveling in groups - they're more spread out over here. ",
		"We've got to be extra careful about dropping them...",
	],
	[
		"I can't believe i didn't spot that last Knifeman! They're a devious breed.",
		"I've located a few of them in this area. Don't take your eyes of them...",
	],
	[
		"It looks like they don't want us to advance out of these Grasslands.",
		"They've formed two large groups. Let's blast our way through!",
	],
	[
		"I think i can see some sort of General in this area!",
		"We must be getting close to their Base Camp...",
	],
	[
		"There's someone over here wearing OUR colours?! It could be a Traitor or a Hostage.",
		"Keep your eyes peeled - if they're not armed we don't want to kill them...",
	],
	[
		"That Hostage advised us to go through this Knifeman Training Facility.",
		"This could be very tricky, but it's our best route forward...",
	],
	[
		"I see more Hostages in this area. We must be getting closer to the Camp.",
		"Watch your fire - we must not kill our own men...",
	],
	[
		"They're starting to use Hostages as shields?! There's a whole group of them here.",
		"They know we won't fire on our own men. Stay cool and shoot around them...",
	],
	[
		"This is their Base Camp. There should be a lot of Hostages around here.",
		"I think this is where they train Traitors as well. Keep your eyes open...",
	],
	[
		"I was right about the Traitors! There are even more of them in this area.",
		"They're lost causes - we have to kill them like all of the others...",
	],
	[
		"It all happens in the Base Camp - they're even producing explosives over here!",
		"If you see an enemy handling TNT, be careful where you kill him!!!",
	],
	[
		"This is their training facility for Explosives Experts! Things could get ugly.",
		"There shouldn't be any Hostages to worry about. Fire at will...",
	],
	[
		"This is making me nervous. They're sending more Explosives Experts into the field!",
		"Watch where you kill them - don't let the Hostages go down with them...",
	],
	[
		"These mountainous areas could be quite unpredictable. The enemy train some of their",
		"toughest troopers in these conditions. This particular area looks okay though...",
	],
	[
		"Did you notice that Hostage?! They're playing with our minds now, dressing OUR",
		"men in THEIR colours! Be extra careful that you don't accidentally shoot them...",
	],
	[
		"That Special Trooper took us by surprise! Things are getting difficult now.",
		"We've got to concentrate on the Hostage situation amongst units like that?!",
	],
	[
		"Oh no, i'm sure i can see multiple Special Troopers over here!",
		"These guys are really testing our Sure Shot tactic...",
	],
	[
		"This area is filled with Special Troopers. It must be their training ground.",
		"It's all that stands between us and the Coast, so we have to do it...",
	],
	[
		"This is the final push. If we can advance towards the very edge of the Coast then we",
		"can finally get out of here. Just make sure we take all Hostages with us...",
	],
	[
		"Did you notice that the Hostages weren't shouting for us?! They must have been gagged!",
		"We've got to be extremely careful about who we shoot at now...",
	],
	[
		"They've called back enemies of all kinds to stop us leaving here alive!",
		"The animals seem to coming in two by two...",
	],
	[
		"I was right - I think there's at least one of EVERY enemy type over here!",
		"At least we'll get to say 'goodbye' to everyone before we leave...",
	],
	[
		"This is it. If we can clear this area we can make our exit! They've formed two",
		"huge groups again. Only problem is our Hostages are stuck amongst them...",
	],
]
var level = []


func init():
	level = [
		_create_level_data(1, 1, 1, 15, 5, 1, 1), # 1
		_create_level_data(3, 1, 2, 16, 6, 1, 1), # 2
		_create_level_data(4, 1, 4, 17, 1, 1, 1), # 3
		_create_level_data(1, 1, 1, 18, 8, 1, 1), # 4
		_create_level_data(2, 1, 4, 18, 7, 0, 1), # 5
		_create_level_data(4, 1, 3, 19, 1, 1, 1), # 6
		_create_level_data(1, 2, 3, 20, 8, 1, 1), # 7
		_create_level_data(2, 8, 1, 3, 4, 0, 1),  # 8
		_create_level_data(3, 2, 1, 21, 4, 1, 1), # 9
		
		_create_level_data(1, 2, 2, 22, 6, 1, 1), # 10
		_create_level_data(1, 8, 2, 23, 8, 1, 1), # 11
		_create_level_data(4, 8, 6, 24, 1, 1, 1), # 12
		_create_level_data(3, 8, 1, 25, 1, 1, 1), # 13
		_create_level_data(4, 8, 5, 8, 8, 0, 1),  # 14
		_create_level_data(3, 3, 7, 26, 5, 1, 1), # 15
		_create_level_data(1, 6, 7, 26, 5, 1, 1), # 16
		_create_level_data(3, 6, 3, 28, 8, 1, 1), # 17
		_create_level_data(4, 7, 5, 29, 5, 0, 1), # 18
		_create_level_data(1, 6, 5, 30, 8, 1, 1), # 19
		
		_create_level_data(2, 7, 4, 6, 4, 1, 1),  # 20
		_create_level_data(2, 3, 2, 31, 5, 0, 0), # 21
		_create_level_data(3, 8, 6, 12, 4, 1, 0), # 22
		_create_level_data(1, 4, 2, 11, 3, 0, 0), # 23
		_create_level_data(4, 4, 5, 33, 8, 1, 0), # 24
		_create_level_data(2, 5, 6, 32, 7, 0, 0), # 25
	]


func _create_level_data(sky: int, 
		background: int, 
		foreground: int,
		enemy_set: int, 
		enemy_schedule: int, 
		tnt_out: int, 
		host_help: int) -> Dictionary:
	return {
		"sky": sky,
		"background": background,
		"foreground": foreground,
		"enemy_set": enemy_set,
		"enemy_schedule": enemy_schedule,
		"tnt_out": tnt_out,
		"host_help": host_help,
	}
