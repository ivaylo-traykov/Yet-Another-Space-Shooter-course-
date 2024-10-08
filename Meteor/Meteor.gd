extends Area2D

@export var min_speed: float = 10
@export var max_speed: float = 20
@export var min_rotation_rate: float = -20
@export var max_rotation_rate: float = 20
@export var life: int = 20

var effect_scene = preload("res://Meteor/MeteorEffect.tscn")

var player_in_area = null
var speed = 0
var rotation_rate = 0

func _ready():
	speed = randf_range(min_speed, max_speed)
	rotation_rate = randf_range(min_rotation_rate, max_rotation_rate)

func _process(delta):
	if player_in_area:
		player_in_area.take_damage(1)

func _physics_process(delta):
	rotation_degrees += rotation_rate * delta
	position.y += speed * delta

func take_damage(amount):
	if life <= 0: return
	
	life -= amount
	if life <= 0:
		var effect = effect_scene.instantiate()
		effect.position = position
		get_parent().add_child(effect)
		Signals.emit_signal("on_score_change", 15)
		queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Player:
		player_in_area = area


func _on_area_exited(area):
	if area is Player:
		player_in_area = null
