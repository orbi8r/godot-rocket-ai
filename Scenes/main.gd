extends Node3D

@onready var generation = $CanvasLayer/Text/Generation
@onready var coords = $CanvasLayer/Text/Coords
@onready var velocity = $CanvasLayer/Text/Velocity

@onready var rocket = $CanvasLayer/Rocket



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.text = "Velocity : " + str(rocket.linear_velocity)
	coords.text = "Coordinate : " + str(rocket.global_position)
