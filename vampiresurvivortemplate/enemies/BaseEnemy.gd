class_name BaseEnemy
extends BaseEntity

@onready var player = get_node("/root/Game/Player")
@onready var mobhealthbar = %HealthBar
@onready var expdrop = preload("res://game/items/expitem/expdrop.tscn")

var mobstats: EnemyStats = EnemyStats.new()

func _physics_process(delta):
	move_towards_player()

func move_towards_player():
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mobstats.movement_speed
	move_and_slide()

func take_damage(amount: float):
	mobstats.current_health -= amount
	mobhealthbar.value = mobstats.current_health
	if mobstats.current_health <= 0.0:
		drop_loot()
		queue_free()

func drop_loot(): # Implement an actual loot table, for now lets only have the mobs drop exp when killed
	var newdrop = expdrop.instantiate()
	newdrop.position = position
	var newxpvalue = get_parent().consolidate_xp()
	if newxpvalue:
		newdrop.value = newxpvalue
		newdrop.sprite.modulate = Color(0,0,1)
		get_parent().get_node("ExpContainer").call_deferred("add_child", newdrop)
	else:
		get_parent().get_node("ExpContainer").call_deferred("add_child", newdrop)
