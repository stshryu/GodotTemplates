class_name DashAbility
extends Node2D

@onready var sprite: Sprite2D = %ui_sprite
@onready var cooldown_text: RichTextLabel = %cooldown_text
@onready var cooldown_timer: Timer = %cooldown_timer

@export var dash_distance: Vector2 = Vector2(50.0,50.0)
@export var dash_cooldown: float = 5.0

var is_usable = true

func _ready():
	cooldown_timer.wait_time = dash_cooldown
	cooldown_timer.one_shot = true
	cooldown_text.visible = false
	
func _process(_delta):
	if not is_usable:
		var cooldown_remaining = "%3.1f" % cooldown_timer.time_left
		cooldown_text.visible = true
		cooldown_text.text = cooldown_remaining

func use_ability(parent_entity):
	if is_usable and parent_entity.velocity != Vector2(0,0):
		parent_entity.global_position += parent_entity.velocity.normalized() * dash_distance
		cooldown_timer.start()
		is_usable = false
		toggle_greyscale()

func toggle_greyscale():
	if sprite.modulate == Color.DIM_GRAY:
		sprite.modulate = Color(1,1,1)
	else:
		sprite.modulate = Color.DIM_GRAY
		
func _on_cooldown_timer_timeout():
	is_usable = true
	cooldown_text.visible = false
	toggle_greyscale()
