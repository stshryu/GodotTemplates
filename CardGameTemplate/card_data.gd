class_name CardData
extends Resource

@export var card_name: String = "Strike"
@export var cost: int = 1
@export_multiline var description: String = "Deal 6 damage"
@export var attack: int = 6
@export var block: int = 0
@export var art: Texture2D

enum Effect { ATTACK, DEFEND, DRAW }
@export var effect: Effect = Effect.ATTACK
