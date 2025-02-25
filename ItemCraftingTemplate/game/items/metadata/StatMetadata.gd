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
