extends Node2D


func spawn_mob():
	var new_mob = preload("res://Scenes/ninja.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	%GameOverScreen.show()
	get_tree().paused = true


func _on_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
