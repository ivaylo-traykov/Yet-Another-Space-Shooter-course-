extends SlowShooter

@export var horizontal_speed = 80

var h_dir = 1

func _physics_process(delta):
	super._physics_process(delta) 
	position.x += horizontal_speed * delta * h_dir
	
	var viewRect = get_viewport_rect()
	if position.x < viewRect.position.x or position.x > viewRect.end.x:
		h_dir *= -1
