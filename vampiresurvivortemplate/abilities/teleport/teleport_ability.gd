class_name TeleportAbility
extends Node2D

@onready var sprite: Sprite2D = %ui_sprite
@onready var cooldown_text: RichTextLabel = %cooldown_text
@onready var cooldown_timer: Timer = %cooldown_timer
@onready var cast_timer: Timer = %cast_timer

@export var teleport_distance: Vector2 = Vector2(100.0,100.0)
@export var teleport_cooldown: float = 1.5
@export var teleport_cast_time: float = 0.5

var is_usable = true
var alternate_cast = false # Alt cast locks teleport position to when the cast started, not when cast finishes
var mouse_direction: Vector2
var parent_entity # Must be set before teleporting can work


func _ready():
	cooldown_timer.wait_time = teleport_cooldown
	cooldown_timer.one_shot = true
	cast_timer.wait_time = teleport_cast_time
	cast_timer.one_shot = true
	cooldown_text.visible = false
	
func set_parent(entity):
	parent_entity = entity
	
func _process(_delta):
	if not is_usable:
		var cooldown_remaining = "%3.1f" % cooldown_timer.time_left
		cooldown_text.visible = true
		cooldown_text.text = cooldown_remaining

func use_ability():
	if is_usable and parent_entity.can_act:
		if alternate_cast:
			mouse_direction = _get_mouse_direction_normalized()
		start_casting()
		start_cooldown_timer()
		toggle_greyscale()

func _finish_teleport():
	if not alternate_cast:
		mouse_direction = _get_mouse_direction_normalized()
	parent_entity.global_position += teleport_distance * mouse_direction
	
func start_cooldown_timer():
	cooldown_timer.start()
	is_usable = false
	
func start_casting():
	cast_timer.start()
	parent_entity.can_act = false
	parent_entity.can_move = false
	parent_entity.is_casting = true

func _get_mouse_direction_normalized() -> Vector2:
	var view_mouse = get_viewport().get_mouse_position()
	var view_center = get_viewport_rect().size/2.0
	var normalized_mouse_direction = (view_mouse - view_center).normalized()
	return normalized_mouse_direction 
	
func toggle_greyscale():
	if sprite.modulate == Color.DIM_GRAY:
		sprite.modulate = Color(1,1,1)
	else:
		sprite.modulate = Color.DIM_GRAY
		
func _on_cooldown_timer_timeout():
	is_usable = true
	cooldown_text.visible = false
	toggle_greyscale()

func _on_cast_timer_timeout():
	_finish_teleport()
	# test
	parent_entity.test_teleport_anim.visible = true
	parent_entity.test_teleport_anim.play("default", 4.0)
	# test
	parent_entity.can_act = true
	parent_entity.can_move = true
	parent_entity.is_casting = false
