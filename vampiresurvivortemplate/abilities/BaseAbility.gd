class_name BaseAbility
extends Node2D

@export var base_cooldown: float = 1.0
@export var sprite: Sprite2D
@export var ability_name: String

var parent_entity
var is_usable: bool = true
var timer := Timer.new()
var time_left: float

func _init(parent_entity):
	parent_entity.add_child(timer)
	timer.wait_time = base_cooldown
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	self._ready()
	
func _physics_process(delta):
	if !is_usable:
		time_left = timer.time_left
		print(time_left)
		
### TODO:
### Make both Player, and Enemies inherit off the same base class (call it entity or something)
### that way we can ensure that things like abilities can be used by both enemies and the player 
### alike without too massive of code changes.
func use_ability(entity): 
	pass
	
func start_cooldown() -> void:
	timer.start()
	is_usable = false
	
func _on_timer_timeout() -> void:
	print(ability_name)
	print('ready')
	is_usable = true
