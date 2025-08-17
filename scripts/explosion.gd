extends Node2D

func _on_timer_timeout() -> void:
	queue_free()

func _ready():
	$ExplosionParticles.restart()
	$ExplosionParticles.emitting = true
	print("Explosion READY")
	$ExplosionSFX.play()
