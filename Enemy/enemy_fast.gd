extends Enemy

@export var rotation_rate = 20

func _process(delta):
	super._process(delta)
	rotate(deg_to_rad(rotation_rate) * delta)
