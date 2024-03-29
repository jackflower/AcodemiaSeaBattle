extends KinematicBody2D

# 2019-11-09 acodemia.pl
# Update:
# 2024-02-15 acodemia.pl


var torpedo_speed = 200
var torpedo_direction = Vector2(0, -1)
var caliber = 1

func _ready():
	set_physics_process(true)
	pass
	
	
func _physics_process(delta):
	
	var motion = Vector2()
	motion += Vector2(torpedo_direction)
	
	motion = motion.normalized() * torpedo_speed * delta
	motion = move_and_collide(motion)
	
	if(motion):
		# check with what object the missile interferes
		var entity = motion.collider
		# the name of the object from which the bullet collided
		var napis = "the torpedo hit in: "
		print (napis + entity.get_name())
		# health update of the hit object
		if(entity.has_method("update_health")):
			entity.update_health(int(caliber))
			pass
		explode()
		napis = "the torpedo explode"
		print (napis)
		queue_free()
	pass
	
	
func explode():
	var explosion = preload("res://explosion/Explosion.tscn").instance()
	explosion.global_position = global_position
	explosion.global_scale = self.global_scale
	explosion.get_node("AnimatedSprite").get_sprite_frames().set_animation_speed(explosion.get_node("AnimatedSprite").get_animation(), torpedo_speed)
	get_parent().add_child(explosion)
	pass
	
	
func _on_VisibilityNotifier2D_screen_exited():
	print("the torpedo left the screen...")
	queue_free()
	pass

