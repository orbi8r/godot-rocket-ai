extends RigidBody3D

@onready var thrust_point = $ThrustPoint
@onready var thruster = $ThrustPoint/Thruster
@onready var fire = $ThrustPoint/Thruster/Fire
@onready var ai_controller_3d = $"../AIController3D"


@export var thrustforce = 15


var is_trusting = false
var thrust_dir = Vector3(0,thrustforce,0)
var thrust_xz_dir = Vector3(1,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	fire.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# AI inputs
	
	thrust_point.rotate_y(deg_to_rad(10 * ai_controller_3d.thrustortho))
	thrust_dir = thrust_dir.rotated(Vector3(0,1,0), deg_to_rad(10 * ai_controller_3d.thrustortho))
	thrust_xz_dir = thrust_xz_dir.rotated(Vector3(0,1,0), deg_to_rad(10 * ai_controller_3d.thrustortho))
	
	if thruster.rotation_degrees.x <= 60 and thruster.rotation_degrees.x >= 0:
		thruster.rotate_x(deg_to_rad(3 * ai_controller_3d.thrustrotation))
		thrust_dir = thrust_dir.rotated(thrust_xz_dir, deg_to_rad(3 * ai_controller_3d.thrustrotation))
	elif thruster.rotation_degrees.x > 60:
		thruster.rotation_degrees.x = 59
	elif thruster.rotation_degrees.x < 0:
		thruster.rotation_degrees.x = 1
	
	# Human inputs
	
	if Input.is_action_pressed("clockwise"):
		thrust_point.rotate_y(deg_to_rad(-10))
		thrust_dir = thrust_dir.rotated(Vector3(0,1,0), deg_to_rad(-10))
		thrust_xz_dir = thrust_xz_dir.rotated(Vector3(0,1,0), deg_to_rad(-10))
	elif Input.is_action_pressed("anticlockwise"):
		thrust_point.rotate_y(deg_to_rad(10))
		thrust_dir = thrust_dir.rotated(Vector3(0,1,0), deg_to_rad(10))
		thrust_xz_dir = thrust_xz_dir.rotated(Vector3(0,1,0), deg_to_rad(10))
		
		
	if Input.is_action_pressed("exterior") and thruster.rotation_degrees.x < 60:
		thruster.rotate_x(deg_to_rad(3))
		thrust_dir = thrust_dir.rotated(thrust_xz_dir, deg_to_rad(3))
	elif Input.is_action_pressed("interior") and thruster.rotation_degrees.x > 0:
		thruster.rotate_x(deg_to_rad(-3))
		thrust_dir = thrust_dir.rotated(thrust_xz_dir, deg_to_rad(-3))
		
	# Thrust firing for Human and AI controls	
	
	if Input.is_action_just_pressed("thrust") || ai_controller_3d.thrust > 0:
		is_trusting = true
		fire.visible = true
	elif Input.is_action_just_released("thrust") || ai_controller_3d.thrust < 0:
		is_trusting = false
		fire.visible = false
	
	if is_trusting == true:
		apply_force(thrust_dir, Vector3(0,-5,0))
	
