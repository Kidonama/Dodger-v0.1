extends Node2D
@export var hazard_scene: PackedScene
@onready var left := $LeftSpawner
@onready var right := $RightSpawner
@onready var timer := $SpawnerTimer
@onready var center := $CenterSpawner
@export var center_prob := 0.20     # 20% centre spawns
@export var side_gap    := 32.0     # keep a gap around centre so sides don't overlap
@export var center_jitter := 48.0   # how wide to randomise around centre
@export var banana_scene: PackedScene
@export var banana_chance := 0.30   # 30%

var last_side := -1   # -1 none, 0 left, 1 right, 2 center
var spawn_wait = 1.4

func _ready() -> void:
	randomize()  # enable randf_range()


func _on_timer_timeout() -> void:
	var choice := 2 if randf() < center_prob else (0 if randf() < 0.5 else 1)

	# prevent same side twice (only for left/right)
	if (choice == last_side) and (choice != 2):
		choice = 1 - choice

	var x: float
	var lx = left.global_position.x
	var cx = center.global_position.x
	var rx = right.global_position.x

	match choice:
		0:
			x = randf_range(lx, max(lx, cx - side_gap))          # left segment
		1:
			x = randf_range(min(rx, cx + side_gap), rx)          # right segment
		2:
			x = cx + randf_range(-center_jitter, center_jitter)  # jitter around centre

	last_side = choice

	var y: float = left.global_position.y

	# ---- choose ONE scene and spawn it ----
	var scene_to_spawn: PackedScene = hazard_scene
	if banana_scene and randf() < banana_chance:
		scene_to_spawn = banana_scene

	var inst := scene_to_spawn.instantiate()
	get_parent().add_child(inst)
	inst.global_position = Vector2(x, y)
	# ---------------------------------------
# If this instance emits a 'collected' signal (i.e., it's a Banana), connect it to Main
	if inst.has_signal("collected"):
		var main := get_tree().get_first_node_in_group("Game")
		if main:
			inst.collected.connect(main._on_banana_collected)

	timer.wait_time = spawn_wait
	timer.start()
