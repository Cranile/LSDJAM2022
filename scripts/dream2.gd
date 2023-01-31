extends Spatial

var dreamID = 2
var ladder1
var ladder2
onready var main = get_node("/root/main")
func getDreamID():
	return dreamID

# Called when the node enters the scene tree for the first time.
func _ready():
	ladder1 = $ViewportContainer/Viewport/map/teleportPoints/spawnPoint.translation
	ladder2 = $ViewportContainer/Viewport/map/teleportPoints/house.translation
	main.enableMusic("dam")
func returnLadderPos(ladderName):
	if (ladderName == "spawn"):
		return ladder1
	if (ladderName == "house"):
		return ladder2
