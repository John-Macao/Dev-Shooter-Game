extends Node2D

@onready var main = get_node("/root/Main");

var goblin_scene := preload("res://scenes/goblin.tscn")
var spawn_points := [] 

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)
	
func _on_timer_timeout():
	#pick random spawn point
	var spawn  = spawn_points[randi() % spawn_points.size()]
	
	#spawn enemy
	var goblin = goblin_scene.instantiate()
	goblin.position = spawn.position
	main.add_child(goblin)
	
	
