extends Spatial

var dreamID = 1

onready var figureSpawnPoint = get_node("ViewportContainer/Viewport/map/figureSpawnPoint")
export var figureList = ["","",""]
onready var main = get_node("/root/main")
var figure


func _ready():
	spawnFigure()
	main.enableMusic("forest")
	pass # Replace with function body.

func getDreamID():
	return dreamID
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawnFigure():
	var figureID = main.figurine
	figure = load(figureList[figureID - 1]).instance()
	figureSpawnPoint.add_child(figure)
	figure.rotate_y(3.141593) ## its on radians!!!!
	$ViewportContainer/Viewport/map/figureSpawnPoint/waveTimer.start()

func removeFigure():
	figure.set_deferred("visible",false)
	## play particle effect
	pass

func _on_Timer_timeout():
	figure.playAnimation("wave")
	pass # Replace with function body.
