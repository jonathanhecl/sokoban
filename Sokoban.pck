GDPC                �                                                                         P   res://.godot/exported/133200997/export-06a1a1284033147b2f9035f533de0da1-box.scn        l      ֆ1x�9
'�(0 �M    P   res://.godot/exported/133200997/export-07690686bd1a72f71ae2b53bb79af276-wall.scn       �      �A���p�.ɿ6}u_C    T   res://.godot/exported/133200997/export-234fb6894ec6226e856ab7f825500d3d-player.scn          �      EV��h��u^PVۨ~�    P   res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn�%      [      �+ YDn���^��i    P   res://.godot/exported/133200997/export-6fd2e10918c5b5746df14be5ef194f35-spot.scn�      �      ��s9��
��7���    ,   res://.godot/global_script_class_cache.cfg  p8             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�      �      �Yz=������������       res://.godot/uid_cache.bin  P<      �       �&��'f}H|�
�ς       res://icon.svg  �8      �      C��=U���^Qu��U3       res://icon.svg.import   �$      �       ����fQk�]� mzC       res://main.gd   �4      k      ڳg˓㪎������!       res://main.tscn.remap    8      a       �J�Sw� ������       res://project.binary =      �      0Ø�4-���
��       res://scenes/box.gd p      �      �M$�b&��/�<&��/       res://scenes/box.tscn.remap �6      `       �x(�)���B����       res://scenes/player.gd  �      ^      �Ь���?�ާ3#��        res://scenes/player.tscn.remap  P6      c       2�A�Z͈�BJbB       res://scenes/spot.gd      |      ��L��*����J�,7�R       res://scenes/spot.tscn.remap 7      a        Lhu������DP\o �       res://scenes/wall.tscn.remap�7      a       zQ�ϟN�n	]�L@�    ��KRSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://scenes/player.gd ��������
   Texture2D    res://icon.svg �\#�_�      local://RectangleShape2D_tg665 �         local://PackedScene_s5mdx �         RectangleShape2D       
   �{�A�k�A         PackedScene          	         names "         Player    script    CharacterBody2D    SpritePlayer 	   position    scale    texture 	   centered 	   Sprite2D    CollisionShape2D    shape 
   RayCast2D    target_position    	   variants    	             
   �{,�{,
   ��u>��u>                
   33sA33sA          
     pA  �A
   �{,   B      node_count             nodes     .   ��������       ����                            ����                                       	   	   ����         
                        ����                         conn_count              conns               node_paths              editable_instances              version             RSRC�extends CharacterBody2D

@onready var ray = $RayCast2D

const SIZE_TILE = 32

var inputs = {
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN,
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
}

func _unhandled_input(event):
	for direction in inputs.keys():
		if event.is_action_pressed(direction):
			#if !tween.is_running():
			move(direction)
		if event.is_action_released("ui_cancel"):
			get_tree().reload_current_scene()

func move(direction):
	var next_position = inputs[direction] * SIZE_TILE
	var final_position = position + next_position
	ray.target_position = next_position
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += next_position
		get_parent().moves += 1
	else:
		var collider = ray.get_collider()
		if collider.is_in_group("box"):
			if collider.move(direction):
				position += next_position
				get_parent().moves += 1
SRSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://scenes/box.gd ��������      local://RectangleShape2D_a6lly V         local://PackedScene_8l1on w         RectangleShape2D             PackedScene          	         names "         Box    script    box    CharacterBody2D    RectBox    offset_right    offset_bottom    color 
   ColorRect    CollisionShape2D 	   position    scale    shape 
   RayCast2D    target_position    	   variants                       B             �?  �?
     �A  �A
   33�?33�?          
   �{,   B      node_count             nodes     /   ��������       ����                              ����                                 	   	   ����   
                                    ����   
                      conn_count              conns               node_paths              editable_instances              version             RSRCz:��extends CharacterBody2D

@onready var ray = $RayCast2D
const SIZE_TILE = 32

var inputs = {
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN,
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
}

func move(direction):
	var next_position = inputs[direction] * SIZE_TILE
	ray.target_position = next_position
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += next_position
		return true
	return false
extends Area2D

const COLOR_FREE = "00ff04"
const COLOR_OCCUPED = "ffffff"

@onready var rect = $RectSpot
var occupied = false

func _onready():
	rect.color = COLOR_FREE

func _on_body_entered(body):
	if body.is_in_group("box"):
		rect.color = COLOR_OCCUPED
		occupied = true


func _on_body_exited(body):
	if body.is_in_group("box"):
		rect.color = COLOR_FREE
		occupied = false
HH�CRSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://scenes/spot.gd ��������      local://RectangleShape2D_a6lly W         local://PackedScene_382c4 x         RectangleShape2D             PackedScene          	         names "         Spot    script    Area2D 	   RectSpot    offset_right    offset_bottom    color 
   ColorRect    CollisionShape2D 	   position    scale    shape    _on_body_entered    body_entered    _on_body_exited    body_exited    	   variants                       B         �?���<  �?
     �A  �A
   33�?33�?                node_count             nodes     #   ��������       ����                            ����                                       ����   	      
                      conn_count             conns                                                                node_paths              editable_instances              version             RSRCC u2~��=�����,RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled           local://RectangleShape2D_2fv4m +         local://PackedScene_3a7pu L         RectangleShape2D             PackedScene          	         names "         Wall    StaticBody2D 	   RectWall    offset_right    offset_bottom    color 
   ColorRect    CollisionShape2D 	   position    scale    shape    	   variants             B     �?    ��P=  �?
     �A  �A
     �?  �?                node_count             nodes     !   ��������       ����                      ����                                         ����         	      
                conn_count              conns               node_paths              editable_instances              version             RSRC�!,�GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح����mow�*��f�&��Cp�ȑD_��ٮ}�)� C+���UE��tlp�V/<p��ҕ�ig���E�W�����Sթ�� ӗ�A~@2�E�G"���~ ��5tQ#�+�@.ݡ�i۳�3�5�l��^c��=�x�Н&rA��a�lN��TgK㼧�)݉J�N���I�9��R���$`��[���=i�QgK�4c��%�*�D#I-�<�)&a��J�� ���d+�-Ֆ
��Ζ���Ut��(Q�h:�K��xZ�-��b��ٞ%+�]�p�yFV�F'����kd�^���:[Z��/��ʡy�����EJo�񷰼s�ɿ�A���N�O��Y��D��8�c)���TZ6�7m�A��\oE�hZ�{YJ�)u\a{W��>�?�]���+T�<o�{dU�`��5�Hf1�ۗ�j�b�2�,%85�G.�A�J�"���i��e)!	�Z؊U�u�X��j�c�_�r�`֩A�O��X5��F+YNL��A��ƩƗp��ױب���>J�[a|	�J��;�ʴb���F�^�PT�s�)+Xe)qL^wS�`�)%��9�x��bZ��y
Y4�F����$G�$�Rz����[���lu�ie)qN��K�<)�:�,�=�ۼ�R����x��5�'+X�OV�<���F[�g=w[-�A�����v����$+��Ҳ�i����*���	�e͙�Y���:5FM{6�����d)锵Z�*ʹ�v�U+�9�\���������P�e-��Eb)j�y��RwJ�6��Mrd\�pyYJ���t�mMO�'a8�R4��̍ﾒX��R�Vsb|q�id)	�ݛ��GR��$p�����Y��$r�J��^hi�̃�ūu'2+��s�rp�&��U��Pf��+�7�:w��|��EUe�`����$G�C�q�ō&1ŎG�s� Dq�Q�{�p��x���|��S%��<
\�n���9�X�_�y���6]���մ�Ŝt�q�<�RW����A �y��ػ����������p�7�l���?�:������*.ո;i��5�	 Ύ�ș`D*�JZA����V^���%�~������1�#�a'a*�;Qa�y�b��[��'[�"a���H�$��4� ���	j�ô7�xS�@�W�@ ��DF"���X����4g��'4��F�@ ����ܿ� ���e�~�U�T#�x��)vr#�Q��?���2��]i�{8>9^[�� �4�2{�F'&����|���|�.�?��Ȩ"�� 3Tp��93/Dp>ϙ�@�B�\���E��#��YA 7 `�2"���%�c�YM: ��S���"�+ P�9=+D�%�i �3� �G�vs�D ?&"� !�3nEФ��?Q��@D �Z4�]�~D �������6�	q�\.[[7����!��P�=��J��H�*]_��q�s��s��V�=w�� ��9wr��(Z����)'�IH����t�'0��y�luG�9@��UDV�W ��0ݙe)i e��.�� ����<����	�}m֛�������L ,6�  �x����~Tg����&c�U��` ���iڛu����<���?" �-��s[�!}����W�_�J���f����+^*����n�;�SSyp��c��6��e�G���;3Z�A�3�t��i�9b�Pg�����^����t����x��)O��Q�My95�G���;w9�n��$�z[������<w�#�)+��"������" U~}����O��[��|��]q;�lzt�;��Ȱ:��7�������E��*��oh�z���N<_�>���>>��|O�׷_L��/������զ9̳���{���z~����Ŀ?� �.݌��?�N����|��ZgO�o�����9��!�
Ƽ�}S߫˓���:����q�;i��i�]�t� G��Q0�_î!�w��?-��0_�|��nk�S�0l�>=]�e9�G��v��J[=Y9b�3�mE�X�X�-A��fV�2K�jS0"��2!��7��؀�3���3�\�+2�Z`��T	�hI-��N�2���A��M�@�jl����	���5�a�Y�6-o���������x}�}t��Zgs>1)���mQ?����vbZR����m���C��C�{�3o��=}b"/�|���o��?_^�_�+��,���5�U��� 4��]>	@Cl5���w��_$�c��V��sr*5 5��I��9��
�hJV�!�jk�A�=ٞ7���9<T�gť�o�٣����������l��Y�:���}�G�R}Ο����������r!Nϊ�C�;m7�dg����Ez���S%��8��)2Kͪ�6̰�5�/Ӥ�ag�1���,9Pu�]o�Q��{��;�J?<�Yo^_��~��.�>�����]����>߿Y�_�,�U_��o�~��[?n�=��Wg����>���������}y��N�m	n���Kro�䨯rJ���.u�e���-K��䐖��Y�['��N��p������r�Εܪ�x]���j1=^�wʩ4�,���!�&;ج��j�e��EcL���b�_��E�ϕ�u�$�Y��Lj��*���٢Z�y�F��m�p�
�Rw�����,Y�/q��h�M!���,V� �g��Y�J��
.��e�h#�m�d���Y�h�������k�c�q��ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[  ���B��ѻ[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://rbeg0a02db2t"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://main.gd ��������   PackedScene    res://scenes/wall.tscn �ܔN5�mM   PackedScene    res://scenes/box.tscn �;x�S   PackedScene    res://scenes/spot.tscn �LE��Xa   PackedScene    res://scenes/player.tscn w��Ō+      local://PackedScene_thmfg �         PackedScene          	         names "   =      Node2D    script 	   Camera2D    anchor_mode    zoom    Walls    Wall 	   position    Wall3    Wall4    Wall37    Wall38    Wall5    Wall6    Wall7    Wall8    Wall9    Wall10    Wall11    Wall12    Wall13    Wall14    Wall15    Wall16    Wall17    Wall18    Wall19    Wall20    Wall21    Wall22    Wall23    Wall24    Wall25    Wall26    Wall27    Wall28    Wall29    Wall30    Wall31    Wall32    Wall33    Wall34    Wall35    Wall36    Wall2    Boxes    Box    Box2    Box3    Spots    Spot    Spot2    Spot3    Player    MovesLabel    offset_left    offset_top    offset_right    offset_bottom    text    Label    	   variants    8                    
     �?  �?         
     �C  �B
     �C  �B
     �C  �B
     �C  �B
     �C   C
     �C   C
     �C   C
     �C  @C
     `C  @C
     �C   C
     �C  @C
     �C  `C
     �C  �C
     �C  �C
     �C  �C
     �C  �C
     �C  `C
     `C  �B
     @C  �B
      C  @C
      C   C
      C   C
      C  �B
      C  �B
      C  @C
     �B  @C
     �B  `C
     �B  �C
     �B  �C
     �B  �C
      C  �C
      C  �C
     @C  �C
     `C  �C
     �C  �C
     `C  `C
     `C  �C
     �C  �B         
     @C  �C
      C  �C
     �C  `C         
     �C  �B
     �C  �B
     �C  �B         
     @C   C      B     	C     hB   	   Moves: 0       node_count    3         nodes     �  ��������        ����                            ����                                  ����               ���                          ���                          ���	                          ���
                          ���                          ���            	              ���            
              ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                          ���                           ���!                          ���"                          ���#                           ���$            !              ���%            "              ���&            #              ���'            $              ���(            %              ���)            &              ���*            '              ���+            (              ���,            )                   -   ����        )       ���.   *         +       )       ���/   *         ,       )       ���0   *         -                   1   ����        -       ���2   .         /       -       ���3   .         0       -       ���4   .         1               ���5   2         3               <   6   ����   7   4   8   4   9   5   :   6   ;   7             conn_count              conns               node_paths              editable_instances              version             RSRCiW�lextends Node2D

var game_end = false
var moves = 0

func _process(delta):
	if game_end:
		return
	$MovesLabel.text = "Moves: " + str(moves)
	var spots = $Spots.get_child_count()
	for i in $Spots.get_children():
		if i.occupied:
			spots -= 1

	if spots == 0:
		print("VICTORY, total moves: " + str(moves))
		get_tree().reload_current_scene()
		game_end = true
		
��*[remap]

path="res://.godot/exported/133200997/export-234fb6894ec6226e856ab7f825500d3d-player.scn"
m+� EEWc���0[remap]

path="res://.godot/exported/133200997/export-06a1a1284033147b2f9035f533de0da1-box.scn"
[remap]

path="res://.godot/exported/133200997/export-6fd2e10918c5b5746df14be5ef194f35-spot.scn"
���w\����"���[remap]

path="res://.godot/exported/133200997/export-07690686bd1a72f71ae2b53bb79af276-wall.scn"
,ʅ�wfOu��[remap]

path="res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
�f��(<�t(�.Slist=Array[Dictionary]([])
��14<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
0ߵ���M��O   �\#�_�   res://icon.svg��tX
   res://main.tscnw��Ō+   res://scenes/player.tscn�ܔN5�mM   res://scenes/wall.tscn�;x�S   res://scenes/box.tscn�LE��Xa   res://scenes/spot.tscn��`��~�n��϶ECFG      application/config/name         Sokoban    application/run/main_scene         res://main.tscn    application/config/features$   "         4.1    Forward Plus       application/config/icon         res://icon.svg  "   display/window/size/viewport_width         #   display/window/size/viewport_height      X     display/window/stretch/mode         viewport�mY��S5�y