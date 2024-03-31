extends Sprite2D

#@onready var player = get_node("/root/Game/player")

func _physics_process(delta):
	const BLOOD = preload("res://Scenes/ground_blood.tscn")
	var new_blood = BLOOD.instantiate()
	await get_tree().create_timer(0.3).timeout
	get_parent().add_child(new_blood)
	new_blood.global_position = %bloodStart.global_position
	new_blood.play("spread")

func play_dead_sound():
	%HitSound.play()
	%DeadSound.play()
