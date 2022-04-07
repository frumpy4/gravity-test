extends Label

func _on_Woggers_values_updated(gravity, jump_strength, velocity, height):
    text = "Gravity: %s\nJump strength: %s\nVelocity (y): %s\nHeight: %s" % [gravity, jump_strength, -velocity.y, height]
