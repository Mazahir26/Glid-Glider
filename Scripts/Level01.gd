extends Node2D

export(PackedScene) var enemy = null
export(PackedScene) var Player = null
export(PackedScene) var PowerUp = null
onready var pause_menu = $Pause_Menu


var p
var dead = false
func _ready() -> void:
	$PowerupTimer.wait_time = rand_range(6,20)
	$PowerupTimer.start()
	Data.score = 0
	$Game_OVER.hide()
	move_child($Pause_Menu,get_child_count())
	Data.Is_Paused = true
	if enemy == null :
		return
	if Player == null :
		return
	_Spawn_Player()
	dead = false
	Data.Player_is_dead = false
	
	pass 


func _Spawn_Player() -> void :
	var temp = randi()%Data._Position.size()
	p = Player.instance()
	p.connect("death_Player",self,"on_death")
	Data.Start_pos_Player = temp
	p.position = Data._Position[temp]
	add_child(p)

func _on_Timer_timeout() -> void:
	if dead == false :
		var temp = randi()%Data.enemypos.size()
		var en = enemy.instance()
		en.Set_Speed(Data.EnemySpeed)
		en.position = Data.enemypos[temp]
		add_child(en)
		$Timer.wait_time -= 0.01 
		$Timer.start()
		pass # Replace with function body.
	
func on_death() -> void:
	print("Death")
	dead = true
	Data.Player_is_dead = true
	var timer = Timer.new()
	timer.wait_time = 1
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout",self,"deade")
	timer.start()
	
	

func deade() -> void :
		p.queue_free()
		$Camera2D/UI/Score.hide()
		$Grid.hide()
		$Pause_Menu.hide()
		$AnimationPlayer.play("Game_over")
		if Data.score > Data.Load_Score("Easy","score01") :
			Data.Save_Score("Easy","score03",Data.Load_Score("Easy","score02"))
			Data.Save_Score("Easy","score02",Data.Load_Score("Easy","score01"))
			Data.Save_Score("Easy","score01",Data.score-1)
		elif Data.score > Data.Load_Score("Easy","score02") :
			Data.Save_Score("Easy","score03",Data.Load_Score("Easy","score02"))
			Data.Save_Score("Easy","score02",Data.score-1)
		elif Data.score > Data.Load_Score("Easy","score03") :
			Data.Save_Score("Easy","score03",Data.score-1)
		Data.Save_Score("Money","Total",Data.Load_Score("Money","Total")+Data.score-1)

func updateUI() -> void :
	if Data.Player_is_dead == false :
		$Camera2D/UI/Score.text = "Score : " + str(Data.score)
		$Score_timer.start()
		$Game_OVER/Final_score.text = "Score : " + str(Data.score)
		




func _on_Score_timeout() -> void:
	
	Data.score +=1
	Data.EnemySpeed = Data.score * 0.005
	updateUI()
	pass # Replace with function body.


func _on_Retry_button_down() -> void:
# warning-ignore:return_value_discarded
	if Data.Sound :
		$Click_Sound.play()
	get_tree().reload_current_scene()
	pass # Replace with function body.

func _on_Main_Menu_button_down() -> void:
# warning-ignore:return_value_discarded
	if Data.Sound :
		$Click_Sound.play()
	get_tree().change_scene("res://Scene/Main Screen.tscn")
	pass # Replace with function body.


func _on_PowerupTimer_timeout() -> void:
	var po = PowerUp.instance()
	po.call("Set_pos")
	add_child(po)
	pass # Replace with function body.
