extends Node

class_name Player

@export var controller : CharacterBody2D

@export var SPEED: float = 2000;

@export var dashPower: float = 100;

var dodgeTimer:float = 0
var dodgeTimeGap:float = .2
var shouldDodge:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = _movement()
	_dodge(direction, delta)
	
	controller.move_and_slide()
	
	
func _movement() -> Vector2:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : Vector2 = Input.get_vector("left", "right", "up", "down")
	if direction:
		controller.velocity = direction * SPEED
	else:
		controller.velocity.x = move_toward(controller.velocity.x, 0, SPEED)
		controller.velocity.y = move_toward(controller.velocity.y, 0, SPEED)
	return direction

func _dodge(direction : Vector2, delta:float):
	if !shouldDodge and Input.is_action_just_pressed("dodge"):
		shouldDodge = true
	if shouldDodge:
		controller.velocity += direction * dashPower
		print("doing something")
		dodgeTimer += delta
	if dodgeTimer >= dodgeTimeGap:
		shouldDodge = false
		dodgeTimer = 0

















	
