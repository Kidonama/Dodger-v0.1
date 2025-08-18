extends Node2D

var speed = 100
var direction = Vector2.RIGHT   # this is (1,0), meaning move right



func _physics_process(delta):
	position += direction * speed * delta
