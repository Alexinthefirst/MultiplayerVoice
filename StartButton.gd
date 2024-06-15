extends Area2D

func interact(caller):
	if caller.player == 1:
		print("SERVER STARTING")
		get_node("/root/Startup").game_has_started = true
		get_node("/root/Startup").change_level(load("res://level.tscn"))
		
	else:
		print("NOT SERVER")
