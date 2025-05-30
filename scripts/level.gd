extends Node2D
class_name GrassLayer

## how long a river / island section should be, in tiles
@export var land_block_length : int = 30

@onready var _grassLayer : TileMapLayer = $GrassLayer
@onready var _waterLayer : TileMapLayer = $WaterLayer

enum LandGenerationMode {
	LEVEL_START,
	LEVEL_END,
	RIVER,
	ISLAND_START,
	ISLAND
}

const LEVEL_WIDTH : int = 40

var grass_y : int = 0

var current_generation_mode : LandGenerationMode = LandGenerationMode.LEVEL_START

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		generate_land()

func generate_land() -> void:
	current_generation_mode = LandGenerationMode.LEVEL_START
	print_debug("LEVEL_START")
	var block_length : int = _grassLayer.draw_level_start(grass_y)
	grass_y -= block_length
	
	while current_generation_mode != LandGenerationMode.LEVEL_END:
		current_generation_mode = _get_next_generation_mode(current_generation_mode)
		block_length = _draw_land_block(grass_y)
		grass_y -= block_length
	
	_waterLayer.draw_water_until(grass_y / 2)	

func _draw_land_block(start_y : int) -> int:
	match current_generation_mode:
		LandGenerationMode.LEVEL_START:
			print_debug("LEVEL_START")
			return _grassLayer.draw_level_start(start_y)
		LandGenerationMode.LEVEL_END:
			print_debug("LEVEL_END")
			return _grassLayer.draw_level_end(start_y)
		LandGenerationMode.RIVER:
			print_debug("RIVER")
			return _grassLayer.draw_river(start_y, land_block_length)
		LandGenerationMode.ISLAND_START:
			print_debug("ISLAND_START")
			return _grassLayer.draw_island_start(start_y)
		LandGenerationMode.ISLAND:
			print_debug("ISLAND")
			return _grassLayer.draw_island(start_y, land_block_length)
			
	print_debug("_draw_land_block: Unknown LandGenerationMode: " + str(current_generation_mode))
	return LandGenerationMode.RIVER # should never happen

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
