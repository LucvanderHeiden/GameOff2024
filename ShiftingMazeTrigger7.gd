extends Area3D

@export var player_object: Node
@export var signal_emitter: Node  # Must reference the signal emitter node

@export var mesh_instance_path: NodePath
@export var collision_shape_path: NodePath

signal trigger_7  # Declare the new signal

var can_execute = false  # Flag to control execution

func _ready():
	# Debugging: Check if signal_emitter is valid
	if signal_emitter == null:
		print("Error: signal_emitter is not set or null.")
		return
	
	# Connect the signal
	var connected = signal_emitter.connect("trigger_6", Callable(self, "_on_trigger_6"))
	if connected:
		print("Signal successfully connected.")
	else:
		print("Failed to connect signal.")
	
	self.body_entered.connect(Callable(self, "_on_body_entered"))

func _on_trigger_6():
	can_execute = true
	print("trigger 6 received. Function can now execute.")

func _on_body_entered(body):
	if can_execute and body == player_object:
		print("trigger 6 received and func executed")
		emit_signal("trigger_7")  # Emit the new signal
		print("trigger 7 sent")
		
		var mesh_instance = get_node_or_null(mesh_instance_path)
		var collision_shape = get_node_or_null(collision_shape_path)
	
		mesh_instance.visible = true
		collision_shape.set_deferred("disabled", false)
