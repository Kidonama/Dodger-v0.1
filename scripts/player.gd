extends CharacterBody2D

var start_y: float
var speed = 200

func _physics_process(delta: float) -> void:
	var x_input := Input.get_axis("ui_left", "ui_right")   # -1..1
	velocity = Vector2(x_input * speed, 0)                 # no vertical velocity
	global_position.y = start_y                            # pin Y
	move_and_slide()


func _ready() -> void:
	start_y = global_position.y
