extends Sprite


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Data.Player_is_dead == false :
		var Start = Data.PlayerColor - Color(0,0,0,0.3)
		var End = Data.PlayerColor - Color(0,0,0,1)
		$Tween.interpolate_property(self,"modulate",Start,End,0.3,Tween.TRANS_SINE,Tween.EASE_OUT)
		$Tween.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Data.Player_is_dead == true :
		queue_free()
	pass


func _on_Tween_tween_all_completed() -> void:
	queue_free()
	pass # Replace with function body.
