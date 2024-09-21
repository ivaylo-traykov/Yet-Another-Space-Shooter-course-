extends Powerup

@export var rapid_fire_time = 4

func apply_powerup(player):
	player.apply_rapid_fire(rapid_fire_time)
