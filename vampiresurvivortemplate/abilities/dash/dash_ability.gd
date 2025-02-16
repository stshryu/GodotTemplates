class_name DashAbility
extends Node2D

@onready var sprite: Sprite2D = %ui_sprite
@onready var cooldown_text: RichTextLabel = %cooldown_text
@onready var cooldown_timer: Timer = %cooldown_timer
@onready var dash_duration_timer: Timer = %dash_duration_timer

@export var dash_distance: Vector2 = Vector2(50.0,50.0)
@export var dash_cooldown: float = 2.5
@export var dash_duration: float = 0.25
@export var dash_speed_modifier: float = 500.0

var is_usable = true
var parent_entity # Must be set before dashing can work
var alternate_dash: bool = false

func _ready():
	cooldown_timer.wait_time = dash_cooldown
	cooldown_timer.one_shot = true
	dash_duration_timer.wait_time = dash_duration
	dash_duration_timer.one_shot = true
	cooldown_text.visible = false
	
func set_parent(entity):
	parent_entity = entity
	
func _process(_delta):
	if not is_usable:
		var cooldown_remaining = "%3.1f" % cooldown_timer.time_left
		cooldown_text.visible = true
		cooldown_text.text = cooldown_remaining

func use_ability():
	if is_usable and parent_entity.is_moving:
		start_dash_action_lockout()
		start_cooldown_timer()
		toggle_greyscale()

func start_cooldown_timer():
	cooldown_timer.start()
	is_usable = false
	
func start_dash_action_lockout():
	dash_duration_timer.start()
	parent_entity.can_act = false
	parent_entity.can_be_damaged = false
	parent_entity.playerstats.movement_speed += dash_speed_modifier
	if alternate_dash: # Alternate dashing allows movement to be independent of dash direction
		var view_mouse = get_viewport().get_mouse_position()
		var view_center = get_viewport_rect().size/2.0
		var normalized_mouse_positional_angle = (view_mouse - view_center).normalized()
		parent_entity.last_direction = normalized_mouse_positional_angle

func toggle_greyscale():
	if sprite.modulate == Color.DIM_GRAY:
		sprite.modulate = Color(1,1,1)
	else:
		sprite.modulate = Color.DIM_GRAY
		
func _on_cooldown_timer_timeout():
	is_usable = true
	cooldown_text.visible = false
	toggle_greyscale()

func _on_dash_duration_timer_timeout():
	parent_entity.can_act = true
	parent_entity.can_be_damaged = true
	parent_entity.playerstats.movement_speed -= dash_speed_modifier
