extends Area3D

#@onready var credits_scene = preload("res://path_to_your_scene.tscn")

@export var player_object: Node
@export var signal_emitter: Node  # Must reference the signal emitter node

@export var moving_wall_1: Node
@export var mesh_instance_path1: NodePath
@export var collision_shape_path1: NodePath

@export var moving_wall_2: Node
@export var mesh_instance_path2: NodePath
@export var collision_shape_path2: NodePath

@export var moving_wall_3: Node
@export var moving_wall_4: Node


@export var notifier_end_1: VisibleOnScreenNotifier3D
@export var notifier_end_2: VisibleOnScreenNotifier3D

@export var ambience: Node
@export var music: Node
@export var hedge_audio: Node
var fade_out_time = 3.0  # Duration of fade-out in seconds
var fade_out_elapsed = 0.0
var is_fading_out = false

@export var animation: Node

@export var speed: float = 0.3  # Movement speed in units per second
@export var speed2: float = 0.1  # Movement speed in units per second
var direction1: Vector3 = Vector3(-1, 0, 0)  # Direction of movement (normalized)
var direction2: Vector3 = Vector3(1, 0, 0)  # Direction of movement (normalized)
var direction3: Vector3 = Vector3(0, 0, 1)  # Direction of movement (normalized)
var direction4: Vector3 = Vector3(0, 0, -1)  # Direction of movement (normalized)

var can_execute = false  # Flag to control execution
var player_in_area: bool = false

var wall_1_set: bool = false
var wall_2_set: bool = false

func _ready():
	# Debugging: Check if signal_emitter is valid
	if signal_emitter == null:
		print("Error: signal_emitter is not set or null.")
		return
	
	# Connect the signal
	var connected = signal_emitter.connect("trigger_5", Callable(self, "_on_trigger_5"))
	if connected:
		print("Signal successfully connected.")
	else:
		print("Failed to connect signal.")
	
	self.body_entered.connect(Callable(self, "_on_body_entered"))
	self.body_exited.connect(Callable(self, "_on_body_exited"))
	
func _on_body_entered(body):
	if can_execute and body == player_object: # Replace with the appropriate player node name/tag
		player_in_area = true
		print("player in area")

func _on_body_exited(body):
	if can_execute and body == player_object:
		player_in_area = false
		print("player out of area")

func _on_trigger_5():
	can_execute = true
	print("trigger 5 received. Function can now execute.")

func _process(delta):
	if player_in_area and not notifier_end_1.is_on_screen():
		var mesh_instance1 = get_node_or_null(mesh_instance_path1)
		var collision_shape1 = get_node_or_null(collision_shape_path1)
		
		mesh_instance1.visible = true
		collision_shape1.set_deferred("disabled", false)
		wall_1_set = true
	
	if player_in_area and not notifier_end_2.is_on_screen():
		var mesh_instance2 = get_node_or_null(mesh_instance_path2)
		var collision_shape2 = get_node_or_null(collision_shape_path2)
		
		mesh_instance2.visible = true
		collision_shape2.set_deferred("disabled", false)
		wall_2_set = true
	
	if wall_1_set and wall_2_set:
		await get_tree().create_timer(5.0).timeout
		moving_wall_1.position += direction1.normalized() * speed * delta
		moving_wall_2.position += direction2.normalized() * speed * delta
		moving_wall_3.position += direction3.normalized() * speed2 * delta
		moving_wall_4.position += direction4.normalized() * speed2 * delta
		print("5 seconds passed")
		if not hedge_audio.playing:
			hedge_audio.play()
		
		await get_tree().create_timer(15.0).timeout
		animation.play("new_animation")
		await get_tree().create_timer(4.0).timeout
		is_fading_out = true
		
		
	if is_fading_out:
		fade_out_elapsed += delta
		var fade_ratio = fade_out_elapsed / fade_out_time
		hedge_audio.volume_db = lerp(0, -80, fade_ratio)  # From 0dB to -80dB (silent)
		ambience.volume_db = lerp(0, -80, fade_ratio)  # From 0dB to -80dB (silent)
		music.volume_db = lerp(0, -80, fade_ratio)  # From 0dB to -80dB (silent)
		
		if fade_out_elapsed >= fade_out_time:
			is_fading_out = false
			hedge_audio.stop()
			ambience.stop()
			music.stop()
			get_tree().change_scene_to_file("res://credits.tscn")

