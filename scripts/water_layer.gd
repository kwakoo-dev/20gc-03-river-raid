extends TileMapLayer

## in blocks
const LEVEL_WIDTH : int = 20

var water_length : int = 0

func draw_water_until(until_y : int) -> void:
	print_debug("until_y: " + str(until_y))
	for y in range(water_length, until_y, -1):
		#print_debug("y: " + str(y))
		for x in range(LEVEL_WIDTH):
			set_cell(Vector2i(x, y), 0, Vector2i(0,0))
	water_length = until_y
