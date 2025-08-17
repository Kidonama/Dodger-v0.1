extends Area2D

signal collected(points: int)

@export var fall_speed: float = 180.0

func _physics_process(delta: float) -> void:
	global_position.y += fall_speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("collected", 10)          # update score immediately
		$PickupSFX.play()                     # play sfx

		monitoring = false                    # stop further overlaps
		$CollisionShape2D.disabled = true     # disable collisions
		$Sprite2D.visible = false             # hide banana so it doesn’t clip through
		await get_tree().create_timer(0.25).timeout
		queue_free()



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
