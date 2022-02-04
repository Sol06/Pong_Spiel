extends KinematicBody2D

var initial_ball_speed = 300
var speed_commulator = 50
var ball_speed = initial_ball_speed

var hitcounter = 0
var max_hitcounter = 15
var direction = Vector2()


func _ready():
	randomize()
	set_start_direction()
	
func set_start_direction():
	var random_x = 0
	
	if randi()%10 < 5:
		random_x = 1
	else:
		random_x = -1
		
	direction = Vector2(random_x, rand_range(-1, 1))
	direction = direction.normalized() * ball_speed
	
func _physics_process(delta):
	var collision = move_and_collide(direction * delta)
	if collision:
		direction = direction.bounce(collision.normal)
		if collision.collider.is_in_group("rackets"):
			var y = direction.y / 2 + collision.collider_velocity.y
			
			direction = Vector2(direction.x, y).normalized() * (ball_speed + hitcounter + speed_commulator)
			
			if hitcounter < max_hitcounter:
				hitcounter +=1
				
			$RacketSound.play()
		else:
			$WallSound.play()
			
func reset():
	position = Vector2(513, 251)
	direction = Vector2()
	hitcounter = 0
