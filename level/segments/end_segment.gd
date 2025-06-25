class_name EndSegment
extends LevelSegment

@export var grassLayer : GrassLayerV3

var riverBanks : RiverBanks = RiverBanks.new()

var current_y = 0

func setup(riverBanks : RiverBanks) -> void:
	self.riverBanks = riverBanks

func is_generated() -> bool:
	return true

func get_river_banks() -> RiverBanks:
	return RiverBanks.new()

func get_segment_end_y() -> int:
	if grassLayer:
		return grassLayer.get_segment_end_y()
	return 0

func draw_next_terrain_line() -> void:
	var line : Array[Vector2i] = riverBanks.get_river_banks_line(current_y)
	grassLayer.put_grass_autotile(line)
	riverBanks.adjust_river_banks(Properties.DEFAULT_BANK_LEFT, Properties.DEFAULT_BANK_RIGHT)
	current_y -= 1

func drawing_ended() -> bool:
	return riverBanks.left == Properties.DEFAULT_BANK_LEFT && riverBanks.right == Properties.DEFAULT_BANK_RIGHT
