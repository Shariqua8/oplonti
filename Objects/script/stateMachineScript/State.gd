class_name State

extends Node

signal transition(new_state_name : StringName)	# Permette di comunicare con i diversi script

# Queste sono funzioni generiche per la nostra macchina a stati
func enter() -> void:
	pass

func exit() -> void:
	pass
	
func update(delta : float) -> void:
	pass

func physics_update(delta : float) -> void:
	pass
