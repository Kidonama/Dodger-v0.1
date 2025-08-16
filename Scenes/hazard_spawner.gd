extends Node2D
@export var hazard_scene: PackedScene
@onready var left := $LeftSpawner
@onready var right := $RightSpawner

func _ready() -> void:
	randomize()  # enable randf_range()


func _on_timer_timeout() -> void:
	var x := randf_range(left.global_position.x, right.global_position.x)
	var y: float = left.global_position.y
	var h := hazard_scene.instantiate()
	get_parent().add_child(h)
	h.global_position = Vector2(x, y)
