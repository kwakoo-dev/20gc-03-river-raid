extends Node2D

@export var waterLayer : WaterLayer

func _ready() -> void:
	waterLayer.draw_water(0, -26)
