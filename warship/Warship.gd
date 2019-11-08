extends KinematicBody2D

# 2019-11-09 acodemia.pl

export (float) var health = 100
export (float) var warship_speed = 80
var warship_direction = Vector2(1, 0)

func _ready():
	set_physics_process(true)
	pass
	
func _physics_process(delta):
	
	var motion = warship_direction
	
	motion = motion.normalized() * warship_speed * delta
	motion = move_and_collide(motion)
	
	if(health <= 0):
		self.queue_free()
		
	if(motion):
		print("collision...")
		
		
func update_health(damage):
	health -= damage
	print("the warship health: " + str(health))
	pass
	
	
func _on_VisibilityNotifier2D_screen_exited():
	warship_direction.x = -warship_direction.x
	scale.x = -scale.x
	pass
