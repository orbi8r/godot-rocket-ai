extends AIController3D

@onready var rocket = $"../Rocket"

var thrustrotation
var thrustortho
var thrust

func get_obs() -> Dictionary:
	assert(false, "the get_obs method is not implemented when extending from ai_controller") 
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
