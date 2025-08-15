extends CharacterBody2D

var speed = 200
func _physics_process(delta): 
	var input_dir = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	print(input_dir)
	var desired_velocity = input_dir * speed
	velocity=desired_velocity
	move_and_slide()
