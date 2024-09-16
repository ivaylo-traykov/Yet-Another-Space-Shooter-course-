extends Area2D

var speed : float = 800
var bullet_effect_scene = preload("res://Bullets/bullet_effect.tscn")

func _physics_process(delta):
	position.y -= speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("damageable"):
		var effect = bullet_effect_scene.instantiate()
		effect.position = position
		get_parent().add_child(effect)
		area.take_damage(1)
		queue_free()
