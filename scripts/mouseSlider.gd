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
