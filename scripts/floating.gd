extends RigidBody3D

@export var float_force := 1.4;
@export var water_drag := 0.1;
@export var water_angular_drag := 0.1;
@onready var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity");

@onready var probes = $ProbeContainer.get_children()

@onready var water = get_node('../Water')

const water_height := 0.0;

var submerged := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	submerged = false
	for p in probes:
		var depth = water.get_height(p.global_position) - p.global_position.y;
		if depth > 0:
			submerged = true
			apply_force(Vector3.UP * float_force * gravity * depth,p.global_position - global_position);

func _integrate_force(state: PhysicsDirectBodyState3D):
	if submerged:
		state.linear_velocity *= 1 - water_drag;
		state.angular_velocity *= 1 - water_angular_drag;
