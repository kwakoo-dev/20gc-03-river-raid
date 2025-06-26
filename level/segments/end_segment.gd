class_name EndSegment
extends LevelSegment

@export var grassLayer : GrassLayerV3

var riverBanks : RiverBanks = RiverBanks.new()

var current_y = 0

func setup(new_river_banks : RiverBanks) -> void:
	self.riverBanks = new_river_banks

func is_generated() -> bool:
	return true

func get_river_banks() -> RiverBanks:
	return riverBanks

func get_segment_end_y() -> int:
	if grassLayer:
		return grassLayer.get_segment_end_y()
	return int(to_global(Vector2(0, 0)).y)

func draw_next_terrain_line() -> void:
	var line : Array[Vector2i] = riverBanks.get_river_banks_line(current_y)
	grassLayer.put_grass_autotile(line)
	if current_y % 2 == 0:
		riverBanks.adjust_river_banks(Properties.DEFAULT_BANK_LEFT, Properties.DEFAULT_BANK_RIGHT)
	current_y -= 1

func drawing_ended() -> bool:
	return riverBanks.left == Properties.DEFAULT_BANK_LEFT && riverBanks.right == Properties.DEFAULT_BANK_RIGHT
