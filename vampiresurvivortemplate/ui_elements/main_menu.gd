class_name MainMenu
extends Control

@onready var start_button: TextureButton = %StartButton
@onready var option_button: TextureButton = %OptionButton
@onready var exit_button: TextureButton = %ExitButton
@export var initial_scene: PackedScene = preload("res://game/game.tscn")

func _ready():
	pass
