extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start():
	self.visible = true
	get_node("bunny End").enableInteraction()
	get_node("bunny End/bunny").playAnimation("idle")
	get_node("doorCol/CollisionShape").disabled = false
	print("start ending scene")
