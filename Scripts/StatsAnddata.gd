extends Node

var enemypos = [Vector2(374,-200),Vector2(472,-200),Vector2(570,-200),Vector2(668,-200),
				Vector2(1300,100),Vector2(1300,198),Vector2(1300,296),Vector2(1300,394),
				Vector2(-300,100),Vector2(-300,198),Vector2(-300,296),Vector2(-300,394),
				Vector2(374,750),Vector2(472,750),Vector2(570,750),Vector2(668,750)]
#IF difficulty == easy
#var enemypos = [Vector2(374,-200),Vector2(472,-200),Vector2(570,-200),Vector2(668,-200),
#				Vector2(1300,100),Vector2(1300,198),Vector2(1300,296),Vector2(1300,394)]
var _Position = [Vector2(374,100),Vector2(472,100),Vector2(570,100),Vector2(668,100),
				Vector2(374,198),Vector2(472,198),Vector2(570,198),Vector2(668,198),
				Vector2(374,296),Vector2(472,296),Vector2(570,296),Vector2(668,296),
				Vector2(374,394),Vector2(472,394),Vector2(570,394),Vector2(668,394)]
var performance = true

var Start_pos_Player 
var PlayerColor = Color(1,0.23,0.23,1)
var Player_is_dead 
var EnemySpeed = 2
var Is_Paused
var score = 0
var Music = true
var Sound = true

var Save_Path ="res://Data.cfg"
var Config = ConfigFile.new()
var load_response = Config.load(Save_Path)

func Save_Score(section,Name,value) -> void:
	Config.set_value(section,Name,value)
	Config.save(Save_Path)

func Load_Score(section,Name) -> float:
	return(Config.get_value(section,Name,0))

func Load_Store(Selction,Name) -> String :
	return(Config.get_value(Selction,Name,"Locked"))
	
var Music_player : AudioStreamPlayer = null
func Set_Music(player : AudioStreamPlayer) :
	if Music_player == null :
		Music_player = player
		add_child(Music_player)
var musicres = load("res://Music/game.music.wav")

func Play_Music() :
	if Music_player == null :
		return
	if Music == false :
		return
	Music_player.stream = musicres
	Music_player.play()

func stop_music() :
	if Music_player == null :
		return
	Music_player.stop()
