class_name Player
extends CharacterBody2D

@onready var playerstatlabel: RichTextLabel = %PlayerStats
@onready var playerstats: BaseStats = BaseStats.new()
@onready var playerequipment: BaseEquipment = BaseEquipment.new()

var need_to_update_stats: bool = true
var movement_speed: float

func _ready():
	movement_speed = playerstats.movement_speed
	
func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * movement_speed
	move_and_slide()
	
	if need_to_update_stats:
		movement_speed = playerstats.get_movement_speed(playerequipment.calculate_all_equipment_slots())
		_update_stats()

func _update_stats():
	need_to_update_stats = false
	var test =  Util.get_formatted_stats(playerstats, playerequipment)
	playerstatlabel.text = test
	
func equip_item(slot: EquipmentMetadata.EquipmentSlot, item: BaseItem):
	playerequipment.equip_item(slot, item)
	need_to_update_stats = true
		
func _on_testing_pressed():
	need_to_update_stats = true
	
