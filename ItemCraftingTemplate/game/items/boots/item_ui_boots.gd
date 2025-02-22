class_name BootsOne
extends BaseItem

@onready var boot_sprite: Sprite2D = %BootSprite
@onready var boot_name: Label = %BootName

func _ready():
	boot_sprite.texture = item_sprite
	boot_name.text = item_name
	item_level = 20
	item_quality = 100

func roll_modifiers():
	var modifier = MaxLife.new()
	modifier._debug_weights(30, 1000)
	var item_prop = modifier.add_to_item(self)
	item_properties[modifier.modifier_type].append(item_prop)

func _on_button_pressed():
	roll_modifiers()

func _on_get_item_prop_pressed():
	for key in item_properties:
		for item in item_properties[key]:
			print(item.property_key)
			print(item.property_name)
			print(item.property_value)
			print(item.tags)
