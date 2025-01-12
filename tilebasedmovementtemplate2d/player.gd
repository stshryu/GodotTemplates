extends CharacterBody2D

@export var walk_speed: float = 10.0

const TILE_SIZE: int = 8.0

@onready var player_sprite = $Sprite2D

enum PlayerState { IDLE, TURNING, MOVING }
enum FacingDirection { LEFT, RIGHT, UP, DOWN }
var player_state = PlayerState.IDLE
var facing_direction = FacingDirection.DOWN
var prev_player_state = PlayerState.IDLE
var init_pos: Vector2 = Vector2.ZERO
var input_dir: Vector2 = Vector2(0,1)
var is_moving: bool = false
var can_act: bool = true
var is_traveling: bool = false
var percent_moved: float = 0.0
var direction_keys: Array = []

func player_input() -> void:
	if len(direction_keys) == 0 or direction_keys.back() == null:
		input_dir = Vector2.ZERO
		prev_player_state = PlayerState.IDLE
	else:
		var key: String = direction_keys.back()
		if Input.is_action_pressed(key):
			input_dir = Vector2.ZERO
			if key == "ui_right": 
				input_dir.x = 1
			elif key == "ui_left":
				input_dir.x = -1
			elif key == "ui_down":
				input_dir.y = 1
			elif key == "ui_up":
				input_dir.y = -1
			else: 
				input_dir = Vector2.ZERO
				
	if input_dir != Vector2.ZERO:
		if need_to_turn():
			player_state = PlayerState.TURNING
		else:
			prev_player_state = PlayerState.MOVING
			init_pos = position
			is_moving = true
			
func need_to_turn() -> bool:
	if prev_player_state == PlayerState.MOVING:
		return false
	
	var new_facing_dir
	if input_dir.x < 0:
		new_facing_dir = FacingDirection.LEFT
	elif input_dir.x > 0:
		new_facing_dir = FacingDirection.RIGHT
	elif input_dir.y < 0:
		new_facing_dir = FacingDirection.UP
	elif input_dir.y > 0:
		new_facing_dir = FacingDirection.DOWN
	
	if facing_direction != new_facing_dir:
		facing_direction = new_facing_dir
		return true
		
	facing_direction = new_facing_dir
	return false
	
func finished_turning() -> void:
	player_state = PlayerState.IDLE
	
func move(delta: float) -> void:
	var next_step = input_dir * TILE_SIZE / 2
	
