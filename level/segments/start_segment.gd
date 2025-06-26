class_name StartSegment
extends LevelSegment

@export var grass_layer : GrassLayer

func get_river_banks() -> RiverBanks:
	return RiverBanks.create(Properties.OPENING_LEFT, Properties.OPENING_RIGHT)

func get_segment_end_y() -> int:
	return grass_layer.get_segment_end_y()
