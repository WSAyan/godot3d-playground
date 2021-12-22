extends RigidBody

var rolling_force = 40

func _ready():
	$CameraRig.set_as_toplevel(true)
	# Make sure FloorCheck raycast doesn't inherit Balls transforms,
	# so that it doesn't rotate as the ball rolls
	$FloorCheck.set_as_toplevel(true)

func _physics_process(delta):
	$CameraRig.global_transform.origin = lerp(
		$CameraRig.global_transform.origin, 
		global_transform.origin, 0.1
	)
	# As the ball moves, move the raycast along with it
	$FloorCheck.global_transform.origin = global_transform.origin

	if Input.is_action_pressed("forward"):
		angular_velocity.x -= rolling_force*delta
	elif Input.is_action_pressed("back"):
		angular_velocity.x += rolling_force*delta
	if Input.is_action_pressed("left"):
		angular_velocity.z += rolling_force*delta
	elif Input.is_action_pressed("right"):
		angular_velocity.z -= rolling_force*delta

	# When the ball is on the floor and the user presses jump button,
	# add impulse moving the ball up.
	if Input.is_action_just_pressed("jump") and $FloorCheck.is_colliding():
		apply_impulse(Vector3(), Vector3.UP*10)
