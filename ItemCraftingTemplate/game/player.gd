class_name Player
extends CharacterBody2D

@onready var playerstatlabel: RichTextLabel = %PlayerStats
@onready var playerstats: BaseStats = BaseStats.new()
@onready var playerequipment: BaseEquipment = BaseEquipment.new()

var need_to_update_stats: bool = true

func _ready():
	pass
	
func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * playerstats.movement_speed
	move_and_slide()
	
	if need_to_update_stats:
		_update_stats()

func _update_stats():
	need_to_update_stats = false
	playerstatlabel.text = Util.get_formatted_stats(playerstats)
	
func equip_item(slot: EquipmentMetadata.EquipmentSlot, item: BaseItem):
	playerequipment.equip_item(slot, item)
		
func _on_testing_pressed():
	playerstats.parse_equipment_stats(playerequipment.calculate_all_equipment_slots())
	need_to_update_stats = true
	#playerequipment.calculate_equipment_slot(EquipmentMetadata.EquipmentSlot.BOOTS)
	
