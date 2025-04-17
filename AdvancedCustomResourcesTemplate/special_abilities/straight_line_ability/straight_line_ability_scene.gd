extends Node2D

@onready var arrow_texture := %ArrowTexture

var placement_coord: Vector2i
var direction: Vector2i
var preview: Sprite2D

var placing_ability: bool = false
signal is_placed

func _ready():
	preview = arrow_texture
	preview.modulate.a = 0.5 ## Semi-transparent

func _process(_delta):
	if is_placed.has_connections():
		if placing_ability:
			var mouse_pos := get_local_mouse_position()
			preview.position = mouse_pos
			preview.visible = true
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				_relinquish_priority()
	else:
		print("Error: signal was never connected back to parent")

func _connect_parent_signal(parent_callable: Callable):
	is_placed.connect(parent_callable)

func use_ability(params: Dictionary):
	_set_active_scene()
	print("Hi, straight_line_ability executing")

func _set_active_scene():
	placing_ability = true
	print("straight line active")
	
