extends CharacterBody2D
@onready var sprite_2d = $Sprite2D
@onready var walking_timer = $WalkingTimer

var movement_speed = 40.0
var hp = 80

func _physics_process(delta):
	movement()
	
func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	
	if mov.x > 0:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
		
	if mov != Vector2.ZERO:
		if walking_timer.is_stopped():
			if sprite_2d.frame >= sprite_2d.hframes -1:
				sprite_2d.frame = 0
			else:
				sprite_2d.frame += 1
			walking_timer.start()
	
	velocity = mov.normalized() * movement_speed
	move_and_slide()


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
