extends CharacterBody2D

@export var speed = 400
var default_audio_volume_db = 0

var Interactable
var HeldItem : Item

var AudioEffectChecks = [] 

# Set by the authority, synchronized on spawn.
@export var player := 1 :
	set(id):
		player = id
		# Give authority over the player input to the appropriate peer.
		$PlayerInput.set_multiplayer_authority(id)
		$AudioController.set_multiplayer_authority(id)

# Player synchronized input.
@onready var input = $PlayerInput

func _ready():
	# Set the camera as current if we are this player.
	if player == multiplayer.get_unique_id():
		$Camera2D.enabled = true
	# Only process on server.
	# EDIT: Let the client simulate player movement too to compesate network input latency.
	# set_physics_process(multiplayer.is_server())


func _physics_process(delta):
	
	var space_state = get_world_2d().direct_space_state # Get the space state to be able to raycast
	if AudioEffectChecks.size() > 0:
		for body in AudioEffectChecks: # for every player in our area
			var query = PhysicsRayQueryParameters2D.create(position, body.position) # query from our position to theirs
			var result = space_state.intersect_ray(query) # cast the ray
			if result.size() > 0: # if we have hit something
				if result.get("collider") is CharacterBody2D:
					#body.get_node("AudioController").get_node("Output").set_bus("Master")
					# we are gonna try and fake it using a few things on the output due to capture and audiostreamgenerator using audioframes so effects dont work
					body.get_node("AudioController").get_node("Output").volume_db = default_audio_volume_db
					body.get_node("AudioController").get_node("Output").attenuation = 1
					self.modulate = Color(1, 1, 1, 1)
				else:
					#body.get_node("AudioController").get_node("Output").set_bus("Muffled")
					# we are gonna try and fake it using a few things on the output due to capture and audiostreamgenerator using audioframes so effects dont work
					body.get_node("AudioController").get_node("Output").volume_db = default_audio_volume_db - 20
					body.get_node("AudioController").get_node("Output").attenuation = 0.7
					self.modulate = Color(0, 0, 0, 1)
	
	# Handle movement.
	velocity = input.direction * speed
	move_and_slide()

# use this to check if we raycast for audio checking
func _on_audio_area_body_entered(body):
	if (body != self):
		if (body is CharacterBody2D):
			AudioEffectChecks.append(body)


func _on_audio_area_body_exited(body):
	if (body != self):
		if (body is CharacterBody2D):
			body.get_node("AudioController").get_node("Output").bus = "Master"
			AudioEffectChecks.erase(body)

func _on_interact_area_area_entered(area):
	if area.is_in_group("Interactable"):
		if (player == multiplayer.get_unique_id()):
			$InteractPrompt.visible = true
			Interactable = area


func _on_interact_area_area_exited(area):
	if area.is_in_group("Interactable"):
		if (player == multiplayer.get_unique_id()):
			$InteractPrompt.visible = false
			Interactable = null
