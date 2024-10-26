extends CharacterBody2D

const JUMP = 40

@export var speed = 80    # Higher speed = slower enemy and vice versa
@export var knockback_strength = 500
@export var knockback_duration = 0.2
@export var knockback_enabled = false
@export var knockback_timer = 0.0  

var player_in_attack_range = false

@export var health: int = 2

func _physics_process(delta: float) -> void:
	
	position += (Player.playerPos - position) / speed
	
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		health -= 1
		area.get_parent().queue_free()
