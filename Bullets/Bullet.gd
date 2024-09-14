extends Area2D

var speed : float = 800

func _physics_process(delta):
	position.y -= speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("damageable"):
		area.take_damage(1)
		queue_free()
