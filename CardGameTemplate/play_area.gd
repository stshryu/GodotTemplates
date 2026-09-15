extends Control
	
@onready var background: ColorRect = %PlayAreaBackground

func _ready() -> void:
	background.mouse_filter = Control.MOUSE_FILTER_PASS
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Card
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var card: Card = data as Card
	EventBus.card_played.emit(card)
