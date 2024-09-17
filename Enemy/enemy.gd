extends Area2D
class_name Enemy

@export var vertical_speed = 100.0
@export var healrh = 5

@onready var guns = $Guns

var bullet_scene = preload("res://Bullets/enemy_bullet.tscn")
var player_in_area = null

func _process(delta):
	if player_in_area:
		player_in_area.take_damage(1)

func _physics_process(delta):
	position.y += vertical_speed * delta
	
func take_damage(amount):
	healrh -= amount
	if healrh <= 0:
		queue_free()

func fire():
	for gun in guns.get_children():
		var bullet = bullet_scene.instantiate()
		bullet.global_position = gun.global_position
		get_tree().current_scene.add_child(bullet)

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area is Player:
		player_in_area = area

func _on_area_exited(area):
	if area is Player:
		player_in_area = null
