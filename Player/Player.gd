extends Area2D
class_name Player

@export var speed: float = 100
@export var life: int = 3
@onready var anim = $AnimatedSprite2D
@onready var bullet_scene = preload("res://Bullets/Bullet.tscn")
@onready var guns = $Guns
@onready var fire_cooldown_timer = $FireCooldown
@onready var shield_timer = $ShieldTimer
@onready var shield_sprite = $Shield

var vel := Vector2(0, 0)
var fire_cooldown: float = 0.15
var shield_cooldown = 1.5

func _ready():
	shield_sprite.visible = false
	Signals.emit_signal("on_player_life_change", life)

func _process(delta):
	if vel.x > 0:
		anim.play("right")
	elif vel.x < 0:
		anim.play("left")
	else:
		anim.play("default")
		
	if Input.is_action_pressed("shoot") and fire_cooldown_timer.is_stopped():
		fire_cooldown_timer.start(fire_cooldown)
		for gun in guns.get_children():
			var bullet = bullet_scene.instantiate()
			bullet.global_position = gun.global_position
			get_tree().current_scene.add_child(bullet)
		
	
func _physics_process(delta):
	var dirVec := Vector2(0, 0)
	
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	elif Input.is_action_pressed("move_right"):
		dirVec.x = 1
	
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1
	
	vel = dirVec.normalized() * speed
	
	position += vel * delta
	
	var viewRect := get_viewport_rect()
	
	position.x = clamp(position.x, 0, viewRect.size.x)
	position.y = clamp(position.y, 0, viewRect.size.y)

func take_damage(amount: int):
	if not shield_timer.is_stopped():
		return
	
	shield_timer.start(shield_cooldown)
	shield_sprite.visible = true
	life -= amount
	Signals.emit_signal("on_player_life_change", life)
	
	if life <= 0:
		queue_free()
	


func _on_shield_timer_timeout():
	shield_sprite.visible = false
