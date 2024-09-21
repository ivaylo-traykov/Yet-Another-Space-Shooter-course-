extends Node2D

const MIN_SPAWN_TIME = 1.5

var enemy_scenes = [
	preload("res://Enemy/enemy_fast.tscn"),
	preload("res://Enemy/bouncer_enemy.tscn"),
	preload("res://Enemy/SlowShooter.tscn"),
]
var powerup_scenes = [
	preload("res://Powerups/powerup_shield.tscn"),
	preload("res://Powerups/powerup_rapid_fire.tscn"),
	preload("res://Powerups/powerup_life.tscn"),
]

var meteor_scene = preload("res://Meteor/Meteor.tscn")
var spawn_time = 5.0
var min_powerup_spawn_time = 3
var max_powerup_spawn_time = 20

@onready var spawn_timer = $SpawnTimer
@onready var powerup_timer = $PowerupTimer

func _ready():
	pass

func get_random_spawn_pos() -> Vector2:
	var view_rect = get_viewport_rect()
	var x_pos = randi_range(view_rect.position.x, view_rect.end.x)
	return Vector2(x_pos, position.y)

func _on_spawn_timer_timeout():
	# Spawn enemy
	var enemy_scene = enemy_scenes[randi() % enemy_scenes.size()]
	if randf() < 0.1:
		enemy_scene = preload("res://Meteor/Meteor.tscn")
	var enemy = enemy_scene.instantiate()
	enemy.position = get_random_spawn_pos()
	get_tree().current_scene.add_child(enemy)
	
	# Reset timer
	spawn_timer.start(spawn_time)
	spawn_time = clamp(spawn_time - 0.1, MIN_SPAWN_TIME, 5.0)


func _on_powerup_timer_timeout():
	var powerup_scene = powerup_scenes[randi() % powerup_scenes.size()]
	var powerup = powerup_scene.instantiate()
	powerup.position = get_random_spawn_pos()
	get_tree().current_scene.add_child(powerup)
	
	# Reset timer
	powerup_timer.start(randi_range(min_powerup_spawn_time, max_powerup_spawn_time))
	
	
