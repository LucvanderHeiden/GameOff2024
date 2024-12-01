extends Area3D

# Node path for the flashlight object on the table
@export var flashlight_on_table_path: NodePath
# Relative path to the flashlight in the player's hand
@export var flashlight_in_hand_relative_path: String = "Head/Camera3D/Flashlight" # Or the node type where you attach this script

@export var world_env: Node
@export var global_lighting: Node
# Flag to track if the player is within the area
var player_in_area: bool = false

func _ready():
	# Connect the body_entered and body_exited signals
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	
	# Ensure the flashlight in hand is disabled initially
	var flashlight_in_hand = _get_flashlight_in_hand()
	if flashlight_in_hand:
		flashlight_in_hand.set_physics_process(false)
		flashlight_in_hand.set_process(false)
	

func _on_body_entered(body):
	if body.name == "Player":  # Replace with the appropriate player node name/tag
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		# Call the function to handle picking up the flashlight
		_pickup_flashlight()

func _pickup_flashlight():
	# Remove the flashlight from the table
	var flashlight_on_table = get_node_or_null(flashlight_on_table_path)
	if flashlight_on_table:
		flashlight_on_table.queue_free()
	
	# Enable the flashlight in the player's hand
	var flashlight_in_hand = _get_flashlight_in_hand()
	if flashlight_in_hand:
		flashlight_in_hand.set_physics_process(true)
		flashlight_in_hand.set_process(true)
		flashlight_in_hand.visible = true  # If you want it to also appear visually
		flashlight_in_hand.mark_as_picked_up()  # Notify the flashlight it has been picked up
	
	# Print confirmation to the output
	print("Flashlight picked up and enabled!")
	
	if world_env:
		world_env.call("_change_sky")
	
	if global_lighting:
		global_lighting.light_energy = 0.01

# Helper function to get the flashlight in the player's hand
func _get_flashlight_in_hand() -> Node:
	# Replace "Player" with the name of your player node
	var player = get_parent().get_node("Player")
	if player:
		return player.get_node_or_null(flashlight_in_hand_relative_path)
	return null
