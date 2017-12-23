extends Node2D
var state = -1

export var maxPoints = 100
export var gameInit = 0
var game = gameInit

export var maxTimes = 4
export var timesInit = 0
var times = timesInit

var direction = "UP"
export var increaseByUser = 2.5

func _ready():
	set_process(true)
	
func _process(delta):
	if (times >= maxTimes):
		state = 1
		get_node("Direction").set_text("YOU WIN")

	if (state != 1):
		if (Input.is_action_pressed("up") && direction == "UP"):
			game += increaseByUser
		elif (Input.is_action_pressed("down") && direction == "DOWN"):
			game += increaseByUser
			
		if (game >= maxPoints):
			times += 1
			game = gameInit
			if (direction == "UP"): direction = "DOWN"
			elif (direction == "DOWN"): direction = "UP"
		
		get_node("Direction").set_text("Go to "+direction)
		
	get_node("Complete").set_text("Complete: "+str(game))
	get_node("Times").set_text("Times: "+str(times)+"/"+str(maxTimes))


