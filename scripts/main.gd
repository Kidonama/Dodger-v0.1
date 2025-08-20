extends Node2D

@onready var game_over_sfx := $GameOverSFX
@onready var spawner := $GameLayer/HazardSpawner
@onready var game_over_label = $UI_Layer/GameOver   # get the label
@onready var game_over_overlay = $UI_Layer/GameOver # optional dark overlay
var is_game_over := false                            # one-time latch
var elapsed_time = 0.0
var next_ramp_time = 10
var score:int = 0
var high_score:int = 0



func _save_high_score() -> void:
	var cfg := ConfigFile.new()
	# Load existing file if present (so we don’t wipe other future settings)
	var _err := cfg.load("user://save.cfg")
	cfg.set_value("scores", "high", high_score)
	cfg.save("user://save.cfg")

func _load_high_score() -> void:
	var cfg := ConfigFile.new()
	var err := cfg.load("user://save.cfg")
	if err == OK:
		high_score = int(cfg.get_value("scores", "high", 0))
	else:
		high_score = 0



func _update_score_labels() -> void:
	get_node("HUD_Layer/HUD/VBoxContainer/ScoreLabel").text = "Score: %d" % score
	get_node("HUD_Layer/HUD/VBoxContainer/HighLabel").text  = "High: %d" % high_score

func _add_score(points:int) -> void:
	if get_tree().paused:
		return
	score += points
	if score > high_score:
		high_score = score
		_save_high_score()
	_update_score_labels()   # always refresh UI



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
			score = 0

func _on_banana_collected(points:int) -> void:
	_add_score(points)

func _ready() -> void:
	_load_high_score()
	_update_score_labels()



func _process(delta):
	if get_tree().paused:
		return  # do not advance time or ramp while paused

	elapsed_time += delta
	get_node("HUD_Layer/HUD/TimeLabel").text = "Time: " + ("%0.1f" % elapsed_time) + "s"

	if elapsed_time >= next_ramp_time:
		spawner.spawn_wait = max(0.5, spawner.spawn_wait - 0.15)
		next_ramp_time += 10
