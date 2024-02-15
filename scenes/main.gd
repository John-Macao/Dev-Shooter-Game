extends Node

var aux:int =0 #count enemies hit

var wave : int 
var max_enemies:int
var lives: int

# Called when the node enters the scene tree for the first time.
func _ready():
	max_enemies=100;
	wave=1
	
	lives=3
	$Hud/LivesLabel.text = "X " + str(lives)
	$Hud/WaveLabel.text = "WAVE: " + str(wave)
	$Hud/EnemiesLabel.text = "X " + str(max_enemies)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemy_spawner_hit_p():
	#aux=aux+1
	print("Enemy hit player: " + str(aux))
	#lives -= 1;
	#$Hud/LivesLabel.text = "X " + str(lives)
