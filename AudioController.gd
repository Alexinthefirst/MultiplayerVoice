# goes onto an audio_controller with an AudioStreamPlayer (mic input) child
extends Node
@onready var input : AudioStreamPlayer2D = $Input
var idx : int
@onready var effect : AudioEffectCapture
@onready var muffledEffect : AudioEffectLowPassFilter
@onready var playback : AudioStreamGeneratorPlayback
@onready var output : AudioStreamPlayer2D = get_node("Output")

#func _enter_tree() -> void:
#	set_multiplayer_authority() # make sure this is set or stuff will absolutely go wrong
	
func _ready() -> void:
	print(get_parent().name + ": " + str(get_multiplayer_authority()))
	# we only want to initalize the mic for the peer using it
	if (is_multiplayer_authority()):
		input.stream = AudioStreamMicrophone.new()
		input.play()
		idx = AudioServer.get_bus_index("Capture")
		effect = AudioServer.get_bus_effect(idx, 1)
	
	# playback variable will be needed for playback on other peers
	playback = output.get_stream_playback()
	

func _process(delta: float) -> void:
	if (not is_multiplayer_authority()): return
	if (effect.can_get_buffer(512) && playback.can_push_buffer(512)):
		send_data.rpc(effect.get_buffer(512))
	effect.clear_buffer()
	
	# This might work actually, remains to be seen
	# stop and clear the buffer everytime to lower latency
	#output.stop()
	#playback.clear_buffer()
	#output.play()

# doesnt work right now, try again later
func apply_low_pass_filter(audio_frames: Array, alpha: float) -> Array:
	var filtered_frames = []
	var prev_frame = Vector2(0, 0)
	   
	for frame in audio_frames:
		var filtered_frame = prev_frame + alpha * (frame - prev_frame)
		filtered_frames.append(filtered_frame)
		prev_frame = filtered_frame
	
	return filtered_frames

# if not "call_remote," then the player will hear their own voice
# also don't try and do "unreliable_ordered." didn't work from my experience
@rpc("any_peer", "call_remote", "reliable")
func send_data(data : PackedVector2Array):
	if true:
		#print("Prefilter: " + str(data))
		print("Applying filter")
		var filtered_data = apply_low_pass_filter(data, 0.1)
		#print("Postfilter: " + str(data))
	for i in range(0,512):
		#print(data[i])
		playback.push_frame(data[i])


