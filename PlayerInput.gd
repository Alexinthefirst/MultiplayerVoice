extends MultiplayerSynchronizer

# Synchronized property.
@export var direction := Vector2()
@export var speed = 400

func _ready():
	# Only process if we are the local player
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())

func _process(delta):
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("left", "right", "up", "down")
	if (Input.is_action_just_released("mute")):
		if AudioServer.is_bus_mute(0):
			AudioServer.set_bus_mute(0, false)
		else:
			AudioServer.set_bus_mute(0, true)
		print(AudioServer.is_bus_mute(0))
	
	if (Input.is_action_just_pressed("Interact")):
		if get_parent().Interactable != null:
			get_parent().Interactable.interact(get_parent())
