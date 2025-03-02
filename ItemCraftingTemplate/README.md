# General Approach

In order to be able to SCALE something like a massive repository of items/sprites/stats/etc... we're going to use a method that creates base classes that specialized stats will inherit from, alongside a metadata repository that keeps track of all the keys we're utilizing.

We want to create a contract between our models that allows us to create items, create baseline stats, and have those items roll stats based on rules specific to the item.

For simplicity, we're replicating PoE's approach, 3 prefixes, 3 suffixes, and 1 implicit modifier.

# The BaseItem Class

The BaseItem class is important in that it's the base for every single one of our actual items. In the template, we've created two items `item_ui_boots` and `item_ui_helmet`. Both of those items can be considered blank slate "rare" items in PoE terms. These items can have a sprite, a name, a dictionary of properties (that we initialize with Metadata Keys that we'll get into later). And other basic stuff like item level, quality and the slot that this item goes into on the player.

# The BaseStats Class

The BaseStats class is something that is present in the vampiresurvivors template as well, just a baseline object that affects all our entities (the PlayerCharacter as well as all enemies all count as entities). However the `BaseStats` on this template has some extra frills, and actually takes on even more responsibility. Instead of setting and storing the properties (like `movement_speed`) and letting the child entity access it, we've created methods that fetch things like `movement_speed` via `get_movement_speed(...)`.

# The BaseEquipment Class

The new addition to this template versus the vampire survivors template, the base equipment is a skeleton that holds all the available slots for the player (its been left decoupled so we can extend this to affect enemies as well!). That means, when we equip an item it'll go into its corresponding slot (based on Metadata tags).

# The ItemProperty Class

This property is something important that the `BaseItem` builds off of. The property of an item designates HOW the property is rolled, and what constraints are on the property itself.

For example:

```
func roll_property(item_level: int):
	var rng = RandomNumberGenerator.new()
	var values = []
	var weights = []
	for key in item_tier_bands.keys():
		if key <= item_level:
			values.append(key)
			weights.append(item_tier_bands[key][2])
	weights = PackedFloat32Array(weights)
	var key = values[rng.rand_weighted(weights)]
	property_value = rng.randi_range(item_tier_bands[key][0], item_tier_bands[key][1])
```

This code snippet depends on the `item_tier_bands` dictionary, which contains an integer key (the minimum level for this tier band to appear on an item) as well as an array within the key that holds 3 values: `[minimum, maximum, weight]`. This roll property method basically utilizes all of those to ensure that when we create an item (whatever the item level is) determines the potential best rolls that can exist on this item. Further, the weight on the modifiers (the better mods have a lower weight) determine how often those higher rolls will occur on the item vs. lower rolls.

The important thing with the property is that, we can create multiple different stats, like `MaxLife` for example:

```
class_name MaxLife
extends ItemProperty

func _init():
	property_key = StatMetadata.StatEnum.MAXIMUM_LIFE
	property_name = "Maximum Life"
	modifier_type = ItemMetadata.ModifierEnum.PREFIX
	set_item_tier_bands()

### Handles the tiering required to roll the property on an item
func set_item_tier_bands():
	item_tier_bands = {
		10: [1, 10, 100],
		20: [11, 20, 90],
		30: [21, 40, 80],
		40: [41, 100, 70]
	}

func add_to_item(item: BaseItem) -> ItemProperty:
	roll_property(item.item_level)
	return self
```

This simple file sets the tier bands, and when added to an item, simply rolls the property and returns itself.

# Metadata

In addition to the new equipment and property classes, we added a `<xyz>Metadata` class that denotes basic metadata around our classes and contracts to ensure that when we transport data between them, they can be accessed in a clear and readable way.

Instead of using dictionaries and keys we'll use the `enums` generated in our Metadata classes to access the dictionaries in a replicatable manner.

```
class_name StatMetadata
extends Node

enum StatEnum { MAXIMUM_LIFE, MAXIMUM_MANA, MOVEMENT_SPEED }

static func covert_enum_to_key(statenum: StatEnum):
	match statenum:
		StatEnum.MAXIMUM_LIFE:
			return "maximum_life"
		StatEnum.MAXIMUM_MANA:
			return "maximum_mana"
		StatEnum.MOVEMENT_SPEED:
			return "movement_speed"
```

An example here shows how we can use enums to access keys: `Dictionary[StatMetadata.StatEnum.MAXIMUM_LIFE]` which is amazing, but enums in Godot are simply dictionaries of integers, so our StatEnum dict would basically just be something like:

```
StatEnum = {
    MAXIMUM_LIFE: 0,
    MAXIMUM_MANA: 1,
    MOVEMENT_SPEED: 2
}
```

Since enums can only hold integer values, that means if we want to get the string representation of the enum we'll have to convert it using the match case patter we see in the snippet.

If you go back `MaxLife` code snippet, you'll see we use multiple of these enums to describe different things within the item property, we use all of these to later on access the property and get its value, while adding it to the correct place when we need to consolidate all of our stats for the player.

# BaseStats and BaseEquipment communication 

This project, unlike the vampire survivors project doesn't have any other entities, so the `BaseStats` class is all we have. However the important methods we added would be the `get_combined_stats(parsed_stats: Dictionary):` function. This takes a dictionary representation of all the stat changes our equipped items are giving us and combines it with the base stats to then return the players stats.

In other words, the player should orchestrate all of this. We have signals connected to some debugger buttons that basically triggers all of these things. When we equip an item, we add it to the `playerequipment` variable stored on the player, when the equip happens, we ssend a signal on the player that calculates all our equipped items, and pushes it into the `get_combined_stats()` method to get all of our combined stats from the `playerstats` variable.

Once we get that data back, a flag should be set that ignores any other stat calculations until another event occurs that requires us to recalculate (e.g. equipping a new item, getting afflicted by a stat reducing curse etc...).

# Additional Goodies

We also added a `Logger.gd` base utility autoload class. Adds for a very informative and useful way to structure events while debugging (should consider adding this into every other templated class we have).
