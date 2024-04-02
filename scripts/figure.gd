extends prop

export var figureID = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func figureUpdate():
	main.figureUpdate(figureID)
