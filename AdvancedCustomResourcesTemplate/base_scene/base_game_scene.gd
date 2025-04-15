extends Node2D

"""
The goal is to have an independent game scene here that can be modified by child scenes.

In this example, we'll have a very simple tilemaplayer that at is base can be modified by the player.

Special abilities can be used by the player to further interact with the tilemaplayer, by utilizing
custom resources and packed scenes that contain callable code that interacts with the base game scene.
"""

@onready var tilemaplayer := %TileMapLayerTest

var dimensions := Vector2i(5, 5)
var atlas_coords := {
	"GREEN": Vector2i(0,0),
	"RED": Vector2i(1,0)
}

func _ready():
	generate_tilemap()

func _process(_delta):
	if Input.is_action_just_pressed("mouse_left_click"):
		var tilemap_coord = tilemaplayer.local_to_map(get_local_mouse_position())
		interact_with_tilemap(tilemap_coord)
	
func interact_with_tilemap(click_loc: Vector2i):
	tilemaplayer.set_cell(click_loc, 0, atlas_coords["RED"], 0)
	
func generate_tilemap():
	for y in range(dimensions.y):
		for x in range(dimensions.x):
			var local_coord := Vector2i(x, y)
			tilemaplayer.set_cell(local_coord, 0, atlas_coords["GREEN"], 0)
