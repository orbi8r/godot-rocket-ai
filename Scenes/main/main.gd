extends Node3D

@onready var generation = $CanvasLayer/Text/Generation
@onready var coords = $CanvasLayer/Text/Coords
@onready var velocity = $CanvasLayer/Text/Velocity

@onready var rocket = $CanvasLayer/Rocket

@export var rocketheight = 300

func reset():
	rocket.global_position = Vector3(randi_range(-250,250), rocketheight, randi_range(-250,250))
	rocket.linear_velocity = Vector3.ZERO
	rocket.rotation = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.text = "Velocity : " + str(rocket.linear_velocity)
	coords.text = "Coordinate : " + str(rocket.global_position)
