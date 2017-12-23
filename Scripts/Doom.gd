extends Node2D

var loveList = [4, 1, 2, 0, 3]
export var spawnList = []
var spawnCount = 5
var randomCount = spawnCount
var enemySprites = ["enemy0", "enemy1", "enemy2", "enemy3"]
var spriteRandom = []
var spriteCount = 4

var aux

func _ready():
	randomize()
	
	randomCount = spawnCount
	while (randomCount > 0):
		aux = randi() % randomCount
		spawnList.append(loveList[aux])
		loveList.remove(aux)
		randomCount -= 1
	
	randomCount = spriteCount
	while (randomCount > 0):
		aux = randi() % randomCount
		spriteRandom.append(enemySprites[aux])
		enemySprites.remove(aux)
		randomCount -= 1
		
	for i in range(spawnCount):
		get_node("Enemy"+str(spawnList[i])).set_texture(load("Sprites/DOOM/"+spriteRandom[spawnList[i] % 4]+".png"))