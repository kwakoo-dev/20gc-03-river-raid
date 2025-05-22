extends TileMapLayer

const ATLAS : int = 2
const GROUND_TILE : Vector2i = Vector2i(2,5)

func _ready() -> void:
	set_cell(Vector2i(3,4), ATLAS, GROUND_TILE)
	set_cell(Vector2i(3,5), ATLAS, GROUND_TILE)
