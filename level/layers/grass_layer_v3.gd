class_name GrassLayerV3
extends TileMapLayer

func put_grass_autotile(cells: Array[Vector2i]) -> void:
	set_cells_terrain_connect(cells, 0, 0, false)

func get_segment_end_y() -> int:
	var rect = get_used_rect()
	var local_position = map_to_local(rect.position)
	var gp = to_global(local_position)
	$Sprite2D.global_position.y = gp.y # TODO: debug godot sprite
	return gp.y
