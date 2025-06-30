extends Node

const DRAWING_DISTANCE = 400

## in blocks
const LEVEL_WIDTH : int = 40
const BRIDGE_WIDTH : int = 8
const NARROWEST : int = 8
const DEFAULT_BANK_LEFT : int = (LEVEL_WIDTH - BRIDGE_WIDTH) / 2
const DEFAULT_BANK_RIGHT : int = DEFAULT_BANK_LEFT + BRIDGE_WIDTH
const MIN_BANK_LEFT : int = 2
const MAX_BANK_RIGHT : int = LEVEL_WIDTH - MIN_BANK_LEFT
const MIN_ISLAND_LEFT : int = MIN_BANK_LEFT + NARROWEST
const MAX_ISLAND_RIGHT : int = MAX_BANK_RIGHT - NARROWEST
const OPENING_LEFT : int = DEFAULT_BANK_LEFT - 5
const OPENING_RIGHT : int = DEFAULT_BANK_RIGHT + 5
const MIDDLE_X : int = 640
const BRIDGE_Y : int = -96
## The bigger the value, the more straight the river is.
const RIVER_STRAIGHTNESS : int = 10
const ISLAND_STRAIGHTNESS : int = 5
const ISLAND_END_LENGTH : int = 2
const MAX_SEGMENT_LENGTH : int = 40

# PLANE
const PLANE_ACCELERATION : int = 500
const PLANE_MIN_SPEED : float = 150.0
const PLANE_MAX_SPEED : float = 700.0
const PLANE_TURN_SPEED : int = 600
const PLANE_TURN_DEAD_ZONE : float = 0.1

# BULLETS
const BULLET_SPEED : int = 1500
const WEAPON_COOLDOWN : float = 400 # in miliseconds

# GUI
const INFO_SCROLL_SPEED : int = 800
const TEXT_SCROLL_MARGIN : int = 1280
