extends Area2D

@export_enum("Cooldown","HitOnce","DisableHitBox") var HurtBoxType = 0
@onready var collision_shape_2d = $CollisionShape2D
@onready var disable_timer = $DisableTimer


signal hurt(damage)

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0: #COOLDOWN
					collision_shape_2d.call_deferred("set","disabled",true)
					disable_timer.start()
				1: #HITONCE
					pass
				2: #DISABLEHITBOX
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			emit_signal("hurt",damage)

func _on_disable_timer_timeout():
	collision_shape_2d.call_deferred("set","disabled",false)
