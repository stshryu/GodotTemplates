extends Control

@onready var editor_screen = %EditorScreen
@onready var bottom_control_panel = %BottomControlPanel
@onready var right_control_panel = %RightControlPanel
@onready var right_panel_timer = %PanelTimeout

var viewport_dimensions := Vector2.ZERO
var right_panel_timeout := false
var opening_right_panel := false
var closing_right_panel := false

func _ready():
	viewport_dimensions = get_viewport_rect().size

func _physics_process(delta):
	if not right_panel_timeout:
		display_right_panel()
	if opening_right_panel:
		open_right_panel(delta)
	elif closing_right_panel:
		close_right_panel(delta)

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
