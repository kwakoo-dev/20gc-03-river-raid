class_name StartSegment
extends LevelSegment

@export var grassLayer : GrassLayerV3

func get_river_banks() -> RiverBanks:
	return RiverBanks.create(Properties.OPENING_LEFT, Properties.OPENING_RIGHT)

func get_segment_end_y() -> int:
	#if grassLayer:
	return grassLayer.get_segment_end_y()
	#return to_global(Vector2(0, 0)).y
