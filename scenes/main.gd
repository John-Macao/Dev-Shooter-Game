extends Node

var aux:int =0 #count enemies hit

var max_enemies:int

# Called when the node enters the scene tree for the first time.
func _ready():
	max_enemies=20;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemy_spawner_hit_p():
	aux=aux+1
	print("Enemy hit player: " + str(aux))
