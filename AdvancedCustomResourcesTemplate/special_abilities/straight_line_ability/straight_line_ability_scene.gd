extends Node2D

@onready var arrow_texture := %ArrowTexture

var placement_coord: Vector2i
var direction_keys := [Vector2i(-1,0),Vector2i(0,-1),Vector2i(1,0),Vector2i(0,1)]
var direction := 0
var preview: Sprite2D
var placing_ability: bool = false
var is_placed: bool = false
var tilemaplayer: TileMapLayer

signal placed_on_board

func _ready():
	preview = arrow_texture
	preview.modulate.a = 0.5 ## Semi-transparent

func _process(_delta):
	if placed_on_board.has_connections():
		if placing_ability:
			var mouse_pos := get_local_mouse_position()
			var tilemap_coord = tilemaplayer.local_to_map(get_local_mouse_position())
			preview.position = tilemap_coord*8 + Vector2i(4, 4) ## Necessary to conform to grid and snap preview to it
			preview.visible = true
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				place_ability()
				_relinquish_priority()
			if Input.is_action_just_pressed("rotate_ninety"):
				preview.rotate(deg_to_rad(90))
				_rotate(0)
			if Input.is_action_just_pressed("rotate_neg_ninety"):
				preview.rotate(deg_to_rad(-90.0))
				_rotate(1)
		if is_placed:
			pass
	else:
		print("Error: signal was never connected back to parent")

func place_ability():
	var tilemapcoord

func use_ability(params: Dictionary):
	## if the parameters contains the tilemaplayer, lets set a reference to it
	if params.has("tilemaplayer"):
		tilemaplayer = params["tilemaplayer"]
	_set_active_scene()	
	
func _connect_parent_signal(parent_callable: Callable):
	placed_on_board.connect(parent_callable)

func _set_active_scene():
	placing_ability = true
	print("straight line active")
	
func _relinquish_priority():
	preview.modulate.a = 1.0
	placing_ability = false
	placed_on_board.emit()
	
func _rotate(direction: int): ## 0 = 90, 1 = -90 degrees
	match direction:
		0:
			direction = direction + 1 if direction < direction_keys.size() else 0
		1:
			direction = direction - 1 if direction >= 0 else direction_keys.size() - 1
