extends Node3D
@export var has_fishing_rod : bool = true;
@onready var fishing_rod = $fishing_rod
@onready var hand = $hand

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("fishing_rod") and has_fishing_rod:
		fishing_rod.visible = true
		hand.visible = false
	if Input.is_action_pressed("hand"):
		fishing_rod.visible = false
		hand.visible = true
		# set fishing rod to show and all other inventory items to false
	pass
