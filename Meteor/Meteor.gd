extends Area2D

@export var min_speed: float = 10
@export var max_speed: float = 20
@export var min_rotation_rate: float = -20
@export var max_rotation_rate: float = 20
@export var life: int = 20

var speed = 0
var rotation_rate = 0

func _ready():
	speed = randf_range(min_speed, max_speed)
	rotation_rate = randf_range(min_rotation_rate, max_rotation_rate)
	
func _physics_process(delta):
	rotation_degrees += rotation_rate * delta
	position.y += speed * delta

func take_damage(amount):
	life -= amount
	if life <= 0:
		queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
