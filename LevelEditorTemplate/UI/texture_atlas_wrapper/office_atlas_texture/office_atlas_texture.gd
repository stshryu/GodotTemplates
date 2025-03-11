class_name OfficeAtlas
extends AtlasResolver

func _init() -> void:
	atlas = preload("res://assets/Modern_Office_48x48.png")
	atlas_properties = {
		"Printer": AtlasProperty.new(Vector2(393.0, 990.0), Vector2(75.0, 60.0), null),
		"Computer": AtlasProperty.new(Vector2(672.0, 630.0), Vector2(48.0, 66.0), null)
	}
