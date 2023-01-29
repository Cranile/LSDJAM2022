extends Spatial

var dreamID = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var figureSpawnPoint = get_node("ViewportContainer/Viewport/map/figureSpawnPoint")
export var figureList = ["","",""]
var figure
# Called when the node enters the scene tree for the first time.
func _ready():
	spawnFigure()
	pass # Replace with function body.

func getDreamID():
	return dreamID
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawnFigure():
	var figureID = get_node("/root/main").figurine
	figure = load(figureList[figureID - 1]).instance()
	figureSpawnPoint.add_child(figure)
	figure.rotate_y(3.141593) ## its on radians!!!!
	$ViewportContainer/Viewport/map/figureSpawnPoint/waveTimer.start()


func _on_Timer_timeout():
	figure.playAnimation("wave")
	pass # Replace with function body.
