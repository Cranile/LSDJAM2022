extends Spatial

var astralController
var skybox
export var rotationSpeed = 0.1

var enableCycling = true
var enableAlbedoChange = true

# Called when the node enters the scene tree for the first time.
func _ready():
	astralController = get_node("astralArea")
	skybox = get_node("slybox")
	
	pass # Replace with function body.

func _process(delta):
	if(enableCycling): #sun rotation
		astralController.rotate_x(deg2rad(rotationSpeed * delta))
	

func _on_sunArea_area_entered(area):
	print("collision")
	if area.name == "atardecer": 
		print("atardecer")
		var mat = skybox.get_active_material(0)
		mat.set_albedo(Color(0.8,0,0.23,1))
		skybox.set_surface_material(0,mat)
		
	if area.name == "anochecer":
		print("anochecer")
		var mat = skybox.get_active_material(0)
		mat.set_albedo(Color(0.23,0,0.26,1))
		skybox.set_surface_material(0,mat)

