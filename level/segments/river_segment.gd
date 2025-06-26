class_name RiverSegment
extends LevelSegment

@export var grassLayer : GrassLayerV3

var riverBanks : RiverBanks = RiverBanks.new()

var current_y = 0

func setup(new_river_banks : RiverBanks) -> void:
	self.riverBanks = new_river_banks

func is_generated() -> bool:
	return true

func get_segment_end_y() -> int:
	if grassLayer:
		return grassLayer.get_segment_end_y()
	return int(to_global(Vector2(0, 0)).y)

func get_river_banks() -> RiverBanks:
	return riverBanks

func draw_next_terrain_line() -> void:
	var line : Array[Vector2i] = riverBanks.get_river_banks_line(current_y)
	grassLayer.put_grass_autotile(line)
	riverBanks.change_river_banks()
	current_y -= 1

func drawing_ended() -> bool:
	return abs(current_y) > Properties.MAX_SEGMENT_LENGTH
