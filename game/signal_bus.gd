extends Node

@warning_ignore_start("unused_signal")
signal player_hit_bridge
signal player_hit_wall
signal checkpoint_reached(bridge : Bridge)
# UI
signal show_get_ready
signal show_checkpoint_reached
signal show_player_died
@warning_ignore_restore("unused_signal")
