extends Node2D

var gameList = ["Mortal Kombat", "Metal Slug", "Call of Duty"]
var gameCount = 3
var randomGame
var gameInst
var gameNode
var sleepInst
var sleepScreen

func _ready():
	sleepInst = load("System/Sleep Screen.tscn")
	sleepScreen = sleepInst.instance()
	add_child(sleepScreen)
	set_process(true)

func _process(delta):
	if (get_node("Time Controller").gameover == 1):
		get_node("Time Controller").startTimeHUDInSleep()
		sleepScreen = sleepInst.instance()
		add_child(sleepScreen)
	else:
		if (get_node("Time Controller").controllerStartGame == true):
			# start a new microgame
			randomGame = randi() % gameCount
			gameInst = load("Games/"+gameList[randomGame]+".tscn")
			gameNode = gameInst.instance()
			add_child(gameNode)
			sleepScreen.queue_free()
			get_node("Time Controller").startTimeHUDInGame()
			get_node("Time Controller").controllerStartGame = false
	
		if (get_node("Time Controller").controllerEndGame == true):
			# end microgame
			if (get_node(gameList[randomGame]).state == 1):
				get_node("Time Controller").plusVictory()
				get_node("Time Controller").minusLimitTime()
			else:
				get_node("Time Controller").minusLive()
			
			get_node("Time Controller").startTimeHUDInSleep()
			sleepScreen = sleepInst.instance()
			add_child(sleepScreen)
			gameNode.queue_free()
			get_node("Time Controller").controllerEndGame = false

