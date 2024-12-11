extends Area3D

@export var player_object: Node
# Node path to the object you want to remove
@export var object_to_remove_path: NodePath

@export var mesh_instance_path: NodePath
@export var collision_shape_path: NodePath

func _ready():
	# Connect the signal using Callable
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body == player_object:
		var mesh_instance = get_node_or_null(mesh_instance_path)
		var collision_shape = get_node_or_null(collision_shape_path)
		# Check if the object_to_remove_path exists
		var object_to_remove = get_node_or_null(object_to_remove_path)
		if object_to_remove:
			object_to_remove.queue_free()
	
		print("Did function")
		mesh_instance.visible = true  # Makes the MeshInstance3D visible
		if collision_shape:
			print("Enabling CollisionShape3D.")
			collision_shape.set_deferred("disabled", false)
		else:
			print("Error: CollisionShape3D not found at path:", collision_shape_path)
