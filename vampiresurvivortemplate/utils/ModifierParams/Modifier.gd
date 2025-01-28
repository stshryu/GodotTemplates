class_name Modifier
extends Resource

@export var value: float
@export var tags: Array[ModifierTags]

enum ModifierTags {
	RANGED,
	MELEE,
	PROJECTILE,
}
