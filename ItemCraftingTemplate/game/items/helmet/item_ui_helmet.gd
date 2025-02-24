class_name HelmetOne
extends BaseItem

@onready var helmet_sprite: Sprite2D = %HelmetSprite
@onready var helmet_name: Label = %HelmetName
@onready var item_properties_label: RichTextLabel = %HelmetProperties
@onready var player = get_tree().root.get_node("GameWorld/Player")

var has_been_rerolled
signal equip

func _ready():
	helmet_sprite.texture = item_sprite
	helmet_name.text = item_name
	equipment_slot = EquipmentMetadata.EquipmentSlot.HELMET
	item_level = 100
	item_quality = 100
	
	set_mod_pool()

func set_mod_pool():
	mod_pool = [
		MaxLife.new(),
		MaxMana.new(),
		MovementSpeed.new()
	]
	
func set_item_properties():
	item_properties_label.text = ""
	for key in item_properties:
		for i in item_properties[key]:
			item_properties_label.append_text("+%s %s\n" % [i.property_name, i.property_value])

func roll_modifiers():
	reset_item() # clear it before we add more props
	for modifier in mod_pool:
		var item_prop = modifier.add_to_item(self)
		item_properties[modifier.modifier_type].append(item_prop)
	set_item_properties()

func _on_craft_pressed():
	roll_modifiers()
	
func _on_equip_pressed():
	player.equip_item(equipment_slot, self)

func _on_get_item_prop_pressed():
	print("------")
	for key in item_properties:
		for item in item_properties[key]:
			print(item.property_key)
			print(item.property_name)
			print(item.property_value)
			print(item.tags)
