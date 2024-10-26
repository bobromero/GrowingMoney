extends CharacterBody2D


@export var bulletSpeed: float = 100

var Enemies:Array[Node2D]
var closestEnemy:Node2D


func _ready() -> void:
	Enemies.assign(_getEnemies())
	var closestDist = (Player.playerPos - Enemies[0].position).length()
	for e:Node2D in Enemies:
		var dist = (Player.playerPos - e.position).length()
		if dist < closestDist:
			closestDist = dist
			closestEnemy = e

func _process(delta: float) -> void:
	if closestEnemy != null:
		velocity = (position - closestEnemy.position) * bulletSpeed
		move_and_slide()
	else:
		queue_free()

func _getEnemies() -> Array[Node]:
	return get_tree().get_nodes_in_group("Enemy")


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass
