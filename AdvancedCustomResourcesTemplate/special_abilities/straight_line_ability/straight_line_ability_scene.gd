extends Node2D

@onready var arrow_texture := %ArrowTexture
@onready var movement_cd := %MovementCD

var placement_coord: Vector2i
var direction_keys := [Vector2i(-1,0),Vector2i(0,-1),Vector2i(1,0),Vector2i(0,1)]
var direction := 0
var preview: Sprite2D
var placing_ability: bool = false
var is_placed: bool = false

## Keep in mind we might want to abstract out the tilemaplayer and dimensions into their own scene/custom resource
## which would allow us to pass a reference to a singular resource instead of defining these variables across
## multiple classes.
var tilemaplayer: TileMapLayer
var tilemap_dimensions := Vector2i(5,5)

signal placed_on_board
signal interact_with_board

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
	_map_tilemap_coord_and_interact()
	movement_cd.start()

func use_ability(params: Dictionary):
	## if the parameters contains the tilemaplayer, lets set a reference to it
	if params.has("tilemaplayer"):
		tilemaplayer = params["tilemaplayer"]
	_set_active_scene()	
	
func _connect_parent_signal(parent_callable: Callable):
	placed_on_board.connect(parent_callable)

func _connect_interact_tilemap_signal(parent_callable: Callable):
	interact_with_board.connect(parent_callable)
	
func _set_active_scene():
	placing_ability = true
	print("straight line active")
	
func _relinquish_priority():
	preview.modulate.a = 1.0
	placing_ability = false
	placed_on_board.emit()
	
func _rotate(rot_dir: int): ## 0 = 90, 1 = -90 degrees
	match rot_dir:
		0:
			direction = direction + 1 if direction < direction_keys.size() - 1 else 0
		1:
			direction = direction - 1 if direction > 0 else direction_keys.size() - 1

func _on_movement_cd_timeout():
	var curr_pos := preview.position
	preview.position = Vector2i(curr_pos.x, curr_pos.y) + Vector2i(8, 8) * direction_keys[direction]
	_map_tilemap_coord_and_interact()

func _map_tilemap_coord_and_interact():
	var tilemap_coord := tilemaplayer.local_to_map(preview.position)
	if tilemap_coord.x in range(0, tilemap_dimensions.x) and tilemap_coord.y in range(0, tilemap_dimensions.y):
		interact_with_board.emit(tilemap_coord)
	else:
		## Delete self once we reach the end of the board
		self.queue_free()
