extends Node2D

@onready var game_over_sfx := $GameOverSFX
@onready var spawner := $UI/HazardSpawner
@onready var game_over_label = $UI_Layer/GameOver   # get the label
@onready var game_over_overlay = $UI_Layer/ColorRect # optional dark overlay
var is_game_over := false                            # one-time latch
var elapsed_time = 0.0
var next_ramp_time = 10


func trigger_game_over() -> void:
	# if we already ended, do nothing
	if is_game_over:
		return
	is_game_over = true

	# show UI (no special process modes needed)
	if game_over_overlay: game_over_overlay.visible = true
	game_over_label.visible = true
	game_over_sfx.play()
	get_tree().paused = true #Pauses not frezes


func _unhandled_input(event: InputEvent) -> void:
	# only allow restart after game over
	if not is_game_over:
		return

	# listen for a single key press of R
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_R:
			get_tree().paused = false #stops the pause / restarts the flow
			get_tree().reload_current_scene()        # hard reset the scene

func _process(delta):
	if get_tree().paused:
		return  # do not advance time or ramp while paused

	elapsed_time += delta
	get_node("HUD/TimeLabel").text = "Time: " + ("%0.1f" % elapsed_time) + "s"

	if elapsed_time >= next_ramp_time:
		spawner.spawn_wait = max(0.5, spawner.spawn_wait - 0.15)
		next_ramp_time += 10
