extends Control

func ready():
	$AnimationPlayer.play("RESET")
	get_tree().paused = false

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func testEsc():
	if Input.is_action_just_pressed("quit") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("quit") and get_tree().paused == true:
		resume()


func _on_resume_pressed():
	resume()


func _on_restart_pressed():
	$AnimationPlayer.stop()  # Stop any currently playing animation
	$AnimationPlayer.play("RESET")  # Play the reset animation to remove the blur
	get_tree().paused = false  # Unpause the game
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()
