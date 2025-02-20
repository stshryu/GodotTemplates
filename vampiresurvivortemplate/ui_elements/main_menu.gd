class_name MainMenu
extends Control

@onready var start_button: TextureButton = %StartButton
@onready var option_button: TextureButton = %OptionButton
@onready var exit_button: TextureButton = %ExitButton
@export var initial_scene: PackedScene = preload("res://game/game.tscn")

func _ready():
	start_button.button_up.connect(_start_level)
	option_button.button_up.connect(_open_options)
	exit_button.button_up.connect(_exit_game)

func _start_level():
	get_tree().change_scene_to_packed(initial_scene)
	
func _open_options():
	print('open options')
	
func _exit_game():
	get_tree().quit()
