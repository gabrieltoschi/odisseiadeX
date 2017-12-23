extends Node2D

var time

func _ready():
	time = get_parent().get_node("Time Controller")
	get_node("Progress/Points").set_text(str(time.victoryCount))
	if (time.gameover == 1):
		get_node("Message").set_hidden(true)
		get_node("MessageFail").set_hidden(false)
		get_node("Fail").set_hidden(false)
