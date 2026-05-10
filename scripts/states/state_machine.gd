class_name StateMachine extends Node

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

var enemy: CharacterBody2D

func _ready() -> void:
    enemy = get_parent() as CharacterBody2D
    
    for child in get_children():
        if child is State:
            states[child.name.to_lower()] = child
            child.enemy = enemy
            child.transitioned.connect(_on_child_transitioned)
            
    if initial_state:
        initial_state.enter()
        current_state = initial_state
            
func _physics_process(delta: float) -> void:
    
    if current_state.name.to_lower() == "patrolstate" and enemy.target != null:
        change_state("chasestate")
    elif current_state.name.to_lower() == "chasestate" and enemy.target == null:
        change_state("patrolstate")
    
    if current_state:
        current_state.physics_update(delta)
        
func change_state(new_state_name: String) -> void:
    var new_state = states.get(new_state_name.to_lower())
    if not new_state or new_state == current_state: 
        return
    
    if current_state:
        current_state.exit()
        
    new_state.enter()
    current_state = new_state

func _on_child_transitioned(state: State, new_state_name: String) -> void:
    if state != current_state: return
    change_state(new_state_name)
