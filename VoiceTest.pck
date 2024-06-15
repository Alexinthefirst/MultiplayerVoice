GDPC                	                                                                         \   res://.godot/exported/133200997/export-186db935eeaee58e2ebe937d60c74ff4-audio_controller.scn�;      �      ~$9 �wK���鲷�    `   res://.godot/exported/133200997/export-19246414aa9fb561ced4b8dce477acec-default_bus_layout.res  �      �      W������?���d�oa    T   res://.godot/exported/133200997/export-36a25e342948d0ceacc500772b5412b3-player.scn  �+      �      ؎�R�x3;�=y��
    T   res://.godot/exported/133200997/export-56f0a837577a06ff966359b457b45e52-startup.scn  G      �      ��U&ZĲ���� �    X   res://.godot/exported/133200997/export-6ef4cc1f92f36a58300400127ea612ec-start_menu.scn  �J            ]EV�����K�9�.�)    d   res://.godot/exported/133200997/export-cf2e33c0090aa5b179612a81b28fa129-default_bus_layout_main.res �?      �      ���L
-ǫe���Ԟ    T   res://.godot/exported/133200997/export-d85448a68f01bbd6644b4b40ef87233e-level.scn   `       F      Z��̂��;ˑ��f���    ,   res://.godot/global_script_class_cache.cfg   T             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexp      �      �̛�*$q�*�́        res://.godot/uid_cache.bin   X            �i� �G�������Y       res://AudioController.gd�5            �+��o��6��I{       res://Player.gd �(            ��|��k�{�`T;U0L       res://PlayerInput.gdp3      S      ��F������R       res://StartMenu.gd  PF      �       I�4�����`�G��        res://assets/scripts/Startup.gd         �      ��d{�SB�LR�ZB�    $   res://audio_controller.tscn.remap   PR      m       P˻�Cl� ����.7    $   res://default_bus_layout.tres.remap  Q      o       ʦ��͜&}����3]^    (   res://default_bus_layout_main.tres.remap�R      t       a��r��{V෕i�       res://icon.svg  @T      �      C��=U���^Qu��U3       res://icon.svg.import   P      �       ���|5$����:<損       res://level.gd        M      ������"�fTH5�U       res://level.tscn.remap  pQ      b       �6�-j�p�	��)��       res://player.tscn.remap �Q      c       ������T�?�L���       res://project.binary Y      �	      �B,�h�KMAh�%߭�       res://start_menu.tscn.remap �S      g       %?��g�_�[VZ����       res://startup.tscn.remap@S      d       ��1��B+a�31;pf                extends Node


# On load, the client should send its decklist and relics to the server (dict converted to json probably.) (this is probably unsafe as you could cheat this way, maybe send to server when you get the card)
# and then the server will shuffle that list and draw cards, send it back to the client
#
# In terms of playing cards, either rpc call or potentially property syncing node? weird way but maybe.
# Hide other players cards by just changing their image to a card back (if they even keep cards between turns idk yet)

var ServerIP = "50.101.107.247"

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
		change_level.call_deferred(load("res://level.tscn"))

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
  RSRC                    AudioBusLayout            ��������                                            ,      resource_local_to_scene    resource_name 
   threshold    ratio    gain 
   attack_us    release_ms    mix 
   sidechain    script    ceiling_db    threshold_db    soft_clip_db    soft_clip_ratio    pan_pullout    time_pullout_ms 	   surround    buffer_length    bus/0/name    bus/0/solo    bus/0/mute    bus/0/bypass_fx    bus/0/volume_db    bus/0/send    bus/0/effect/0/effect    bus/0/effect/0/enabled    bus/0/effect/1/effect    bus/0/effect/1/enabled    bus/1/name    bus/1/solo    bus/1/mute    bus/1/bypass_fx    bus/1/volume_db    bus/1/send    bus/2/name    bus/2/solo    bus/2/mute    bus/2/bypass_fx    bus/2/volume_db    bus/2/send    bus/2/effect/0/effect    bus/2/effect/0/enabled    bus/2/effect/1/effect    bus/2/effect/1/enabled        $   local://AudioEffectCompressor_x73or r      !   local://AudioEffectLimiter_w2cs2 �      '   local://AudioEffectStereoEnhance_lqmfl �      !   local://AudioEffectCapture_6qyvy )         local://AudioBusLayout_twmcf `         AudioEffectCompressor             Compressor 	         AudioEffectLimiter             Limiter 	         AudioEffectStereoEnhance             StereoEnhance 	         AudioEffectCapture             Capture 	         AudioBusLayout                                                  ,      Testing                                       ��!   ,      Master "   ,      Capture #          $          %          &          '   ,      Testing (            )         *            +         	      RSRC              GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[             [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://4ulm2s5igv1y"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 extends Node

const SPAWN_RANDOM := 5.0

func _ready():
	# We only need to spawn players on the server.
	if not multiplayer.is_server():
		return

	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)

	# Spawn already connected players.
	for id in multiplayer.get_peers():
		add_player(id)

	# Spawn the local player unless this is a dedicated server export.
	if not OS.has_feature("dedicated_server"):
		add_player(1)


func _exit_tree():
	if not multiplayer.is_server():
		return
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(del_player)


func add_player(id: int):
	var character = preload("res://player.tscn").instantiate()
	# Set player id.
	print("Spawning player id " + str(id))
	character.player = id
	character.name = str(id)
	# Randomize character position.
	var pos := Vector2.from_angle(randf() * 2 * PI)
	character.position = Vector2(100, 100)
	$Players.add_child(character, true)


func del_player(id: int):
	if not $Players.has_node(str(id)):
		return
	$Players.get_node(str(id)).queue_free()
   RSRC                    PackedScene            ��������                                                  ..    Players    resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://level.gd ��������
   Texture2D    res://icon.svg Я����      local://RectangleShape2D_tkc3v �         local://PackedScene_70byq �         RectangleShape2D       
     �B  �B         PackedScene          	         names "         Level    script    Node2D    Players    MultiplayerSpawner    _spawnable_scenes    spawn_path    spawn_limit    StaticBody2D 	   position    scale 	   Sprite2D    texture    CollisionShape2D    shape    StaticBody2D4    StaticBody2D5    StaticBody2D2 	   rotation    StaticBody2D6    StaticBody2D3    	   variants                 "         res://player.tscn                    
    @^D `�D
   "�kA   ?         
     �?   �          
    �[D  -�
    `�D  �C
     ��  ^C   ��?
     �C  �D
    `�D  [C      node_count             nodes     �   ��������       ����                            ����                      ����                                       ����   	      
                       ����                          ����   	                              ����   	   	   
                       ����                          ����   	                              ����   	   
   
          	             ����             	             ����   	                              ����   	            
                       ����                          ����   	                              ����   	            
                       ����                          ����   	                              ����   	            
                       ����                          ����   	                      conn_count              conns               node_paths              editable_instances              version             RSRC          extends CharacterBody2D

@export var speed = 400

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

	# Handle movement.
	velocity = input.direction * speed
	move_and_slide()
    RSRC                    PackedScene            ��������                                                  .    player 	   position    PlayerInput 
   direction    resource_local_to_scene    resource_name    properties/0/path    properties/0/spawn    properties/0/replication_mode    properties/1/path    properties/1/spawn    properties/1/replication_mode    script    custom_solver_bias    size 	   _bundled       Script    res://Player.gd ��������   Script    res://PlayerInput.gd ��������
   Texture2D    res://icon.svg Я����   PackedScene    res://audio_controller.tscn �� E�'bQ   %   local://SceneReplicationConfig_pk15n       %   local://SceneReplicationConfig_pldx8 �         local://RectangleShape2D_016ao �         local://PackedScene_qftrn          SceneReplicationConfig                            	          
                                          SceneReplicationConfig                            	                  RectangleShape2D       
      C  C         PackedScene          	         names "         Player    platform_floor_layers    script    CharacterBody2D    MultiplayerSynchronizer    replication_config    PlayerInput 	   Sprite2D    texture    CollisionShape2D 	   position    shape 	   Camera2D    enabled    AudioController    	   variants    
   (     ��                                                   
          ?                               node_count             nodes     C   ��������       ����                                  ����                           ����                                 ����                     	   	   ����   
                              ����                     ���   	                 conn_count              conns               node_paths              editable_instances              version             RSRC      extends MultiplayerSynchronizer

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
             # goes onto an audio_controller with an AudioStreamPlayer (mic input) child
extends Node
@onready var input : AudioStreamPlayer2D = $Input
var idx : int
@onready var effect : AudioEffectCapture
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

# if not "call_remote," then the player will hear their own voice
# also don't try and do "unreliable_ordered." didn't work from my experience
@rpc("any_peer", "call_remote", "reliable")
func send_data(data : PackedVector2Array):
	for i in range(0,512):
		
		playback.push_frame(data[i])


         RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   mix_rate    buffer_length    script 	   _bundled       Script    res://AudioController.gd ��������   #   local://AudioStreamGenerator_sg2ft ^         local://PackedScene_m7pmc �         AudioStreamGenerator             PackedScene          	         names "   	      AudioController    script    Node2D    Input    bus    AudioStreamPlayer2D    Output    stream 	   autoplay    	   variants                 ,      Capture                       node_count             nodes        ��������       ����                            ����                           ����                         conn_count              conns               node_paths              editable_instances              version             RSRC               RSRC                    AudioBusLayout            ��������                                            ,      resource_local_to_scene    resource_name 
   threshold    ratio    gain 
   attack_us    release_ms    mix 
   sidechain    script    ceiling_db    threshold_db    soft_clip_db    soft_clip_ratio    pan_pullout    time_pullout_ms 	   surround    buffer_length    bus/0/name    bus/0/solo    bus/0/mute    bus/0/bypass_fx    bus/0/volume_db    bus/0/send    bus/0/effect/0/effect    bus/0/effect/0/enabled    bus/0/effect/1/effect    bus/0/effect/1/enabled    bus/1/name    bus/1/solo    bus/1/mute    bus/1/bypass_fx    bus/1/volume_db    bus/1/send    bus/2/name    bus/2/solo    bus/2/mute    bus/2/bypass_fx    bus/2/volume_db    bus/2/send    bus/2/effect/0/effect    bus/2/effect/0/enabled    bus/2/effect/1/effect    bus/2/effect/1/enabled        $   local://AudioEffectCompressor_x73or r      !   local://AudioEffectLimiter_w2cs2 �      '   local://AudioEffectStereoEnhance_lqmfl �      !   local://AudioEffectCapture_6qyvy )         local://AudioBusLayout_5ktvn `         AudioEffectCompressor             Compressor 	         AudioEffectLimiter             Limiter 	         AudioEffectStereoEnhance             StereoEnhance 	         AudioEffectCapture             Capture 	         AudioBusLayout                                                  ,      Testing                                       ��!   ,      Master "   ,      Capture #          $          %          &          '   ,      Testing (            )         *            +         	      RSRC              extends Control


func _on_join_button_pressed():
	get_parent().start_client($VBoxContainer/JoinBox/JoinIp.text)


func _on_host_button_pressed():
	get_parent().start_server()
RSRC                    PackedScene            ��������                                                  ..    Level    resource_local_to_scene    resource_name 	   _bundled    script       Script     res://assets/scripts/Startup.gd ��������   PackedScene    res://start_menu.tscn ������K      local://PackedScene_xx0ah Z         PackedScene          	         names "   
      Startup    script    Node    Level    LevelSpawner    _spawnable_scenes    spawn_path    spawn_limit    MultiplayerSpawner 
   StartMenu    	   variants                 "         res://level.tscn                                   node_count             nodes     $   ��������       ����                            ����                      ����                                 ���	                    conn_count              conns               node_paths              editable_instances              version             RSRC RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://StartMenu.gd ��������      local://PackedScene_h6cx0 
         PackedScene          	         names "      
   StartMenu    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    VBoxContainer    offset_right    offset_bottom    JoinBox    HBoxContainer    JoinIp    custom_minimum_size    placeholder_text 	   TextEdit    JoinButton    text    Button    HostBox    HostIp    HostButton    _on_join_button_pressed    pressed    _on_host_button_pressed    	   variants                        �?                             B
     �C          IP ADDRESS       JOIN
       HOST
       node_count             nodes     d   ��������       ����                                                          	   	   ����         
                             ����                          ����                                      ����            	                    ����                          ����                                      ����            
             conn_count             conns                                                              node_paths              editable_instances              version             RSRC              [remap]

path="res://.godot/exported/133200997/export-19246414aa9fb561ced4b8dce477acec-default_bus_layout.res"
 [remap]

path="res://.godot/exported/133200997/export-d85448a68f01bbd6644b4b40ef87233e-level.scn"
              [remap]

path="res://.godot/exported/133200997/export-36a25e342948d0ceacc500772b5412b3-player.scn"
             [remap]

path="res://.godot/exported/133200997/export-186db935eeaee58e2ebe937d60c74ff4-audio_controller.scn"
   [remap]

path="res://.godot/exported/133200997/export-cf2e33c0090aa5b179612a81b28fa129-default_bus_layout_main.res"
            [remap]

path="res://.godot/exported/133200997/export-56f0a837577a06ff966359b457b45e52-startup.scn"
            [remap]

path="res://.godot/exported/133200997/export-6ef4cc1f92f36a58300400127ea612ec-start_menu.scn"
         list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             �f��Ir}/   res://default_bus_layout.tresЯ����   res://icon.svg��7ק�P   res://level.tscn�L�|���t   res://player.tscnf����	   res://startup.tscn������K   res://start_menu.tscn�� E�'bQ   res://audio_controller.tscn�./�Vw-"   res://default_bus_layout_main.tres            ECFG
      application/config/name         Ship   application/run/main_scene         res://startup.tscn     application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg     audio/driver/enable_input         
   input/left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script         input/right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script         input/up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script      
   input/down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script      
   input/mute�              events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode    M      physical_keycode   M   	   key_label      M      unicode           echo          script            deadzone      ?           