extends Node

var aux:int =0 #count enemies hit

var wave : int 
var max_enemies:int
var lives: int

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	$GameOver/Button.pressed.connect(new_game)
	
func new_game():
	max_enemies=100;
	wave=1
	lives=3
	$Player.reset()
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	get_tree().call_group("items", "queue_free")
	$Hud/LivesLabel.text = "X " + str(lives)
	$Hud/WaveLabel.text = "WAVE: " + str(wave)
	$Hud/EnemiesLabel.text = "X " + str(max_enemies)
	$GameOver.hide();
	get_tree().paused = true
	$RestartTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemy_spawner_hit_p():
	#aux=aux+1
	print("Enemy hit player: " + str(aux))
	lives -= 1;
	$Hud/LivesLabel.text = "X " + str(lives)
	
	if lives <= 0:
		get_tree().paused = true
		$GameOver/WavesSurvivedLabel.text = "Waves Survived: " + str(wave - 1)
		$GameOver.show()
		
		
func _on_restart_timer_timeout():
	get_tree().paused = false
