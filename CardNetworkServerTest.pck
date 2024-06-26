GDPC                                                                                       	   T   res://.godot/exported/1642444407/export-218a8f2b3041327d8a5756f3a245f83b-icon.res   �       '      ���<�$V�(��%�N�    T   res://.godot/exported/1642444407/export-56f0a837577a06ff966359b457b45e52-startup.scn       �      4��C�)�y1c��,    ,   res://.godot/global_script_class_cache.cfg  0
             ��Р�8���8~$}P�       res://.godot/uid_cache.bin        <       L��D��dG�R��}}�       res://Startup.gd             t�=��'��ݣ}9�5��       res://icon.svg  P
      �      C��=U���^Qu��U3       res://icon.svg.import           �       �X�3*�5�*3��?*�       res://project.binaryP      '      U�[
k�@E{���ϒ       res://startup.tscn.remap�	      e       p�&�/
vD�o%Z��    [remap]

importer="texture"
type="PlaceholderTexture2D"
uid="uid://4ulm2s5igv1y"
metadata={
"vram_texture": false
}
path="res://.godot/exported/1642444407/export-218a8f2b3041327d8a5756f3a245f83b-icon.res"
   RSRC                    PlaceholderTexture2D            ��������                                                  resource_local_to_scene    resource_name    size    script        #   local://PlaceholderTexture2D_qye47 �          PlaceholderTexture2D       
      C   C      RSRC         extends Node

var ServerIP = "127.0.0.1"

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.has_feature("dedicated_server"):
		print("starting as a server...")
		start_server()
	else:
		start_client()
	

func start_server():
	print("Starting server...")
	
	multiplayer.peer_connected.connect(self._on_client_connected)
	multiplayer.peer_disconnected.connect(self._on_client_disconnected)
	
	# Create the server
	var server = ENetMultiplayerPeer.new()
	server.create_server(8080, 2)
	multiplayer.multiplayer_peer = server

func start_client():
	print("Starting client...")
	
	multiplayer.connected_to_server.connect(self.connected_to_server)
	multiplayer.server_disconnected.connect(self.disconnected_from_server)
	
	# Create the client
	var server = ENetMultiplayerPeer.new()
	server.create_client(ServerIP, 8080)
	multiplayer.multiplayer_peer = server

func connected_to_server():
	print("Connected to server.")

func disconnected_from_server():
	print("Disconnected from server.")

func _on_client_connected(clientId):
	print("Client connected: " + str(clientId))

func _on_client_disconnected(clientId):
	print("Client disconnected: " + str(clientId))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
               RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Startup.gd ��������      local://PackedScene_f8vxf          PackedScene          	         names "         Startup    script    Node    MultiplayerSpawner    	   variants                       node_count             nodes        ��������       ����                            ����              conn_count              conns               node_paths              editable_instances              version             RSRC  [remap]

path="res://.godot/exported/1642444407/export-56f0a837577a06ff966359b457b45e52-startup.scn"
           list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             Я����   res://icon.svgf����	   res://startup.tscn    ECFG      _custom_features         dedicated_server   application/config/name         CardNetwork    application/run/main_scene         res://startup.tscn     application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg           