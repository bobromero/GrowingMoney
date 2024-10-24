extends Node

class_name Player

@export var controller : CharacterBody2D

@export var SPEED: float = 2000;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_movement()
	controller.move_and_slide()
	
	
func _movement():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction:
		controller.velocity = direction * SPEED
	else:
		controller.velocity.x = move_toward(controller.velocity.x, 0, SPEED)
		controller.velocity.y = move_toward(controller.velocity.y, 0, SPEED)
