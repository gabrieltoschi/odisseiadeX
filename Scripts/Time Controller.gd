extends Node2D

var startTime
var diffTime
export var victoryCount = 0
export var sleepState = true
export var maxSleepTime = 2
var sleepTime = maxSleepTime
export var minSleepTime = 0.8

export var maxLimitTime = 6
export var minLimitTime = 2
var limitTime = maxLimitTime
export var decreaseTime = 0.01
export var lives = 3
var gameover = 0

var controllerStartGame = false
var controllerEndGame = false
var sceneNode
var sceneInst
var sleepScreen

const MSEC_PER_SEC = 1000

func startTimeHUDInGame():
	get_node("HUD/Skeleton/Time").set_max(limitTime)
	get_node("HUD/Skeleton/Time").set_value(0)
	get_node("HUD/Skeleton/Time").set_step(0.01)

func startTimeHUDInSleep():
	get_node("HUD/Skeleton/Time").set_max(sleepTime)
	get_node("HUD/Skeleton/Time").set_value(0)
	get_node("HUD/Skeleton/Time").set_step(0.01)

func plusVictory():
	victoryCount += 1

func minusLimitTime():
	if (limitTime > minLimitTime): limitTime -= decreaseTime
	if (sleepTime > minSleepTime): sleepTime -= decreaseTime
	
func minusLive():
	lives -= 1
	if (lives == 2): get_node("HUD/Skeleton/Life3").set_texture(load("Sprites/life-off.png"))
	if (lives == 1): get_node("HUD/Skeleton/Life2").set_texture(load("Sprites/life-off.png"))
	if (lives == 0): get_node("HUD/Skeleton/Life1").set_texture(load("Sprites/life-off.png"))
	
func _ready():
	startTime = OS.get_ticks_msec()
	startTimeHUDInSleep()
	set_process(true)

func _process(delta):
	if (lives <= 0):
		gameover = 1
		get_node("Panel/Lives").set_text("GAME OVER")
	else:	
		diffTime = OS.get_ticks_msec() - startTime
		
		if (sleepState == true): # sleep state ON
			if (diffTime >= sleepTime * MSEC_PER_SEC):
				# end sleep time, load new microgame
				startTime = OS.get_ticks_msec()
				sleepState = false
				controllerStartGame = true
				
		else: # sleep state OFF
			if (diffTime >= limitTime * MSEC_PER_SEC):
				# end game time, unload microgame, start sleep
				startTime = OS.get_ticks_msec()
				sleepState = true
				controllerEndGame = true
		
		if (sleepState == true):
			get_node("Panel/Time").set_text("IN SLEEP")
		else:
			get_node("Panel/Time").set_text("Time: "+str(diffTime))
		get_node("HUD/Skeleton/Time").set_value(diffTime / MSEC_PER_SEC)
		get_node("Panel/Victories").set_text("Victories: "+str(victoryCount))
		
		#HUD: lives
		get_node("Panel/Lives").set_text("Lives: "+str(lives))