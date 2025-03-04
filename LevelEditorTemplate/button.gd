extends Control

@onready var label: Label = %ButtonLabel
@export var dimensions: Vector2
@export var label_name: String

func _ready():
	self.custom_minimum_size = dimensions
	label.text = label_name
