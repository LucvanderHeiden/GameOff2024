extends WorldEnvironment

@export var new_day_environment : String = "res://Materials/env_day.tres"
@export var new_night_environment : String = "res://Materials/env_night.tres"

func _ready():
	print("ready")
	
	# Load the Environment resource
	var day_env_resource = load(new_day_environment)
	
	# Set the loaded environment
	if day_env_resource:
		set_environment(day_env_resource)
	else:
		print("Failed to load the environment!")

func _change_sky():
	var night_env_resource = load(new_night_environment)
	if night_env_resource:
		set_environment(night_env_resource)
	else:
		print("Failed to load night environment")
