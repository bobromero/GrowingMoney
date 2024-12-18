extends CharacterBody2D

class_name Bullet

@export var bulletSpeed: float = 100

var Damage:int = 1

var Enemies:Array[Node2D]
var closestEnemy:Node2D


func _ready() -> void:
	_getClosestEnemy()

func _physics_process(_delta: float) -> void:
	if closestEnemy != null:
		velocity = (position - closestEnemy.global_position).normalized() * -bulletSpeed
		move_and_slide()
	elif GameManager.NumEnemies() <= 0:
		queue_free()
	else:
		_getClosestEnemy()

func _process(_delta: float) -> void:
	pass

func _getEnemies() -> Array[Node]:
	return get_tree().get_nodes_in_group("Enemy")

func _getClosestEnemy():
	Enemies.assign(_getEnemies())
	var closestDist: float = 210000000.0
	for e:Node2D in Enemies:
		var dist = (Player.playerPos - e.global_position).length()
		if dist < closestDist:
			closestDist = dist
			closestEnemy = e
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		var enemy: Enemy = area.get_parent()
		enemy.health -= Damage
		queue_free()
