extends Area3D

@export var player_object: Node
@export var object_to_remove_path: NodePath
@export var signal_emitter: Node

var can_execute = false  # Flag to control execution

func _ready():
	# Get the signal emitter node and connect its signal
	
	signal_emitter.connect("trigger_3", Callable(self, "_on_trigger_3"))
	
	# Connect the `body_entered` signal to the function
	self.body_entered.connect(Callable(self, "_on_body_entered"))

func _on_trigger_3():
	can_execute = true  # Set the flag when the signal is received

func _on_body_entered(body):
	# Only proceed if the flag is set and the body is the player
	if can_execute and body == player_object:
		var object_to_remove = get_node_or_null(object_to_remove_path)
		if object_to_remove:
			object_to_remove.queue_free()
	else:
		print("Last condition not met; function did not execute.")
