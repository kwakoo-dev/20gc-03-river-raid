class_name GrassLayerV3
extends TileMapLayer

const GRASS_COORDS : Vector2 = Vector2(1, 1)

func put_grass_autotile(cells: Array[Vector2i]) -> void:
	set_cells_terrain_connect(cells, 0, 0, false)
	pass

func put_grass_raw(cells: Array[Vector2i]) -> void:
	for cell in cells:
		set_cell(cell, 1, GRASS_COORDS)

func get_segment_end_y() -> int:
	var rect = get_used_rect()
	var local_position = map_to_local(rect.position)
	var gp = to_global(local_position)
	return gp.y
