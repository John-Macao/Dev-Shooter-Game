extends CharacterBody2D

@onready var main = get_node("/root/Main");
@onready var player = get_node("/root/Main/Player");

var explosion_scene := preload("res://scenes/explosion.tscn")
var item_scene := preload("res://scenes/item.tscn")

signal  hit_player

var alive : bool
var entered : bool
var speed : int = 100
var direction : Vector2
const DROP_CHANCE : float = 0.1

func _ready():
	var screen_rect = get_viewport_rect()
	alive=true; #Enemy alive 
	entered=false
	
	#Pick a direction for the entrance
	var dist = screen_rect.get_center() - position;
	
	#check if need to move horizontally or vertically
	if abs(dist.x) > abs(dist.y):
		#move horizontally (right or left)
		direction.x = dist.x
		direction.y = 0
	else:
		#move vertically
		direction.x = 0
		direction.y = dist.y

func _physics_process(delta):
	if alive:
		$AnimatedSprite2D.animation = "run"
		if entered:
			direction = (player.position - position)
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()
		
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		pass 
		
func die():
	alive= false;
	$AnimatedSprite2D.stop();
	$AnimatedSprite2D.animation = "dead"
	$Area2D/CollisionShape2D.set_deferred("desabled", true)
	if randf() <= DROP_CHANCE:
		drop_item();
	
	var explosion = explosion_scene.instantiate();
	explosion.position = position
	main.add_child(explosion)
	#explosion.process_mode = Node.PROCESS_MODE_ALWAYS
	
	
	
func drop_item():
	var item = item_scene.instantiate();
	item.position = position
	item.item_type = randf_range(0,3);
	main.call_deferred("add_child", item)
	item.add_to_group("items")
	
func _on_entrance_timer_timeout():
	entered = true

func _on_area_2d_body_entered(body):
	hit_player.emit()
