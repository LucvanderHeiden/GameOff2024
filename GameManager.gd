extends Node3D

@export var quantum_sign: Node3D  # The quantum object to move
@export var quantum_sign_notifier: VisibleOnScreenNotifier3D  # The notifier for the quantum object

# Notifiers for the different spots (Drag them into the editor)
@export var notifier_1: VisibleOnScreenNotifier3D  
@export var notifier_2: VisibleOnScreenNotifier3D  
@export var notifier_3: VisibleOnScreenNotifier3D  
@export var notifier_4: VisibleOnScreenNotifier3D  

@export var quantum_rock_1: Node3D
@export var notifier_rock_1: VisibleOnScreenNotifier3D
@export var notifier_rock_1_pos: VisibleOnScreenNotifier3D
@export var notifier_rock_1_pos2: VisibleOnScreenNotifier3D
@export var notifier_rock_1_pos3: VisibleOnScreenNotifier3D
@export var notifier_rock_1_pos4: VisibleOnScreenNotifier3D
@export var notifier_rock_1_pos5: VisibleOnScreenNotifier3D
@export var notifier_rock_1_pos6: VisibleOnScreenNotifier3D

@export var quantum_rock_2: Node3D
@export var notifier_rock_2: VisibleOnScreenNotifier3D
@export var notifier_rock_2_pos: VisibleOnScreenNotifier3D
@export var notifier_rock_2_pos2: VisibleOnScreenNotifier3D
@export var notifier_rock_2_pos3: VisibleOnScreenNotifier3D
@export var notifier_rock_2_pos4: VisibleOnScreenNotifier3D
@export var notifier_rock_2_pos5: VisibleOnScreenNotifier3D

@export var quantum_rock_3: Node3D
@export var notifier_rock_3: VisibleOnScreenNotifier3D
@export var notifier_rock_3_pos: VisibleOnScreenNotifier3D
@export var notifier_rock_3_pos2: VisibleOnScreenNotifier3D
@export var notifier_rock_3_pos3: VisibleOnScreenNotifier3D
@export var notifier_rock_3_pos4: VisibleOnScreenNotifier3D

@export var quantum_rock_4: Node3D
@export var notifier_rock_4: VisibleOnScreenNotifier3D
@export var notifier_rock_4_pos: VisibleOnScreenNotifier3D
@export var notifier_rock_4_pos2: VisibleOnScreenNotifier3D
@export var notifier_rock_4_pos3: VisibleOnScreenNotifier3D

@export var quantum_rock_5: Node3D
@export var notifier_rock_5: VisibleOnScreenNotifier3D
@export var notifier_rock_5_pos: VisibleOnScreenNotifier3D
@export var notifier_rock_5_pos2: VisibleOnScreenNotifier3D

@export var quantum_rock_6: Node3D
@export var notifier_rock_6: VisibleOnScreenNotifier3D
@export var notifier_rock_6_pos: VisibleOnScreenNotifier3D
@export var notifier_rock_6_pos2: VisibleOnScreenNotifier3D
@export var notifier_rock_6_pos3: VisibleOnScreenNotifier3D

# Boolean to track area activation
@export var area: Area3D
var quantum_area_active: bool = false

func _ready():
	if area:
		area.area_activated.connect(self._on_quantum_area_activated)  # Ensure the method is connected properly
	else:
		print("QuantumArea not found!")


func _process(delta):
	if get_tree().paused == false:
		print("test its not paused")
	if quantum_area_active:
		# Check and move the quantum sign if it's off-screen
		if not quantum_sign_notifier.is_on_screen():
			move_quantum_object(quantum_sign, [notifier_1, notifier_2, notifier_3, notifier_4])
		
		# Check and move the quantum rock if it's off-screen
		if not notifier_rock_1.is_on_screen():
			move_quantum_object(quantum_rock_1, [notifier_rock_1_pos, notifier_rock_1_pos2, notifier_rock_1_pos3, notifier_rock_1_pos4, notifier_rock_1_pos5, notifier_rock_1_pos6])
		
		if not notifier_rock_2.is_on_screen():
			move_quantum_object(quantum_rock_2, [notifier_rock_2_pos, notifier_rock_2_pos2, notifier_rock_2_pos3, notifier_rock_2_pos4, notifier_rock_2_pos5])
		
		if not notifier_rock_3.is_on_screen():
			move_quantum_object(quantum_rock_3, [notifier_rock_3_pos, notifier_rock_3_pos2, notifier_rock_3_pos3, notifier_rock_3_pos4])
		
		if not notifier_rock_4.is_on_screen():
			move_quantum_object(quantum_rock_4, [notifier_rock_4_pos, notifier_rock_4_pos2, notifier_rock_4_pos3])
		
		if not notifier_rock_5.is_on_screen():
			move_quantum_object(quantum_rock_5, [notifier_rock_5_pos, notifier_rock_5_pos2])
		
		if not notifier_rock_6.is_on_screen():
			move_quantum_object(quantum_rock_6, [notifier_rock_6_pos, notifier_rock_6_pos2, notifier_rock_6_pos3])

# Signal handler for area activation
func _on_quantum_area_activated():
	if not quantum_area_active:
		quantum_area_active = true
		print("Quantum area activated! Quantum logic will now run.")


# Function to move a quantum object to a random position from available notifiers
func move_quantum_object(object: Node3D, notifiers: Array):
	var available_notifiers = []
	for notifier in notifiers:
		if not notifier.is_on_screen():
			available_notifiers.append(notifier)
	
	if available_notifiers.size() > 0:
		var random_spot = available_notifiers[randi() % available_notifiers.size()]
		object.position = random_spot.position
		object.rotation_degrees = random_spot.rotation_degrees
		print("Moved object to: ", random_spot.position, " with rotation: ", random_spot.rotation_degrees)
	else:
		print("No available spots for the object!")


