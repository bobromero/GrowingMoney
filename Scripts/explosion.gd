extends Bullet

func _ready() -> void:
	_getClosestEnemy()
	
var destroy: bool =false

func _physics_process(delta: float) -> void:
	if destroy:
		queue_free()
	if closestEnemy != null:
		velocity = (position - closestEnemy.global_position).normalized() * -bulletSpeed
		move_and_slide()
		if abs(position.length() - closestEnemy.global_position.length()) <= 5:
			var explosion = preload("res://Prefabs/explosion_area.tscn").instantiate()
			self.add_child(explosion)
			destroy=true
	elif GameManager.NumEnemies() <= 0:
		queue_free()
	else:
		_getClosestEnemy()
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		#spawn explosion
		#$ExplosionArea/explosion.add_to_group("Bullet")
		pass
