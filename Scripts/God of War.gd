extends Node2D
var state = -1

export var maximum = 100
export var gameInit = 0
var game = gameInit

var toIncrease = false
var toPress = 1
export var increaseByUser = 3
export var decreaseByCPU = 0.1

var explosionCount = 12

func _ready():
	set_process(true)

func _process(delta):	
	if (Input.is_action_pressed("action1") && toPress == 1):
		toIncrease = true
		toPress = 2
	elif (Input.is_action_pressed("action2") && toPress == 2):
		toIncrease = true
		toPress = 1
	
	if (toIncrease == true && state != 1):
		game += increaseByUser
		toIncrease = false
	
	if (game > decreaseByCPU && state != 1): 
		game -= decreaseByCPU
	
	if (game >= maximum):
		state = 1;
		for i in range(explosionCount):
			get_node("Explosion"+str(i)+"/Animation").set_speed(1.5 + randf())
			get_node("Explosion"+str(i)+"/Animation").set_active(true)
	
	get_node("Tank Bar").set_value(game)
