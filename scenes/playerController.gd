extends Spatial

var mouse_sens = 0.03
var move_speed = 10

var direction = Vector3()

onready var head = $Spatial/head

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

func _input(event):
	if(event) is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

func _physics_process(delta):
	direction = Vector3()
	
	if (Input.is_action_pressed("move_forward")):
		direction -= transform.basis.z
	elif (Input.is_action_pressed("move_back")):
		direction += transform.basis.z
		
	if (Input.is_action_pressed("move_left")):
		direction -= transform.basis.x
	elif (Input.is_action_pressed("move_right")):
		direction += transform.basis.x
		
	direction = direction.normalized()
	move_and_slide()
