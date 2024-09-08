extends AIController3D

@onready var rocket = $"../Rocket"

var thrustrotation = 0
var thrustortho = 0 
var thrust = 0.5

func get_obs() -> Dictionary:
	var obs := [
		rocket.position.y,
		rocket.rotation.x,
		rocket.rotation.y,
		rocket.rotation.z,
		rocket.linear_velocity.x,
		rocket.linear_velocity.y,
		rocket.linear_velocity.z,
		rocket.angular_velocity.x,
		rocket.angular_velocity.y,
		rocket.angular_velocity.z,
		rocket.thrustdir.x,
		rocket.thrustdir.y,
		rocket.thrustdir.z,
		rocket.is_thrusting
	]
	return {"obs":obs}

func get_reward() -> float:	
	return reward
	
func get_action_space() -> Dictionary: 
	return {
		"thruster" : {
			"size": 2,
			"action_type": "continuous"
		},
		"fire": {
			"size": 1, 
			"action_type": "discrete"}
		}
		

func set_action(action) -> void:	
	thrustrotation = action["thruster"][0]
	thrustortho = action["thruster"][1]
	thrust = action["fire"]
