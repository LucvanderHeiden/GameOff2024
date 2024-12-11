extends Area3D

@export var player_object: Node
@export var signal_emitter: Node  # Must reference the signal emitter node

signal trigger_3  # Declare the new signal

var can_execute = false  # Flag to control execution

func _ready():
	# Debugging: Check if signal_emitter is valid
	if signal_emitter == null:
		print("Error: signal_emitter is not set or null.")
		return
	
	# Connect the signal
	var connected = signal_emitter.connect("trigger_2", Callable(self, "_on_trigger_2"))
	if connected:
		print("Signal successfully connected.")
	else:
		print("Failed to connect signal.")
	
	self.body_entered.connect(Callable(self, "_on_body_entered"))

func _on_trigger_2():
	can_execute = true
	print("trigger 2 received. Function can now execute.")

func _on_body_entered(body):
	if can_execute and body == player_object:
		print("trigger 2 received and func executed")
		emit_signal("trigger_3")  # Emit the new signal
		print("trigger 3 sent")
