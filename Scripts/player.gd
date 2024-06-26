extends CharacterBody2D

@onready var anim = %AnimatedSprite2D

signal health_depleted
var health = 100.0
var stamina = 100.0
var can_run = true
const GUN = preload("res://Scenes/gun.tscn")
var weapon_spawned = false
var new_gun = GUN.instantiate()

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	%StaminaBar.value = stamina
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
	if Input.is_action_pressed("sprint") and can_run and velocity.length() > 0.0:
		stamina -= 20 * delta
		velocity *= 2
		if stamina <= 0:
			can_run = false
	else: 
		if stamina < 100.0:
			stamina += 30 * delta
			if stamina >= 20:
				can_run = true
	if velocity.length() > 0.0 and velocity.length() <= 600:
		anim.play("walk")
	elif velocity.length() > 600:
		anim.play("sprint")
	else:
		anim.play("idle")
	move_and_slide()
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		%HealthBar.value = health
		health -= 10.0 * overlapping_mobs.size() * delta
		if health <= 0:
			health_depleted.emit()

#func spawn_weapon():
	#new_gun = GUN.instantiate()
	#%WeaponPosition.add_child(new_gun)
	#
#func remove_weapon():
#
	#
