extends Node

## in blocks
const LEVEL_WIDTH : int = 40
const BRIDGE_WIDTH : int = 12
const NARROWEST : int = 8
const DEFAULT_BANK_LEFT : int = (LEVEL_WIDTH - BRIDGE_WIDTH) / 2
const DEFAULT_BANK_RIGHT : int = DEFAULT_BANK_LEFT + BRIDGE_WIDTH
const MIN_BANK_LEFT : int = 2
const MAX_BANK_RIGHT : int = LEVEL_WIDTH - MIN_BANK_LEFT
const MIN_ISLAND_LEFT : int = MIN_BANK_LEFT + NARROWEST
const MAX_ISLAND_RIGHT : int = MAX_BANK_RIGHT - NARROWEST
const OPENING_LEFT : int = DEFAULT_BANK_LEFT - 5
const OPENING_RIGHT : int = DEFAULT_BANK_RIGHT + 5
const MIDDLE_X : int = (DEFAULT_BANK_RIGHT + DEFAULT_BANK_LEFT) / 2
## The bigger the value, the more straight the river is.
const RIVER_STRAIGHTNESS : int = 10
