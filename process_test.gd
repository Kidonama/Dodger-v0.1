extends Node2D

var speed = 100
var direction = Vector2.RIGHT   # this is (1,0), meaning move right

func _process(delta) :
	position += direction * speed * delta 
	$Button.modulate.a -= 0.5 * delta
	$Sprite2D.modulate.a -= 0.1 * delta
