extends Camera

onready var player = get_node("%player")

##  CULL MASK ONLY LAYER 9
## 3DSKYBOX SHOULD ONLY BE DRAWN IN VISUAL ISNTANCE LAYER 9
func _process(_delta):
	# clone rotation of player head and body
	rotation_degrees.x = player.head.rotation_degrees.x
	rotation_degrees.y = player.rotation_degrees.y
