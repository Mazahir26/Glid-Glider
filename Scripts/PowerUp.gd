extends Node2D


var classtype = ["Shield","Scoreup"]
var type
var randd = RandomNumberGenerator.new()
func Set_pos() :
	var temp = randi()%Data._Position.size()
	self.position = Data._Position[temp]
func _ready() -> void:
	randd.randomize()
	var tem = randd.randi_range(0,1)
	type = classtype[tem]
	if type == "Shield" :
		$Sprite.texture = load("res://Experimental_Assets/shield_silver.png")
		$Sprite.modulate = Color(1,1,1)
	elif type == "Scoreup" :
		$Sprite.texture = load("res://Experimental_Assets/star.png")
		$Sprite.modulate = Color(0.90,1,0.3)

	pass 

func _process(_delta: float) -> void:
	if Data.Player_is_dead :
		self.queue_free()

func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.name == "E_dect" :
		queue_free()
	pass # Replace with function body.


func _on_Self_Destruct_timeout() -> void:
	queue_free()
	pass # Replace with function body.

func get_type() :
	return type
