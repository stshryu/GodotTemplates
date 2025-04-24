extends Node2D

"""
The goal is to have an independent game scene here that can be modified by child scenes.

In this example, we'll have a very simple tilemaplayer that at is base can be modified by the player.

Special abilities can be used by the player to further interact with the tilemaplayer, by utilizing
custom resources and packed scenes that contain callable code that interacts with the base game scene.

The tilemap generation creates a bunch of green squares, left clicking on the map lets us create
red tiles. The goal is to have items that can also impact the tilemaplayer.
"""

@onready var randomscene := %RandomScene
@onready var tilemaplayer := %TileMapLayerTest
@onready var straight_line_ability := preload("res://special_abilities/straight_line_ability/straight_line_ability.tres")

var dimensions := Vector2i(5, 5)
var atlas_coords := {
	"GREEN": Vector2i(0,0),
	"RED": Vector2i(1,0)
}
var can_act: bool = true

func _ready():
	straight_line_ability.create_base_scene()
	generate_tilemap()

func _process(_delta):		
	if can_act:
		if Input.is_action_just_pressed("mouse_left_click"):
			var tilemap_coord = tilemaplayer.local_to_map(get_local_mouse_position())
			interact_with_tilemap(tilemap_coord)
		if Input.is_action_just_pressed("use_straight_line"):
			straight_line_ability.add_base_scene(randomscene)
			straight_line_ability.connect_active_signal(_set_active_scene)
			straight_line_ability.connect_interact_with_tilemap(interact_with_tilemap)
			_use_ability(straight_line_ability.use_ability, {"tilemaplayer": tilemaplayer})
	
func interact_with_tilemap(click_loc: Vector2i):
	tilemaplayer.set_cell(click_loc, 0, atlas_coords["RED"], 0)
	
func generate_tilemap():
	for y in range(dimensions.y):
		for x in range(dimensions.x):
			var local_coord := Vector2i(x, y)
			tilemaplayer.set_cell(local_coord, 0, atlas_coords["GREEN"], 0)

func _use_ability(ability_callable: Callable, params: Dictionary):
	can_act = false
	ability_callable.call(params)
	
func _set_active_scene():
	can_act = true
