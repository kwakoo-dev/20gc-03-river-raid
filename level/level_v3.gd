class_name LevelV3
extends Node2D

@export_category("Fragment Scenes")
@export var start_segment_scene : PackedScene
@export var river_segment_scene : PackedScene
@export var end_segment_scene : PackedScene

enum SegmentType {
	LEVEL_START,
	LEVEL_END,
	RIVER,
	#ISLAND_START,
	#ISLAND
}

var current_segment_type : SegmentType = SegmentType.LEVEL_START

var current_segment : LevelSegment
var level_segments : Array[LevelSegment] = []


func _ready() -> void:
	#instantiate_new_segment(start_segment_scene)
	add_new_segment()
	#var start_segment : StartSegment  = start_segment_scene.instantiate()
	#start_segment.global_position.x = 0
	#start_segment.global_position.y = get_viewport_rect().size.y
	#level_segments.append(start_segment)
	#current_segment = start_segment
	#add_child(start_segment)



func get_level_end_y() -> int:
	return current_segment.get_segment_end_y()

# tries to draw next part of the level. May be the whole segment, or part of it
func draw_level() -> void:
	if drawing_ended():
		return
	if current_segment.drawing_ended():
		add_new_segment()
	if current_segment.is_generated():
		current_segment.draw_next_terrain_line()

func add_new_segment() -> void:
	var new_segment_type : SegmentType = choose_new_segment()
	match new_segment_type:
		SegmentType.LEVEL_START:
			print_debug("Adding LEVEL_START segment")
			instantiate_new_segment(start_segment_scene)
			current_segment_type = SegmentType.LEVEL_START
		SegmentType.RIVER:
			print_debug("Adding RIVER segment")
			instantiate_new_segment(river_segment_scene)
			current_segment_type = SegmentType.RIVER
		SegmentType.LEVEL_END:
			print_debug("Adding END segment")
			instantiate_new_segment(end_segment_scene) 
			current_segment_type = SegmentType.LEVEL_END
		

func choose_new_segment() -> SegmentType:
	if !current_segment:
		return SegmentType.LEVEL_START
	match current_segment_type:
		SegmentType.LEVEL_START:
			return [SegmentType.RIVER].pick_random()
		SegmentType.RIVER:
			return [SegmentType.RIVER, SegmentType.LEVEL_END].pick_random()
		SegmentType.LEVEL_END:
			return [SegmentType.LEVEL_START].pick_random()
	print_debug("choose_new_segment: Unknown SegmentType: " + str(current_segment_type))
	return SegmentType.RIVER # should never happen

func instantiate_new_segment(segment_scene : PackedScene) -> void:
	var start_end_y : int = get_end_y()
	var river_banks : RiverBanks = get_river_banks()

	var segment : LevelSegment = segment_scene.instantiate()
	segment.setup(river_banks)
	segment.global_position.x = 0
	segment.global_position.y = start_end_y
	level_segments.append(segment)
	current_segment = segment
	add_child(segment)

func get_end_y() -> int:
	if current_segment:
		return current_segment.get_segment_end_y()
	return get_viewport_rect().size.y

func get_river_banks() -> RiverBanks:
	if current_segment:
		return current_segment.get_river_banks()
	return RiverBanks.new()

func drawing_ended() -> bool:
	if !current_segment:
		return false
	return current_segment_type == SegmentType.LEVEL_END && current_segment.drawing_ended()
