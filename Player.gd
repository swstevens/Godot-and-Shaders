extends CharacterBody3D

@onready var head = $head
@onready var collision = $collision
@onready var crouch_collision = $crouch_collision
@onready var ray_cast_3d = $RayCast3D

const SPEED = 5.0
var current_speed = 5.0

const walking_speed = 5.0
const sprint_speed = 3.0
const crouching_speed = 3.0

const JUMP_VELOCITY = 4.5

const mouse_sens = 0.4

var lerp_speed = 10.0
var sprinting = false

var direction = Vector3.ZERO

var crouch_height = -0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89),deg_to_rad(89))

func _physics_process(delta):
	# Add the gravity.
	if Input.is_action_pressed("crouch"):
		current_speed = crouching_speed
		head.position.y = lerp(head.position.y,0.0 + crouch_height,delta*lerp_speed)
		collision.disabled = true
		crouch_collision.disabled = false
	elif !ray_cast_3d.is_colliding():
		head.position.y = lerp(head.position.y,0.0,delta*lerp_speed)
		current_speed = walking_speed
		collision.disabled = false
		crouch_collision.disabled = true
		
	if Input.is_action_pressed("sprint") and is_on_floor():
		sprinting = true
	elif not Input.is_action_pressed("sprint") and is_on_floor():
		sprinting = false
	
	current_speed += int(sprinting) * sprint_speed
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta*lerp_speed)
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
