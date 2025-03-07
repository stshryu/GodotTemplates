extends TextureButton

@onready var label: Label = %ButtonLabel
@export var dimensions: Vector2
@export var label_name: String = "placeholder"

var button_state 

func _ready():
	self.custom_minimum_size = dimensions
	label.text = label_name

func _on_button_down():
	label.position.y += 2

func _on_button_up():
	label.position.y -= 2
