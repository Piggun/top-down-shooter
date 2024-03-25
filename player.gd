extends CharacterBody2D

@onready var anim = %AnimatedSprite2D

const GUN = preload("res://gun.tscn")
var weapon_spawned = false
var new_gun = GUN.instantiate()

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	if Input.is_action_pressed("aim"):
		velocity *= 0.5	
		if not weapon_spawned:
			new_gun.global_position = %WeaponPosition.position
			%WeaponPosition.add_child(new_gun)
			weapon_spawned = true
	if Input.is_action_just_released("aim"):
		%WeaponPosition.remove_child(new_gun)
		#new_gun.queue_free()
		weapon_spawned = false
	if Input.is_action_pressed("sprint"):
		velocity *= 2
	if velocity.length() > 0.0 and velocity.length() <= 600:
		anim.play("walk")
	elif velocity.length() > 600:
		anim.play("sprint")
	else:
		anim.play("idle")
	move_and_slide()

#func spawn_weapon():
	#new_gun = GUN.instantiate()
	#%WeaponPosition.add_child(new_gun)
	#
#func remove_weapon():
#
	#
