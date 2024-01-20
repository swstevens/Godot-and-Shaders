extends RayCast3D
@onready var sketchfab_scene = $"../../../../Sketchfab_Scene"

@onready var rigid_body_3d = $"../../../../Sketchfab_Scene/RigidBody3D"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		if get_collider().get_name() == rigid_body_3d.get_name():
			# set interact ui element to true
			# will need more general collision detection in the future
			pass
			#print(1)
	pass
