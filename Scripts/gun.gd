extends Area2D

@onready var anim = %Pistol
@onready var shooting_sound = %PistolSound

#func _input(event):
	#if event is InputEventMouseButton:
		#print("mouse click at: ", event.position)
	#elif event is InputEventMouseMotion:
		#look_at(event.position)
		#print("mouse motion at: ", event.position)
		#print("viewport motion at: ", )
		
var deadzone := 0.05
var can_fire = true
var fire_rate = 0.3
var ammos = 7
var reload_time = 1
var is_reloading = false


func _ready():
	remove_child(shooting_sound)
	get_parent().add_child(shooting_sound)
	%ReloadTimer.wait_time = reload_time

	# Controller deadzone
	InputMap.action_set_deadzone("aim_up", deadzone)
	InputMap.action_set_deadzone("aim_down", deadzone)
	InputMap.action_set_deadzone("aim_left", deadzone)
	InputMap.action_set_deadzone("aim_right", deadzone)

func _process(delta):
	look_at(get_global_mouse_position())
	#if get_global_mouse_position().x > get_parent().global_position.x:
		#print("right")
	#else:
		#print("left")

	
func _physics_process(delta):
	if Input.is_action_pressed("shoot") and can_fire and ammos > 0 and not is_reloading:
		anim.play("shoot")
		shoot()
		can_fire = false
		print(ammos)
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
		ammos -= 1
		
	if Input.is_action_pressed("reload") and not is_reloading:
		reload()
	#
	 ##Controller aim	
	#var look_vector = Vector2(0, 0)
	#look_vector.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	#look_vector.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	#print(look_vector.x)
	#look_at(global_position + look_vector)
	#if look_vector.x <= -0.2:
		#anim.flip_v = true
	#else:
		#anim.flip_v = false
		

func shoot():
	shooting_sound.play()
	const BULLET = preload("res://Scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	# add bullet to parent node to avoid bullet disappearing when removing weapon
	get_parent().add_child(new_bullet)
	
func reload():
	%PistolReloadSound.play()
	print("reloading..")
	is_reloading = true
	can_fire = false
	%ReloadTimer.start()
		


func _on_reload_timer_timeout():
		ammos = 7
		is_reloading = false
		can_fire = true
		%ReloadTimer.stop()
		print("reloaded!")
