class_name LevelSegment
extends Node2D

func get_river_banks() -> RiverBanks:
	return RiverBanks.new()

func get_segment_end_y() -> int:
	return 0
	
## returns true if segment is generated line by line,
## returns false if segment has predefined shape
func is_generated() -> bool:
	return false

func draw_next_terrain_line() -> void:
	pass

func drawing_ended() -> bool:
	return true
