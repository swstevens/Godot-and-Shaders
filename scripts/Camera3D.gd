extends Camera3D

var d := 0.0
var radius := 5
var speed := .25
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	d += delta
	position = Vector3(
		sin(d * speed) * radius,
		0.0,
		cos(d * speed) * radius,
	) + Vector3(0,2,0)
	rotation = Vector3(
		0.0,
		d * speed,
		0.0
	) + Vector3(-.08,0,0)
