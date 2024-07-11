extends Node
## Shared Enums used throughout scripts.
## If the enum is not used elsewhere then it'll
## be defined localy in the scene script.


# Enemy
enum {
	SOLDIER = 1,
	HOSTAGE,
	EXPLODER,
}
enum {
	WAITING,
	RUNNING,
	EVADEDOWN,
	EVADE,
	
	EVADEUP,
	HURT,
	DYING,
	DEAD,
	
	FIREP1,
	FIREP2,
	OVER, # 10
	RESCUEDP1,
	
	RESCUEDP2,
}
enum {
	UP,
	LEFT,
	RIGHT,
}


