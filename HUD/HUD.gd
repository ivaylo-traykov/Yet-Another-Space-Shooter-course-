extends Control

@onready var life_container = $LifeContainer
var life_icon_scene = preload("res://HUD/life_icon.tscn")

func _ready():
	clear_lives()
	add_lives(5)
	Signals.connect("on_player_life_change", _on_player_life_change)

func clear_lives():
	for child in life_container.get_children():
		child.queue_free()

func add_lives(n):
	clear_lives()
	for i in range(n):
		life_container.add_child(life_icon_scene.instantiate())
	
func _on_player_life_change(life):
	add_lives(life)
