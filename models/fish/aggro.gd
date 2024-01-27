extends CharacterBody3D
@onready var character_body_3d = $"."

var move_direction : Vector3;
var wander_time: float;
var interested : bool = false;
@export var move_speed := 1;

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

enum state {
	swimming,
	idle
}

func randomize_wander():
	move_direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
	wander_time = randf_range(5, 10)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	pass

func _physics_process(delta):
	velocity = move_direction * move_speed
	move_and_slide()
