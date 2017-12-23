extends Node2D

var state = 0

export var maxRange = 100
export var rightRange = 20

var game = -maxRange
export var increase = 5
var plusminus = true

var aimVector
var gunVector

var counter = 0

func _ready():
	aimVector = get_node("Aim").get_pos()
	gunVector = get_node("Gun").get_pos()
	set_process(true)
	
func _process(delta):
	counter += delta
	if (counter >= 1):
		increase += 1
		counter = 0
	
	if (Input.is_action_pressed("action1") || Input.is_action_pressed("action2")):
		if (-rightRange <= game && game <= rightRange):
			state = 1
			get_node("Win/Animation").set_active(true)
		else:
			state = -1
			get_node("Lose/Animation").set_active(true)
	
	if (state == 0):	
		if (game >= maxRange): plusminus = false
		if (game <= -maxRange): plusminus = true
		
		if (plusminus == true): game += increase
		else: game -= increase
		
		aimVector["x"] = game + maxRange
		gunVector["x"] = aimVector["x"] + 20
		get_node("Aim").set_pos(aimVector)
		get_node("Gun").set_pos(gunVector)