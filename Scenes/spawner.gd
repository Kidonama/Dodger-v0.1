extends Node2D

@export var hazard_scene: PackedScene

func spawn_once():
	var hazard = hazard_scene.instantiate()
	var screen_size = get_viewport_rect().size
	var bomb_size = hazard.get_node("Bomb").texture.get_size() / 2
	hazard.position = Vector2(
	randf_range(bomb_size.x, screen_size.x - bomb_size.x),
	randf_range(bomb_size.y, screen_size.y - bomb_size.y)
)

	add_child(hazard)

func _ready():
	spawn_once()


func _on_timer_timeout() -> void:
	spawn_once()
