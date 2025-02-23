class_name Player
extends CharacterBody2D

@onready var playerstatlabel: RichTextLabel = %PlayerStats
@onready var playerstats: BaseStats = BaseStats.new()

var need_to_update_stats: bool = false

func _ready():
	pass
	
func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * playerstats.movement_speed
	move_and_slide()
	
	#if need_to_update_stats:
	_update_stats()

func _on_stat_changed():
	need_to_update_stats = true

func _update_stats():
	need_to_update_stats = false
	playerstatlabel.text = Util.get_formatted_stats(playerstats)
