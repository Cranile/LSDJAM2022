extends prop

func _ready():
	pass # Replace with function body.

func storeItemUpdate():
	get_parent().itemObtained()
	print("got store item")
