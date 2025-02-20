class_name PauseMenu
extends Control

@onready var resume_button: TextureButton = %ResumeButton
@onready var restart_button: TextureButton = %RestartButton
@onready var exit_button: TextureButton = %ExitButton
@export var initial_scene: PackedScene = preload("res://game/game.tscn")

func _ready():
	get_tree().paused = false
	resume_button.button_up.connect(resume)
	restart_button.button_up.connect(restart)
	exit_button.button_up.connect(exit)
	_hide_menu()
	
func restart():
	get_tree().reload_current_scene()

func resume():
	_hide_menu()
	if get_tree().paused: get_tree().paused = false
	
func pause():
	_show_menu()
	if not get_tree().paused: get_tree().paused = true
	
func exit():
	get_tree().quit()

func _show_menu():
	self.visible = true
	
func _hide_menu():
	self.visible = false
