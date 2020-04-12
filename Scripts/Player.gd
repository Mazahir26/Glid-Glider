extends Node2D

export var Speed : int = 98
signal death_Player
var pos = 5
var dead = false
			   
var Shield = false
onready var tween = $Tween


func move() :
	if Input.is_action_just_pressed("ui_right") :
		Sound()
		if pos == 3 or pos == 7 or pos == 11 or pos == 15:
			tween.interpolate_property(self,"position",Data._Position[pos],Data._Position[pos-3],0.1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			pos -= 3
			tween.start()
		else :
			tween.interpolate_property(self,"position",Data._Position[pos],Data._Position[pos+1],0.1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			pos += 1
			tween.start()
	if Input.is_action_just_pressed("ui_left") :
		Sound()
		if pos == 0 or pos == 4 or pos == 8 or pos == 12:
			tween.interpolate_property(self,"position",Data._Position[pos],Data._Position[pos+3],0.1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			pos += 3
			tween.start()
		else :
			tween.interpolate_property(self,"position",Data._Position[pos],Data._Position[pos-1],0.1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			pos -= 1
			tween.start()
	if Input.is_action_just_pressed("ui_up") :
		Sound()
		if pos == 0 or pos == 1 or pos == 2 or pos == 3:
			tween.interpolate_property(self,"position",Data._Position[pos],Data._Position[pos+12],0.1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			pos += 12
			tween.start()
		else :
			tween.interpolate_property(self,"position",Data._Position[pos],Data._Position[pos-4],0.1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			pos -= 4
			tween.start()
	if Input.is_action_just_pressed("ui_down") :
		Sound()
		if pos == 12 or pos == 13 or pos == 14 or pos == 15:
			tween.interpolate_property(self,"position",Data._Position[pos],Data._Position[pos-12],0.1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			pos -= 12
			tween.start()
		else :
			tween.interpolate_property(self,"position",Data._Position[pos],Data._Position[pos+4],0.1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			pos += 4
			tween.start()



func Sound() :
	if Data.Sound :
		$Sound.play()
func _ready() -> void:
	tempcol = Data.PlayerColor
	$Player.modulate = Data.PlayerColor
	pos = Data.Start_pos_Player
	dead = false
	Data.Player_is_dead = false
	$Shield.visible = false
	pass


# warning-ignore:unused_argument
func _input(event: InputEvent) -> void:
	if dead  == false :
		move()
	
	
	pass

var tempcol : Color
func _on_E_dect_area_entered(area: Area2D) -> void:
	if area.name == "P_dect" :
		if Shield == true :
			Data.PlayerColor = tempcol
			$Player.modulate = Data.PlayerColor
			$Shield.visible = false
			Shield = false
			$Particles2D2.emitting = true
			return
		dead = true
		$Sound.stream = load("res://Music/explosion3.ogg")
		Sound()
		$Tween.interpolate_property($Player,"modulate",$Player.modulate,Color(1,1,1,0),0.1,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
		$Tween.start()
		$Particles2D.emitting = true
		emit_signal("death_Player")
	elif area.name == "Powerup" :
		var type = area.get_parent().call("get_type")
		if type == "Shield" :
			$Player.modulate = Color.white
			Data.PlayerColor = Color.white
			Shield = true
			$Shield.visible = true
		if type == "Scoreup" :
			Data.score += 10
			pass
		



func _on_Dash_effect_timeout() -> void:
	var Dash = preload("res://Scene/Dash_effect.tscn").instance()
	get_parent().add_child(Dash)
	Dash.texture = $Player.texture
	Dash.position = position
	Dash.scale = $Player.scale
	
	pass # Replace with function body.
