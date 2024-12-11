extends Area3D

@export var player_object: Node
@export var object_to_remove_path: NodePath
@export var mesh_instance_path: NodePath
@export var collision_shape_path: NodePath

signal trigger_2  # Make sure the signal is declared

func _ready():
	self.body_entered.connect(Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body == player_object:
		emit_signal("trigger_2")  # Emit signal to notify other scripts
		print("trigger 2 sent")
		
		var mesh_instance = get_node_or_null(mesh_instance_path)
		var collision_shape = get_node_or_null(collision_shape_path)
		var object_to_remove = get_node_or_null(object_to_remove_path)
		if object_to_remove:
			object_to_remove.queue_free()
	
		mesh_instance.visible = true
		collision_shape.set_deferred("disabled", false)
