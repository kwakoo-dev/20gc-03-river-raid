class_name LevelDrawingComponent
extends Node

@export
var level : Level
@export
var camera : Camera2D
@export
var draw_distance : int = 500
@export
var level_start_length : int = 24

enum LandGenerationMode {
	LEVEL_START,
	LEVEL_END,
	RIVER,
	ISLAND_START,
	ISLAND
}


var grass_y : int = 0
var segment_break_point : int = -3000

var current_generation_mode : LandGenerationMode = LandGenerationMode.RIVER

func _ready() -> void:
	_switch_generation_mode(LandGenerationMode.LEVEL_START)

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = PackedStringArray()
	if level == null:
		warnings.append("Please set level property")
	if camera == null:
		warnings.append("Please set camera property")
	return warnings

#var print_delay : float = 0;

func _process(delta: float) -> void:
	pass
	#var level_end_y = level.get_land_end_y()
	#var camera_position_y = camera.get_screen_center_position().y
	#var camera_with_draw_distance_y = camera_position_y - draw_distance
	#if level_end_y < camera_with_draw_distance_y:
		#return
		#
	#var drawn_lines : int = _draw_land_block()
	#grass_y -= drawn_lines
	#if drawn_lines == 0:
		#_switch_generation_mode(current_generation_mode)

func _draw_land_block() -> int:
	match current_generation_mode:
		LandGenerationMode.LEVEL_START:
			print_debug("LEVEL_START")
			return 0
			#return _grassLayer.draw_level_start(start_y)
		LandGenerationMode.LEVEL_END:
			print_debug("LEVEL_END")
			return 0
			#return _grassLayer.draw_level_end(start_y)
		LandGenerationMode.RIVER:
			print_debug("RIVER")
			return level.draw_river(grass_y, segment_break_point)
		LandGenerationMode.ISLAND_START:
			print_debug("ISLAND_START")
			return 0
			#return _grassLayer.draw_island_start(start_y)
		LandGenerationMode.ISLAND:
			print_debug("ISLAND")
			return 0
			#return _grassLayer.draw_island(start_y, land_block_length)
			
	print_debug("_draw_land_block: Unknown LandGenerationMode: " + str(current_generation_mode))
	return LandGenerationMode.RIVER # should never happen

func _switch_generation_mode(generation_mode : LandGenerationMode) -> LandGenerationMode:
	var new_generation_mode = _get_next_generation_mode(generation_mode)

	return new_generation_mode

func _get_next_generation_mode(generation_mode : LandGenerationMode) -> LandGenerationMode:
	match generation_mode:
		LandGenerationMode.LEVEL_START:
			return [LandGenerationMode.RIVER, LandGenerationMode.ISLAND_START].pick_random()
		LandGenerationMode.LEVEL_END:
			return LandGenerationMode.LEVEL_START
		LandGenerationMode.RIVER:
			return [LandGenerationMode.ISLAND_START, LandGenerationMode.LEVEL_END].pick_random()
		LandGenerationMode.ISLAND_START:
			return LandGenerationMode.ISLAND
		LandGenerationMode.ISLAND:
			return [LandGenerationMode.RIVER, LandGenerationMode.LEVEL_END].pick_random()
	print_debug("_get_next_generation_mode: Unknown LandGenerationMode: " + str(generation_mode))
	return LandGenerationMode.RIVER # should never happen
