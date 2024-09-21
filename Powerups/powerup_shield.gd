extends Powerup

var shield_time = 6

func apply_powerup(player):
	player.apply_shield(shield_time)
