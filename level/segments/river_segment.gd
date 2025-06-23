class_name RiverSegment
extends Node2D

@export var grassLayer : GrassLayerV3
@export var waterLayer : WaterLayer

var riverBanks : RiverBanks = RiverBanks.new()

var current_y = 0

## todo: temporary
func _ready() -> void:
	for i in range(100):
		draw_next_terrain_line_auto()
		riverBanks.change_river_banks()
		current_y -= 1

func setup(riverBanks : RiverBanks) -> void:
	self.riverBanks = riverBanks

func draw_next_terrain_line() -> void:
	var line : Array[Vector2i] = riverBanks.get_river_banks_line(current_y)
	grassLayer.put_grass_raw(line)

func draw_next_terrain_line_auto() -> void:
	var line : Array[Vector2i] = riverBanks.get_river_banks_line(current_y)
	grassLayer.put_grass_autotile(line)
