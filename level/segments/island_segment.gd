class_name IslandSegment
extends LevelSegment

@export var grassLayer : GrassLayerV3

enum IslandSegmentType {
	ISLAND_START,
	ISLAND,
	ISLAND_END
}

var current_island_segment_type : IslandSegmentType = IslandSegmentType.ISLAND_START
var riverBanks : RiverBanks = RiverBanks.new()
var island : Island = Island.new()

var current_y = 0
var drawing_ended_flag : bool = false

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
	match current_island_segment_type:
		IslandSegmentType.ISLAND_START:
			draw_island_start()
		IslandSegmentType.ISLAND:
			draw_island()
		IslandSegmentType.ISLAND_END:
			draw_island_end()

func draw_island_start() -> void:
	var line : Array[Vector2i] = riverBanks.get_river_banks_line(current_y)
	grassLayer.put_grass_autotile(line)
	if current_y % 2 == 0:
		riverBanks.adjust_river_banks(Properties.MIN_BANK_LEFT, Properties.MAX_BANK_RIGHT)
	current_y -= 1
	if riverBanks.left == Properties.MIN_BANK_LEFT && riverBanks.right == Properties.MAX_BANK_RIGHT:
		current_island_segment_type = IslandSegmentType.ISLAND

func draw_island() -> void:
	var line : Array[Vector2i] = island.get_river_banks_line(current_y, riverBanks)
	grassLayer.put_grass_autotile(line)
	island.change_island_banks()
	current_y -= 1
	if abs(current_y) >= Properties.MAX_SEGMENT_LENGTH - Properties.ISLAND_END_LENGTH:
		current_island_segment_type = IslandSegmentType.ISLAND_END

func draw_island_end() -> void:
	var line : Array[Vector2i] = riverBanks.get_river_banks_line(current_y)
	grassLayer.put_grass_autotile(line)
	current_y -= 1
	if abs(current_y) >= Properties.MAX_SEGMENT_LENGTH:
		drawing_ended_flag = true

func drawing_ended() -> bool:
	return drawing_ended_flag
