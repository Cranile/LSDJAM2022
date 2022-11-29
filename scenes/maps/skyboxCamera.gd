extends Camera

onready var player = get_node("%player")
func _process(delta):
	# clone rotation of player head and body
	rotation_degrees.x = player.head.rotation_degrees.x
	rotation_degrees.y = player.rotation_degrees.y
