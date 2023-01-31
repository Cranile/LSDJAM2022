extends Area


onready var main = get_node("/root/main")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area_body_entered(body):
	print("player fell out map, wake up")
	main.goToSleep()
	pass # Replace with function body.
