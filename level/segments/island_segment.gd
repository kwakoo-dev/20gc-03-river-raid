class_name IslandSegment
extends LevelSegment

@export var grass_layer : GrassLayer

enum IslandSegmentType {
	ISLAND_START,
	ISLAND,
	ISLAND_END
}

var current_island_segment_type : IslandSegmentType = IslandSegmentType.ISLAND_START
var river_banks : RiverBanks = RiverBanks.new()
var island : Island = Island.new()

var current_y = 0
var drawing_ended_flag : bool = false

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
	match current_island_segment_type:
		IslandSegmentType.ISLAND_START:
			draw_island_start()
		IslandSegmentType.ISLAND:
			draw_island()
		IslandSegmentType.ISLAND_END:
			draw_island_end()

func draw_island_start() -> void:
	var line : Array[Vector2i] = river_banks.get_river_banks_line(current_y)
	grass_layer.put_grass_autotile(line)
	if current_y % 2 == 0:
		river_banks.adjust_river_banks(Properties.MIN_BANK_LEFT, Properties.MAX_BANK_RIGHT)
	current_y -= 1
	if river_banks.left == Properties.MIN_BANK_LEFT && river_banks.right == Properties.MAX_BANK_RIGHT:
		current_island_segment_type = IslandSegmentType.ISLAND

func draw_island() -> void:
	var line : Array[Vector2i] = island.get_river_banks_line(current_y, river_banks)
	grass_layer.put_grass_autotile(line)
	island.change_island_banks()
	current_y -= 1
	if abs(current_y) >= Properties.MAX_SEGMENT_LENGTH - Properties.ISLAND_END_LENGTH:
		current_island_segment_type = IslandSegmentType.ISLAND_END

func draw_island_end() -> void:
	var line : Array[Vector2i] = river_banks.get_river_banks_line(current_y)
	grass_layer.put_grass_autotile(line)
	current_y -= 1
	if abs(current_y) >= Properties.MAX_SEGMENT_LENGTH:
		drawing_ended_flag = true

func drawing_ended() -> bool:
	return drawing_ended_flag
