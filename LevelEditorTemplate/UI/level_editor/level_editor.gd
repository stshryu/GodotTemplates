extends Control

@onready var editor_screen = %EditorScreen
@onready var bottom_control_panel = %BottomControlPanel
@onready var right_control_panel = %RightControlPanel
@onready var right_panel_timer = %PanelTimeout
@onready var right_button_container = %VBoxRightContainer

var viewport_dimensions := Vector2.ZERO
var right_panel_timeout := false
var opening_right_panel := false
var closing_right_panel := false
var prefab_button := preload("res://UI/prefabs/button.tscn")
var button_texture_atlas_key: Dictionary[TextureButton, Array] = {}

signal buttonpressed

func add_button(button_name: String, button_dimensions: Vector2, button_atlas_coords: Vector2, button_atlas_dimension: Vector2):
	right_button_container.add_child(HSeparator.new())
	var new_button = prefab_button.instantiate()
	new_button.label_name = button_name
	new_button.dimensions = button_dimensions
	right_button_container.add_child(new_button)
	var new_child = right_button_container.get_children().back()
	button_texture_atlas_key[new_child] = [button_atlas_coords, button_atlas_dimension]
	new_button.pressed.connect(_on_right_panel_button_pressed.bind(new_button))
	return right_button_container.get_children().back()

func _ready():
	viewport_dimensions = get_viewport_rect().size
	add_button("test", Vector2(60.0,20.0), Vector2(10.0, 10.0), Vector2(15.0, 15.0))
	add_button("test2", Vector2(60.0,20.0), Vector2(10.0, 10.0), Vector2(15.0, 15.0))
	
func _physics_process(delta):
	if not right_panel_timeout:
		display_right_panel()
	if opening_right_panel:
		open_right_panel(delta)
	elif closing_right_panel:
		close_right_panel(delta)

func _on_right_panel_button_pressed(pressed_button):
	print(pressed_button)
	print(button_texture_atlas_key[pressed_button])
	
func display_right_panel():
	var x_mouse_pos = get_viewport().get_mouse_position()[0]
	if x_mouse_pos > (viewport_dimensions[0]-20) and not right_control_panel.visible:
		right_control_panel.visible = true
		opening_right_panel = true
		
func open_right_panel(delta):
	right_control_panel.position.x -= 5
	if right_control_panel.position.x == viewport_dimensions[0] - 60:
		opening_right_panel = false

func close_right_panel(delta):
	right_control_panel.position.x += 5
	if right_control_panel.position.x == viewport_dimensions[0]:
		right_control_panel.visible = false
		closing_right_panel = false
		right_panel_timer.start()
		right_panel_timeout = true
		
func _on_close_panel_pressed():
	closing_right_panel = true

func _on_panel_timeout_timeout():
	right_panel_timeout = false
