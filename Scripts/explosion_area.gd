extends Area2D

var timer:float = 0
var flash:float = .2
var Damage:int = 3
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer > flash:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		var enemy: Enemy = area.get_parent()
		enemy.health -= Damage
