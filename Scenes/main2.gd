extends Node3D

@onready var rocket = $CanvasLayer/Rocket
@onready var ai_controller_3d = $CanvasLayer/AIController3D

@export var rocketheight = 200
var groundtime = 0

var prevrotation = 0

func reset():
	rocket.global_position = Vector3(randi_range(-250,250), rocketheight, randi_range(-250,250))
	rocket.linear_velocity.y = 0
	rocket.linear_velocity.x = randi_range(-25,25)
	rocket.linear_velocity.z = randi_range(-25,25)
	rocket.angular_velocity = Vector3.ZERO
	rocket.rotation.x = 0
	rocket.rotation.y = randf_range(-1,1)
	rocket.rotation.z = randf_range(-1,1)
	groundtime = 0
	

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if groundtime > 100:
		reset()
	
	
	# Rewards for Ai
	if rocket.global_position.y < -22:
		reset()
		ai_controller_3d.reward -= 1000
	
	ai_controller_3d.reward -= delta*((rocket.linear_velocity.x)**2 + (rocket.linear_velocity.z)**2)/100
	
	ai_controller_3d.reward -= delta*((rocket.linear_velocity.y **2) - 400)/10
	
	if prevrotation > ((rocket.rotation.x)**2 + (rocket.rotation.z)**2):
		ai_controller_3d.reward -= delta*((rocket.rotation.x)**2 + (rocket.rotation.z)**2)*100
	else:
		ai_controller_3d.reward += delta*(20-((rocket.rotation.x)**2 + (rocket.rotation.z)**2))

	prevrotation = ((rocket.rotation.x)**2 + (rocket.rotation.z)**2)
	
	if rocket.is_thrusting == true:
		ai_controller_3d.reward -= delta*10
	
	if rocket.global_position.y > -20 and rocket.global_position.y < 80:
		ai_controller_3d.reward += delta*(80-(rocket.global_position.y))/10
		
		if rocket.global_position.y < -15:
			ai_controller_3d.reward += delta*10
			groundtime += delta
