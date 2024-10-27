extends Bullet

func _ready() -> void:
	_getClosestEnemy()
	
func _physics_process(_delta: float) -> void:
	if closestEnemy != null:
		velocity = (global_position - closestEnemy.global_position).normalized() * -bulletSpeed
		move_and_slide()
		
	elif GameManager.NumEnemies() <= 0:
		queue_free()
	else:
		_getClosestEnemy()
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		var explosion = preload("res://Prefabs/explosion_area.tscn").instantiate()
		explosion.global_position = self.global_position
		get_tree().current_scene.call_deferred("add_child", explosion)
		queue_free()
