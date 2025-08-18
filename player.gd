extends CharacterBody2D

var speed = 200

#func _process(delta):
#	var input_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
#	position.x += input_dir * speed * delta



#func _process(delta):
#	var input_dir = Vector2(
#		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
#		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
#	)
#	position += input_dir * speed * delta



func _physics_process(delta):
	var input_dir = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength('ui_down') - Input.get_action_strength("ui_up")
	)
	velocity = input_dir * speed
	move_and_slide()
