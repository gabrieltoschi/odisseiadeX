extends Node2D

export var keyCount = 5
export var keyTypes = 4
export var keyNames = ["UP", "DOWN", "LEFT", "RIGHT"]
var state = 0
var keys = []
var randomKey
var actualKey = 0
var pressedKey
var lastKeyPressed = -1
var disabledSprite

func getRot(direction):
	if (direction == "LEFT"): return 0
	if (direction == "DOWN"): return 90
	if (direction == "RIGHT"): return 180
	if (direction == "UP"): return 270

func getKeyPressed(lastKeyPressed):
	if (Input.is_action_pressed("up") && lastKeyPressed != 0): return 0
	if (Input.is_action_pressed("down") && lastKeyPressed != 1): return 1
	if (Input.is_action_pressed("left") && lastKeyPressed != 2): return 2
	if (Input.is_action_pressed("right") && lastKeyPressed != 3): return 3
	return -1

func _ready():
	disabledSprite = load("Sprites/MK/dancearrow-disabled.png")

	randomize()
	# creating random keys
	pressedKey = -1
	for i in range(keyCount):
		randomKey = pressedKey
		while (randomKey == pressedKey):
			randomKey = randi() % keyTypes
		keys.append(randomKey)
		pressedKey = randomKey
	get_node("Dance Arrow "+str(actualKey+1)+"/Animator").play("Dance Arrow - Color Swap")
	set_process(true)

func _process(delta):
	for i in range(keyCount):
		get_node("Dance Arrow "+str(i+1)).set_rotd(getRot(keyNames[keys[i]]))
	
	if (actualKey >= keyCount && state != -1):
		get_node("Johnny Cage/Idle").set_active(false)
		get_node("Johnny Cage/Dance").set_active(true)
		get_node("Sub-Zero/Idle").set_active(false)
		get_node("Sub-Zero/Dance").set_active(true)
		state = 1
	
	pressedKey = getKeyPressed(lastKeyPressed)	
	if (pressedKey != -1 && actualKey < keyCount): # button press
		lastKeyPressed = pressedKey
		if (pressedKey == keys[actualKey]): # correct button
			get_node("Dance Arrow "+str(actualKey+1)+"/Animator").stop()
			get_node("Dance Arrow "+str(actualKey+1)).set_texture(disabledSprite)
			actualKey += 1
			if (actualKey < keyCount):
				get_node("Dance Arrow "+str(actualKey+1)+"/Animator").play("Dance Arrow - Color Swap")
		else: # wrong button
			get_node("Sub-Zero/Idle").set_active(false)
			get_node("Sub-Zero/Fail").set_active(true)
			get_node("Johnny Cage/Idle").set_active(false)
			get_node("Johnny Cage/Fail").set_active(true)
			keyCount = -1
			state = -1