extends Area3D

@export var player_object: Node
@export var mesh_instance_path: NodePath
@export var collision_shape_path: NodePath

signal trigger_5  # Make sure the signal is declared

func _ready():
	self.body_entered.connect(Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body == player_object:
		emit_signal("trigger_5")  # Emit signal to notify other scripts
		print("trigger 5 sent")
		
		var mesh_instance = get_node_or_null(mesh_instance_path)
		var collision_shape = get_node_or_null(collision_shape_path)
	
		mesh_instance.visible = true
		collision_shape.set_deferred("disabled", false)
