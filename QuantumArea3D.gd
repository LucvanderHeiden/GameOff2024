extends Area3D

# Signal to inform when the area is entered
signal area_activated

func _ready():
	# Connect the body_entered signal
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":  # Adjust this based on your player node's name
		emit_signal("area_activated")  # Emit signal to notify other scripts
		print("Player entered quantum area. Signal emitted.")
