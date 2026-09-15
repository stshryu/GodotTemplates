extends Node2D

@onready var PlayArea: Control = %PlayArea
@onready var Hand: Control = %Hand
@onready var CardScene := preload("res://card_scene/card.tscn")
@onready var Strike: CardData = preload("res://cards/Strike.tres")
@onready var Defend: CardData = preload("res://cards/Defend.tres")
@onready var Draw: CardData = preload("res://cards/Draw.tres")

func _ready() -> void:
	var cardstrike = CardScene.instantiate()
	cardstrike.data = Strike
	var carddefend = CardScene.instantiate()
	carddefend.data = Defend
	var carddraw = CardScene.instantiate()
	carddraw.data = Draw
	Hand.add_child(cardstrike)
	Hand.add_child(carddefend)
	Hand.add_child(carddraw)
	EventBus.connect("card_played", _on_card_played)
	
func _on_card_played(card: Card) -> void:
	var card_data := card.data
	print(card_data)
	print("played")
