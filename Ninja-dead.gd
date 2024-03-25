extends Sprite2D


func _physics_process(delta):
	const BLOOD = preload("res://ground_blood.tscn")
	var new_blood = BLOOD.instantiate()
	await get_tree().create_timer(0.3).timeout
	get_parent().add_child(new_blood)
	new_blood.global_position = %bloodStart.global_position
	new_blood.play("spread")
