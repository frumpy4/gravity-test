extends Sprite

const DEFAULT_GRAVITY = 50
const DEFAULT_JUMP_STRENGTH = 25

var velocity = Vector2.ZERO
var gravity = DEFAULT_GRAVITY
var jump_strength = DEFAULT_JUMP_STRENGTH

signal values_updated(gravity, jump_strength, velocity, position)

func _ready():
    emit_signal("values_updated", gravity, jump_strength, velocity, OS.window_size.y - position.y)

func _input(event):
    if not event.is_pressed():
        return
        
    if event is InputEventKey:
        if event.scancode == KEY_R:
            if event.shift:
                gravity = DEFAULT_GRAVITY
                jump_strength = DEFAULT_JUMP_STRENGTH
            else:
                velocity = Vector2.ZERO
                position.y = OS.window_size.y
            
        elif event.scancode == KEY_SPACE:
            velocity.y = -jump_strength
            
        elif event.scancode == KEY_UP or event.scancode == KEY_DOWN:
            gravity += (0.1 if event.shift else 1) * (1 if event.scancode == KEY_UP else -1)
            
        elif event.scancode == KEY_LEFT or event.scancode == KEY_RIGHT:
            jump_strength += (0.1 if event.shift else 1) * (1 if event.scancode == KEY_RIGHT else -1)
            
        else:
            return
        
        emit_signal("values_updated", gravity, jump_strength, velocity, OS.window_size.y - position.y)

func _physics_process(delta):
    if velocity == Vector2.ZERO and position.y == OS.window_size.y:
        return
    
    velocity.y += gravity * delta
    position += velocity
    
    if position.y > OS.window_size.y:
        velocity = Vector2.ZERO
        position.y = OS.window_size.y
        
    emit_signal("values_updated", gravity, jump_strength, velocity, OS.window_size.y - position.y)
