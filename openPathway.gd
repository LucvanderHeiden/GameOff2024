extends Area3D

# Node path to the object you want to remove
@export var object_to_remove_path: NodePath

func _ready():
	# Connect the signal using Callable
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Check if the object_to_remove_path exists
	var object_to_remove = get_node_or_null(object_to_remove_path)
	if object_to_remove:
		object_to_remove.queue_free()
