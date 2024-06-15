extends Area2D

func interact(caller):
	get_parent().pickup_local(caller)

