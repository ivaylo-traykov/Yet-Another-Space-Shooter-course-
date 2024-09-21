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
@onready var rapid_fire_timer = $RapidFireTimer

var vel := Vector2(0, 0)
var fire_cooldown_default = 0.15
var fire_cooldown_rapid = 0.08
var fire_cooldown = fire_cooldown_default
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
	
	life -= amount
	Signals.emit_signal("on_player_life_change", life)
	
	apply_shield(shield_cooldown)
	
	var camera = get_tree().current_scene.find_child("Camera", true, false)
	camera.shake(10)
	
	if life <= 0:
		queue_free()
	

func apply_shield(time):
	shield_timer.start(time + shield_timer.time_left)
	shield_sprite.visible = true


func apply_rapid_fire(time):
	fire_cooldown = fire_cooldown_rapid
	rapid_fire_timer.start(time + rapid_fire_timer.time_left)


func apply_life():
	life += 1
	Signals.emit_signal("on_player_life_change", life)


func _on_shield_timer_timeout():
	shield_sprite.visible = false


func _on_rapid_fire_timer_timeout():
	fire_cooldown = fire_cooldown_default
