extends Node2D
export(PackedScene) var Main_menu = null


func _on_EXIT_button_down() -> void:
	if Data.Sound :
		$Click_Sound.play()
	get_tree().quit()
	print("Quit")
	pass # Replace with function body.


func _on_Main_menu_pressed() -> void:
	if Data.Sound :
		$Click_Sound.play()
# warning-ignore:return_value_discarded
	Data.stop_music()
	get_tree().change_scene("res://Scene/Main Screen.tscn")
	get_tree().paused = Data.Is_Paused
	Data.Is_Paused = not Data.Is_Paused
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and Data.Player_is_dead == false:
		get_tree().paused = Data.Is_Paused
		Data.Is_Paused = not Data.Is_Paused
		if Data.Is_Paused == false :
			$AnimationPlayer.play("Pause-Start")
		elif Data.Is_Paused == true :
			$AnimationPlayer.play("Pause-End")


func _on_Resume_button_down() -> void:
	if Data.Sound :
		$Click_Sound.play()
	get_tree().paused = Data.Is_Paused
	Data.Is_Paused = not Data.Is_Paused
	if Data.Is_Paused == false :
		$AnimationPlayer.play("Pause-Start")
	elif Data.Is_Paused == true :
		$AnimationPlayer.play("Pause-End")


