extends Control

onready var camera = $Camera2D
onready var anim = $AnimationPlayer 
var TotalScore
var store = false
onready var Level01 = load("res://Scene/temp.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Data.stop_music()
	Data.Set_Music(AudioStreamPlayer.new())
	store = false
	anim.play("Start")
	Data.Music = Data.Load_Score("Audio","Music")
	Data.Sound = Data.Load_Score("Audio","Sound")
	TotalScore = Data.Load_Score("Money","Total")
	var temp02 = Data.Load_Score("Easy","score01")
	if temp02 == null :
		Data.Save_Score("Easy","score01",0)
	else :
		$HighScore/High_score01/text.text = str(temp02)
	temp02 = Data.Load_Score("Easy","score02")
	if temp02 == null :
		Data.Save_Score("Easy","score02",0)
	else :
		$HighScore/High_score02/text.text = str(temp02)
	temp02 = Data.Load_Score("Easy","score03")
	if temp02 == null :
		Data.Save_Score("Easy","score03",0)
	else :
		$HighScore/High_score03/text.text = str(temp02)
	
	pass # Replace with function body.

func _Play_Music() -> void  :
	if Data.Sound :
		$Audio.play()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_option_button_down() -> void:
	anim.play("Start-Options")
	_Play_Music()
	
	pass # Replace with function body.


func _on_Soun_buton_button_down() -> void:
	$Music/Music/Music_Button.pressed = Data.Music
	$Music/Sound/Sound_Button.pressed = Data.Sound
	anim.play("Options-Music")
	pass # Replace with function body.


func _on_Back_music_to_options_button_down() -> void:
	anim.play("Music-Options")
	Data.Save_Score("Audio","Music",Data.Music)
	Data.Save_Score("Audio","Sound",Data.Sound)
	_Play_Music()
	pass # Replace with function body.


func _on_Back_options_to_start_button_down() -> void:
	anim.play("Option-Start")
	_Play_Music()
	pass # Replace with function body.


func _on_option_to_About_button_down() -> void:
	anim.play("Option-About")
	_Play_Music()
	pass # Replace with function body.


func _on_aboutoptions_button_down() -> void:
	anim.play("About-Options")
	_Play_Music()
	pass # Replace with function body.


func _on_Start_button_down() -> void:
	_Play_Music()
	var _temp1 = get_tree().change_scene_to(Level01)
	_temp1 = 10
	var temp004 = Data.Load_Score("Items","Selected")
	Data.PlayerColor = $Store/Store/Items.get_child(temp004).modulate
	Data.Play_Music()
	pass # Replace with function body.


func _on_Exit_button_down() -> void:
	_Play_Music()
	get_tree().quit()
	pass # Replace with function body.


func _on_HighScore_button_down() -> void:
	_Play_Music()
	anim.play("Start-Highscore")
	$HighScore/High_score01/text.text ="1. " +str( Data.Load_Score("Easy","score01"))
	$HighScore/High_score02/text.text ="2. " +str( Data.Load_Score("Easy","score02"))
	$HighScore/High_score03/text.text ="3. " +str( Data.Load_Score("Easy","score03"))
	
	
	pass # Replace with function body.


func _on_HighScorStart_button_down() -> void:
	_Play_Music()
	anim.play("Highscore-start")
	pass # Replace with function body.






func _on_Shop_button_down() -> void:
	_Play_Music()
	anim.play("Start-Store")
	store = true
	_store()
	pass # Replace with function body.


func _on_Store_Start_button_down() -> void:
	_Play_Music()
	anim.play("Store-Start")
	
	Data.Save_Score("Items","Selected",Equiped)
	var temp003 = $Store/Store/Items.get_children()
	temp003[selected].position = $Store/Store/left.position
	Data.PlayerColor = temp003[Equiped].modulate
	store = false
	pass # Replace with function body.

#Store code
var Price = [0,100,400,800,1200,1500,2000,2200,2500,3000]
var Unlocked_
var selected
var Equiped
var count
var Items 
var old
func _store() -> void :
	selected = Data.Load_Score("Items","Selected")
	Items = $Store/Store/Items
	Items.get_child(selected).position = $Store/Store/center.position
	count = Items.get_child_count()-1
	var temp002 = Items.get_child(selected).name
	Data.Save_Score("Items",temp002,"Unlocked")
	Update_Store_Ui()
	pass
func _input(event: InputEvent) -> void:
	if store == true and event.is_action_pressed("ui_right") :
		Update_Right()
	if store == true and event.is_action_pressed("ui_left") :
		Update_Left()
	if event is InputEventKey :
		pass

func Update_Right() -> void :
	$Store/Store/Locked.visible = false
	_Play_Music()
	var Oldobj = Items.get_child(selected)
	var Newobj
	if selected == count :
		Newobj = Items.get_child(0)
		selected = 0
	else :
		Newobj = Items.get_child(selected+1)
		selected += 1
	$Tween.interpolate_property(Oldobj,"position",$Store/Store/center.position,$Store/Store/left.position,0.2,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
	$Tween.interpolate_property(Newobj,"position",$Store/Store/right.position,$Store/Store/center.position,0.2,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
	$Tween.start()
	Update_Store_Ui()
	
func Update_Left() -> void :
	$Store/Store/Locked.visible = false
	_Play_Music()
	var Oldobj = Items.get_child(selected)
	var Newobj
	if selected == 0 :
		Newobj = Items.get_child(count)
		selected = count
	else :
		Newobj = Items.get_child(selected-1)
		selected -= 1
	$Tween.interpolate_property(Oldobj,"position",$Store/Store/center.position,$Store/Store/right.position,0.2,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
	$Tween.interpolate_property(Newobj,"position",$Store/Store/left.position,$Store/Store/center.position,0.2,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
	$Tween.start()
	Update_Store_Ui()
	pass
	
func Update_Store_Ui() -> void :
	var temp002 = Items.get_child(selected).name
	Unlocked_ = Data.Load_Store("Items",temp002)
	$"Store/Store/Total Score".text = "Total Score : " + str(TotalScore)
	Data.Save_Score("Money","Total",TotalScore)
	if Unlocked_ == "Locked" :
		$Store/Store/Locked.show()
		$Store/Store/Buy.disabled = false
		$Store/Store/Buy.text = "Buy"
		$Store/Store/Price.text = "$" + str(Price[selected])
	elif Unlocked_ == "Unlocked" :
		Equiped = selected
		$Store/Store/Buy.text = "Selected"
		$Store/Store/Buy.disabled = true
		$Store/Store/Price.text = " "
		$Store/Store/Locked.hide()
	pass


func _on_Buy_button_down() -> void:
	_Play_Music()
	if TotalScore >= Price[selected] :
		if $Store/Store/Locked.visible :
			$Store/Store/Locked/LockedImg.texture = load("res://Experimental_Assets/unlocked.png")
			yield(get_tree().create_timer(0.5),"timeout")
			$Store/Store/Locked.visible = false
			$Store/Store/Locked/LockedImg.texture = load("res://Experimental_Assets/locked.png")
		TotalScore -= Price[selected]
		var temp002 = Items.get_child(selected).name
		Data.Save_Score("Items",temp002,"Unlocked")
	else :
		anim.play("Store-Notifaction")
	Update_Store_Ui()
	pass # Replace with function bod









func _on_Sound_Button_toggled(button_pressed: bool) -> void:
	_Play_Music()
	if button_pressed :
		$Music/Sound/Sound_Button.icon = load("res://Assets/CheckBox_True1.png")
		
	else :
		$Music/Sound/Sound_Button.icon = load("res://Assets/CheckBox_false1.png")
	Data.Sound = button_pressed
	pass # Replace with function body.

#	Data.Save_Score("Sound","Music",value)
func _on_Music_Button_toggled(button_pressed: bool) -> void:
	_Play_Music()
	if button_pressed :
		$Music/Music/Music_Button.icon = load("res://Assets/CheckBox_True1.png")
	else :
		$Music/Music/Music_Button.icon = load("res://Assets/CheckBox_false1.png")
	Data.Music = button_pressed
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Start" :
		$Audio.volume_db = 5
	pass # Replace with function body.




# changing icons when hoverded!!!
#dont know if i want keep it.

#func _on_Start_mouse_entered() -> void:
#	$Start/Start_Button/Start.icon = load("res://Assets/Black_icons/forward.png")
#	pass # Replace with function body.
#
#
#func _on_Start_mouse_exited() -> void:
#	$Start/Start_Button/Start.icon = load("res://Assets/White_icons/forward.png")
#	pass # Replace with function body.
#
#
#func _on_option_mouse_entered() -> void:
#	$Start/Options_Button/option.icon = load("res://Assets/Black_icons/barsHorizontal.png")
#	pass # Replace with function body.
#
#
#func _on_option_mouse_exited() -> void:
#	$Start/Options_Button/option.icon = load("res://Assets/White_icons/barsHorizontal.png")
#	pass # Replace with function body.
#
#
#func _on_HighScore_mouse_entered() -> void:
#	$Start/Highscore/HighScore.icon = load("res://Assets/Black_icons/trophy.png")
#	pass # Replace with function body.
#
#
#func _on_HighScore_mouse_exited() -> void:
#	$Start/Highscore/HighScore.icon = load("res://Assets/White_icons/trophy.png")
#	pass # Replace with function body.
#
#
#func _on_Shop_mouse_entered() -> void:
#	$Start/Shop/Shop.icon = load("res://Assets/Black_icons/cart.png")
#	pass # Replace with function body.
#
#
#func _on_Shop_mouse_exited() -> void:
#	$Start/Shop/Shop.icon = load("res://Assets/White_icons/cart.png")
#	pass # Replace with function body.
#
#
#func _on_Exit_mouse_entered() -> void:
#	$Start/Exit_button/Exit.icon = load("res://Assets/Black_icons/exitRight.png")
#	pass # Replace with function body.
#
#
#func _on_Exit_mouse_exited() -> void:
#	$Start/Exit_button/Exit.icon = load("res://Assets/White_icons/exitRight.png")
#	pass # Replace with function body.
#
#
#func _on_Soun_buton_mouse_entered() -> void:
#	$Options/Sound/Soun_buton.icon = load("res://Assets/Black_icons/musicOn.png")
#	pass # Replace with function body.
#
#
#func _on_Soun_buton_mouse_exited() -> void:
#	$Options/Sound/Soun_buton.icon = load("res://Assets/White_icons/musicOn.png")
#	pass # Replace with function body.


func _on_optiontoinstruction_button_down() -> void:
	anim.play("Optionstoinfo")
	_Play_Music()
	pass # Replace with function body.


func _on_Infotooptions_button_down() -> void:
	anim.play("info-options")
	_Play_Music()
	pass # Replace with function body.


func _on_TextEdit_meta_clicked(meta) -> void:
	var err = OS.shell_open(meta)
	if (err == OK):
		print("Opened link '%s' successfully!" % meta)
	else:
		print("Failed opening the link '%s'!" % meta)
	pass # Replace with function body.
