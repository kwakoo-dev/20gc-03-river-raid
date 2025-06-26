class_name EndSegment
extends LevelSegment

@export var grass_layer : GrassLayer

var river_banks : RiverBanks = RiverBanks.new()

var current_y = 0

func setup(new_river_banks : RiverBanks) -> void:
	self.river_banks = new_river_banks

func is_generated() -> bool:
	return true

func get_river_banks() -> RiverBanks:
	return river_banks

func get_segment_end_y() -> int:
	if grass_layer:
		return grass_layer.get_segment_end_y()
	return int(to_global(Vector2(0, 0)).y)

func draw_next_terrain_line() -> void:
	var line : Array[Vector2i] = river_banks.get_river_banks_line(current_y)
	grass_layer.put_grass_autotile(line)
	if current_y % 2 == 0:
		river_banks.adjust_river_banks(Properties.DEFAULT_BANK_LEFT, Properties.DEFAULT_BANK_RIGHT)
	current_y -= 1

func drawing_ended() -> bool:
	return river_banks.left == Properties.DEFAULT_BANK_LEFT && river_banks.right == Properties.DEFAULT_BANK_RIGHT
