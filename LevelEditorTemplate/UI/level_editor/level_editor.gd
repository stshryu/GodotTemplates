extends Control

@onready var editor_screen = %EditorScreen
@onready var bottom_control_panel = %BottomControlPanel
@onready var right_control_panel = %RightControlPanel
@onready var right_panel_timer = %PanelTimeout
@onready var right_button_container = %VBoxRightContainer
@onready var editor_node = %EditorNode

var viewport_dimensions := Vector2.ZERO
var right_panel_timeout := false
var opening_right_panel := false
var closing_right_panel := false
var is_editing := false

var prefab_button := preload("res://UI/prefabs/button.tscn")
var atlas_texture := preload("res://assets/Modern_Office_48x48.png")
var button_texture_atlas_key: Dictionary[TextureButton, Array] = {}
var currently_active_placement: AtlasTexture
var preview: Sprite2D

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
	
	add_button("Printer", Vector2(60.0,20.0), Vector2(393.0, 990.0), Vector2(75.0, 60.0))
	add_button("Computer", Vector2(60.0,20.0), Vector2(672.0, 630.0), Vector2(48.0, 66.0))
	
func _physics_process(_delta):
	if not right_panel_timeout:
		display_right_panel()
	if opening_right_panel:
		open_right_panel()
	elif closing_right_panel:
		close_right_panel()
		
	if is_editing:
		var mouse_pos := get_local_mouse_position()
		preview.position = mouse_pos
		
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			preview.modulate.a = 1.0
			is_editing = false 

func _on_right_panel_button_pressed(pressed_button):
	is_editing = true
	currently_active_placement = AtlasTexture.new()
	currently_active_placement.set_atlas(atlas_texture)
	currently_active_placement.region = Rect2(
		button_texture_atlas_key[pressed_button][0], button_texture_atlas_key[pressed_button][1]
	)
	preview = Sprite2D.new()
	preview.texture = currently_active_placement
	preview.modulate.a = 0.5
	editor_node.call_deferred("add_child", preview)
	
func display_right_panel():
	var x_mouse_pos = get_viewport().get_mouse_position()[0]
	if x_mouse_pos > (viewport_dimensions[0]-20) and not right_control_panel.visible:
		right_control_panel.visible = true
		opening_right_panel = true
		
func open_right_panel():
	right_control_panel.position.x -= 5
	if right_control_panel.position.x == viewport_dimensions[0] - 60:
		opening_right_panel = false

func close_right_panel():
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
