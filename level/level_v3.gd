class_name LevelV3
extends Node2D

@export_category("Fragment Scenes")
@export var start_segment_scene : PackedScene
@export var river_segment_scene : PackedScene

enum SegmentType {
	LEVEL_START,
	#LEVEL_END,
	RIVER,
	#ISLAND_START,
	#ISLAND
}

var current_segment_type : SegmentType = SegmentType.LEVEL_START

var current_segment : LevelSegment
var level_segments : Array[LevelSegment] = []


func _ready() -> void:
	var start_segment : StartSegment  = start_segment_scene.instantiate()
	start_segment.global_position.x = 0
	start_segment.global_position.y = get_viewport_rect().size.y
	level_segments.append(start_segment)
	current_segment = start_segment
	add_child(start_segment)
	
	var start_river_banks : RiverBanks = start_segment.get_river_banks()
	
	var start_end_y : int = start_segment.get_segment_end_y()
	
	var river_segment : RiverSegment = river_segment_scene.instantiate()
	river_segment.setup(start_river_banks)
	river_segment.global_position.x = 0
	river_segment.global_position.y = start_end_y
	level_segments.append(river_segment)
	current_segment = river_segment
	add_child(river_segment)

func choose_new_segment() -> SegmentType:
	match current_segment_type:
		SegmentType.LEVEL_START:
			return [SegmentType.RIVER].pick_random()
	print_debug("choose_new_segment: Unknown SegmentType: " + str(current_segment_type))
	return SegmentType.RIVER # should never happen

func add_new_segment(segment_scene : PackedScene) -> void:
	var start_end_y : int = current_segment.get_segment_end_y()
	var river_banks :RiverBanks = current_segment.get_river_banks()

	var segment : LevelSegment = segment_scene.instantiate()
	segment.setup(river_banks)
	segment.global_position.x = 0
	segment.global_position.y = start_end_y
	level_segments.append(segment)
	current_segment = segment
	add_child(segment)

func get_level_end_y() -> int:
	return current_segment.get_segment_end_y()

# tries to draw next part of the level. May be the whole segment, or part of it
func draw_level() -> void:
	if current_segment.drawing_ended():
		return
	if current_segment.is_generated():
		current_segment.draw_next_terrain_line()
