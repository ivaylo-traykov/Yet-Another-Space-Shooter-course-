extends Control

@onready var life_container = $LifeContainer
@onready var score_container = $Score
var life_icon_scene = preload("res://HUD/life_icon.tscn")
var score = 0

func _ready():
	clear_lives()
	add_lives(5)
	Signals.connect("on_player_life_change", _on_player_life_change)
	Signals.connect("on_score_change", _on_score_change)

func clear_lives():
	for child in life_container.get_children():
		child.queue_free()

func add_lives(n):
	clear_lives()
	for i in range(n):
		life_container.add_child(life_icon_scene.instantiate())
	
func _on_player_life_change(life):
	add_lives(life)
	
func _on_score_change(amount):
	score += amount
	score_container.text = "%06d" % score
