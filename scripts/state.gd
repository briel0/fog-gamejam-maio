class_name State extends Node

var enemy: CharacterBody2D
signal transitioned(state: State, new_state_name: String)

func enter() -> void: pass
func exit() -> void: pass
func physics_update(_delta: float) -> void: pass
