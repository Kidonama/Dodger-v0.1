extends Area2D

@export var explosion_scene: PackedScene
@export var speed: float = 180.0  # try 120–220 later
@export var margin: int = 32      # extra pixels below screen before despawn

var triggered := false

func spawn_explosion() -> void:
	var explosion = explosion_scene.instantiate()
	get_parent().add_child(explosion)
	explosion.global_position = global_position

# If we’ve fallen below the viewport, delete the hazard
func _process(delta: float) -> void:
	position.y += speed * delta

	var h := get_viewport_rect().size.y
	if position.y > h + margin:
		spawn_explosion()
		queue_free()
		print("Hazard despawn: spawning explosion")

func _ready() -> void:
	print("hazard ready:", get_path())




func _on_body_entered(body: Node2D) -> void:
	if triggered:
		return
	triggered = true
	spawn_explosion()
	get_tree().current_scene.trigger_game_over() #if get hit = game over
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
