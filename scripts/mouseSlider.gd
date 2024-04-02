extends Control

var minValue
var maxValue
var currentValue
var slider

func _ready():
	slider = $Control/sensitivitySlider
	currentValue = $Control/currentValue

func setCurrentValue(sensitivityValue):
	
	slider.value = sensitivityValue;
	currentValue.text = String (sensitivityValue);
	
	get_node('/root').get_child(0).updateSensitivity(sensitivityValue)
	


func _on_sensitivitySlider_changed():
	
	pass # Replace with function body.


func _on_sensitivitySlider_drag_ended(value_changed):
	print("slider changed", slider.value)
	setCurrentValue(slider.value)
	pass # Replace with function body.
