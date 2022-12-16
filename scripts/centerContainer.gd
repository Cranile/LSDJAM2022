extends ScrollContainer


onready var container = $VBoxContainer;

var menuItems;

func _ready():
	menuItems = container.get_children()
	print(container.get_child_count())
	
	pass # Replace with function body.
