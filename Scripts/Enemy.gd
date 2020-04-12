extends Node2D

var speed : float = 2
var Startpos =Vector2.ZERO
var endpos = Vector2.ZERO
var Colors = [Color(0.90,0.99,0.31), Color(0.41,0.99,0.31),Color(0.60,0.31,0.99),Color(0.99,0.21,0.21)]
func _ready() -> void:
	if Data.Sound :
		$AudioStreamPlayer2D.play()
	var col = randi() % Colors.size()
	$Enemy.modulate = Colors[col]
	if !Data.performance :
		$Particles2D.queue_free()
	Startpos = self.position
	if self.position.x == 1300 :
		endpos.x = -250
		endpos.y = self.position.y
		self.rotation_degrees = -90
	elif self.position.y == -200 :
		endpos.y = 750  
		endpos.x = self.global_position.x
		self.rotation_degrees = 180
	elif self.position.y == 750 :
		endpos.y = -250  
		endpos.x = self.global_position.x
		self.rotation_degrees = 0
	elif self.position.x == -300 :
		endpos.x = 1300
		endpos.y = self.position.y
		self.rotation_degrees = 90
		
	$Tween.interpolate_property(self,"position",Startpos,endpos,speed,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
	$Tween.start()
	pass 



func _on_VisibilityEnabler2D_screen_exited() -> void:
	queue_free()
	


func _on_P_dect_area_entered(area: Area2D) -> void:
	if area.name == "E_dect" :
		queue_free()

func Set_Speed(s :  float) :
	speed -= s
