extends Node


# On load, the client should send its decklist and relics to the server (dict converted to json probably.) (this is probably unsafe as you could cheat this way, maybe send to server when you get the card)
# and then the server will shuffle that list and draw cards, send it back to the client
#
# In terms of playing cards, either rpc call or potentially property syncing node? weird way but maybe.
# Hide other players cards by just changing their image to a card back (if they even keep cards between turns idk yet)

var ServerIP = "50.101.107.247"
var game_has_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.has_feature("dedicated_server"):
		print("starting as a server...")
		start_server()
	#else:
	#	start_client()
	

# This will only work if built as headless/dedicated server
func start_server():
	print("Starting server...")
	
	
	# Create the server
	var server = ENetMultiplayerPeer.new()
	server.create_server(4433)
	multiplayer.multiplayer_peer = server
	start_game()

func start_client(joinIp):
	print("Starting client...")
	
	
	# Create the client
	var server = ENetMultiplayerPeer.new()
	server.create_client(joinIp, 4433)
	multiplayer.multiplayer_peer = server
	start_game()

func connected_to_server():
	print("Connected to server.")

func disconnected_from_server():
	print("Disconnected from server.")

func _on_client_connected(clientId):
	print("Client connected: " + str(clientId))

func _on_client_disconnected(clientId):
	print("Client disconnected: " + str(clientId))

func start_game():
	$StartMenu.hide()
	if multiplayer.is_server():
		#change_level.call_deferred(load("res://level.tscn"))
		change_level.call_deferred(load("res://lobby.tscn"))

func change_level(scene: PackedScene):
	# Remove old level if any.
	var level = $Level
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	# Add new level.
	level.add_child(scene.instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
