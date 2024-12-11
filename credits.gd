extends Node2D

@export var credits_anim: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	credits_anim.play("credits_anim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	await get_tree().create_timer(60.0).timeout
	get_tree().quit()
	
func _physics_process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

