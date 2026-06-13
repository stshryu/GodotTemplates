extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	EventBus.emit_signal("turn_ended")
	EventBus.emit_signal("example_signal_with_param", "testing", "testing2")
