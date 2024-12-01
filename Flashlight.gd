extends Node3D  # Change this to the appropriate type of the Flashlight node

# Flag to track if the flashlight has been picked up
var is_picked_up: bool = false

# Path to the SpotLight3D child node
@export var light_node_path: NodePath = "Light"

func _ready():
	# Ensure the light child node is not visible initially
	var light_node = get_node_or_null(light_node_path)
	if light_node:
		light_node.visible = true
	else:
		print("Warning: Light node not found!")

# Called every frame
func _process(delta):
	if is_picked_up and Input.is_action_just_pressed("flashlight"):
		_toggle_light()

# Function to mark the flashlight as picked up
func mark_as_picked_up():
	is_picked_up = true
	print("Flashlight picked up!")

# Helper function to toggle the light visibility
func _toggle_light():
	var light_node = get_node_or_null(light_node_path)
	if light_node:
		light_node.visible = !light_node.visible
		print("Light toggled to:", light_node.visible)
	else:
		print("Error: Light node not found!")
