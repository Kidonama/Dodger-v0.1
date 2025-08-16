extends Node2D

@onready var game_over_label = $UI_Layer/GameOver   # get the label
@onready var game_over_overlay = $UI_Layer/ColorRect # optional dark overlay
var is_game_over := false                            # one-time latch

func trigger_game_over() -> void:
	# if we already ended, do nothing
	if is_game_over:
		return
	is_game_over = true

	# show UI (no special process modes needed)
	if game_over_overlay: game_over_overlay.visible = true
	game_over_label.visible = true

	Engine.time_scale = 0.0                          # << freeze EVERYTHING (physics, timers, _process deltas)

func _unhandled_input(event: InputEvent) -> void:
	# only allow restart after game over
	if not is_game_over:
		return

	# listen for a single key press of R
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_R:
			Engine.time_scale = 1.0                  # << restore normal time
			get_tree().reload_current_scene()        # hard reset the scene
