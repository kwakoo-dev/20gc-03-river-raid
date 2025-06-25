class_name LevelSegment
extends Node2D

func setup(riverBanks : RiverBanks) -> void:
	pass

## returns true if segment is generated line by line,
## returns false if segment has predefined shape
func is_generated() -> bool:
	return false

func get_river_banks() -> RiverBanks:
	return RiverBanks.new()

func get_segment_end_y() -> int:
	return to_global(Vector2(0, 0)).y

func draw_next_terrain_line() -> void:
	pass

func drawing_ended() -> bool:
	return true
