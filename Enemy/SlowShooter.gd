extends Enemy
class_name SlowShooter

@onready var fire_timer = $FireTimer
@export var fire_rate = 1.0

func _process(delta):
	super._process(delta)
	if fire_timer.is_stopped():
		fire()
		fire_timer.start(fire_rate)
