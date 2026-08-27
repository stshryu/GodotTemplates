# Various Scripts and Tips

## TileSetAtlasSource to individual tile textures

Given a tileset (usually generated as a part of a TileMapLayer), you can find the source of the tileset (defaulted to 1 in newly generated TileSets) and create an atlas source

Once that's been created, we need to convert this into a texture image by finding the coordinates of the atlas source (these can be found by hovering over each individual tile in the TileMap layer screen).

Then create an `ImageTexture` from the image to create individual textures

```
var tileset: TileSetAtlasSource = tilemap.tile_set.get_source(source_id)

# Gets the very first tile at coords (0,0)
var texture_region: Rect2i = tileset.get_tile_texture_region(Vector2i(0,0))

# Get the image from the region
var tile_texture: Image = tileset.texture.get_image().get_region(texture_region)

# Create a texture from the image
var tile_icon := ImageTexture.create_from_image(tile_image)
```
