class_name WaterLayer
extends TileMapLayer

var water_length : int = 0

# deprecated
func draw_water_until(until_y : int) -> void:
	print_debug("until_y: " + str(until_y))
	for y in range(water_length, until_y, -1):
		#print_debug("y: " + str(y))
		for x in range(Properties.LEVEL_WIDTH):
			set_cell(Vector2i(x, y), 0, Vector2i(0,0))
	water_length = until_y

func draw_water(from_y : int, to_y : int) -> void:
	for y in range(from_y, to_y, -1):
		for x in range(Properties.LEVEL_WIDTH):
			set_cell(Vector2i(x, y), 0, Vector2i(0,0))
