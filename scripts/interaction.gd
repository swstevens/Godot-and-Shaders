extends RayCast3D
@onready var sketchfab_scene = $"../../../../Sketchfab_Scene"

@onready var rigid_body_3d = $"../../../../Sketchfab_Scene/RigidBody3D"
@onready var pickup = $"../../../../pickup"
@onready var hand = $"../hand"
@onready var fishing_rod = $"../fishing_rod"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		print(get_collider().get_name())
		if get_collider().get_name() == pickup.get_name():
			if Input.is_action_pressed("pickup"):
				hand.set_process(false)
				fishing_rod.set_process(true)
			# set interact ui element to true
			# will need more general collision detection in the future
			pass
			#print(1)
	pass
