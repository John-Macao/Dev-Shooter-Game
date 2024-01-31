extends CharacterBody2D

@onready var player = get_node("/root/Main/Player");
signal  hit_player

var alive : bool
var entered : bool
var speed : int = 100
var direction : Vector2

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
	
func _on_entrance_timer_timeout():
	entered = true

func _on_area_2d_body_entered(body):
	hit_player.emit()
