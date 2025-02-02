extends BaseItem

func _ready():
	itemname = "default_exp_drop"
	
func apply_item(body: Player):
	if body.has_method("apply_item_to_player"):
		body.apply_item_to_player(operation, key, value)
	
