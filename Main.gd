extends Node

func _ready() -> void:
	overrideScript("res://WeaponsAndEquipmentConditions/Pickup.gd")
	overrideScript("res://WeaponsAndEquipmentConditions/Interactor.gd")
	overrideScript("res://WeaponsAndEquipmentConditions/HUD.gd")

func overrideScript(overrideScriptPath : String):
	var script : Script = load(overrideScriptPath)
	script.reload()
	var parentScript = script.get_base_script()
	script.take_over_path(parentScript.resource_path)
