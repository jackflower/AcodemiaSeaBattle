extends KinematicBody2D

# 2019-11-09 acodemia.pl

var motion_speed = 100
var shooting = false
var torpedo_data = preload("res://torpedo/Torpedo.tscn")

var created_torpedo_scale_factor = 0.5
export (float) var created_torpedo_speed = 200
export (float) var torpedo_caliber = 2

func _ready():
	set_physics_process(true)
	pass
	
func _physics_process(delta):
	
	var motion = Vector2()
	if (Input.is_action_pressed("ui_left")):
		motion += Vector2(-1, 0)
	if (Input.is_action_pressed("ui_right")):
		motion += Vector2(1, 0)
		
	if (Input.is_action_pressed("Shoot")):
		if(shooting):
			createTorpedo()
		pass
		
	motion = motion.normalized() * motion_speed * delta
	motion = move_and_collide(motion)
	
	pass
	
	
func createTorpedo():
	
	# tworzymy torpedę
	var torpedo = torpedo_data.instance()
	# ustawiamy jej pozycję startową
	torpedo.position = $TorpedoPosition2D.global_position
	# ustawiamy skalę
	torpedo.global_scale = global_scale * created_torpedo_scale_factor
	# prędkość torpedy
	torpedo.torpedo_speed = created_torpedo_speed
	# kaliber - siła rażenia
	torpedo.caliber = torpedo_caliber
	# dodajemy torpedę do sceny
	get_parent().add_child(torpedo)
	
	shooting = false
	pass
	
	
func _on_TimerShoot_timeout():
	shooting = true
	pass
