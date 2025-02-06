extends BaseItem

func _ready():
	itemname = "default_exp_drop"
	
func apply_item(body: Player):
	if body.get("playerstats"):
		body.playerstats.update_experience(value, body)
	
