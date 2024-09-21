extends Node2D

const MIN_SPAWN_TIME = 1.5

var enemy_scenes = [
	preload("res://Enemy/enemy_fast.tscn"),
	preload("res://Enemy/bouncer_enemy.tscn"),
	preload("res://Enemy/SlowShooter.tscn"),
]
var meteor_scene = preload("res://Meteor/Meteor.tscn")
var spawn_time = 5.0
@onready var spawn_timer = $SpawnTimer

func _ready():
	pass

func _on_spawn_timer_timeout():
	# Spawn enemy
	var view_rect = get_viewport_rect()
	var x_pos = randi_range(view_rect.position.x, view_rect.end.x)
	var enemy_scene = enemy_scenes[randi() % enemy_scenes.size()]
	if randf() < 0.1:
		enemy_scene = preload("res://Meteor/Meteor.tscn")
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(x_pos, position.y)
	get_tree().current_scene.add_child(enemy)
	
	# Reset timer
	spawn_timer.start(spawn_time)
	spawn_time = clamp(spawn_time - 0.1, MIN_SPAWN_TIME, 5.0)
