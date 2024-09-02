extends AIController3D

@onready var rocket = $"../Rocket"

var thrustrotation = 0
var thrustortho = 0 
var thrust = 0

func get_obs() -> Dictionary:
	return {"obs":[]}

func get_reward() -> float:	
	return reward
	
func get_action_space() -> Dictionary: 
	return {
		"thruster" : {
			"size": 3,
			"action_type": "continuous"
		}
		}

func set_action(action) -> void:	
	thrustrotation = action["thruster"][0]
	thrustortho = action["thruster"][1]
	thrust = action["thruster"][2]
