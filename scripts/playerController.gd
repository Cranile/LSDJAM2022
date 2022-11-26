extends KinematicBody

var mouse_sens = 0.03 #camera movement speed
var move_speed = 10 # player walking speed
var gravity = 20 # gravity strenght

var direction = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()

onready var head = get_node("%plHead")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

func _input(event):
	#openCloseMenu
	if Input.is_action_just_pressed("escape"):
		if(Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode= Input.MOUSE_MODE_CAPTURED
	
	# Camera movement
	if(event) is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

func _physics_process(delta):
	direction = Vector3()
	
	#Gravity
	if (!is_on_floor()):
		gravity_vec += Vector3.DOWN * gravity * delta;
	else:
		gravity_vec = -get_floor_normal() * gravity
	
	#Player movement
	if (Input.is_action_pressed("move_forward")):
		direction -= transform.basis.z
	elif (Input.is_action_pressed("move_back")):
		direction += transform.basis.z
		
	if (Input.is_action_pressed("move_left")):
		direction -= transform.basis.x
	elif (Input.is_action_pressed("move_right")):
		direction += transform.basis.x
		
	direction = direction.normalized()
	var vel = direction * move_speed
	movement.z = vel.z  + gravity_vec.z
	movement.x = vel.x  + gravity_vec.x
	movement.y = gravity_vec.y
	
	move_and_slide(movement, Vector3.UP)
