extends CharacterBody2D

class_name Enemy

const JUMP = 40

@export var speed = 80    # Higher speed = slower enemy and vice versa
@export var Value:int = 200

var player_in_attack_range = false

@export var health: int = 2


func _physics_process(_delta: float) -> void:
	if health <= 0:
		Player.Instance.AddScore(Value)
		queue_free()
	
	velocity = (Player.playerPos - position).normalized() * speed
	move_and_slide()
