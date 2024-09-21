class_name Powerup extends Area2D

var vertical_speed = 50

func _process(delta):
	position.y += vertical_speed * delta
	

func apply_powerup(player):
	# This needs to be implemented by inheriting class
	pass


func _on_area_entered(area):
	if area is Player:
		apply_powerup(area)
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
