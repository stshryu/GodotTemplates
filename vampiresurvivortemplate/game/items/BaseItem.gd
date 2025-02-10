class_name BaseItem
extends Area2D

@export var itemname: String
@export var operation: String
@export var key: String
@export var value: float
@export var sprite: Sprite2D

func apply_item(body: Player):
	pass

func _on_body_entered(body):
	if body is Player:
		apply_item(body)
		queue_free()
