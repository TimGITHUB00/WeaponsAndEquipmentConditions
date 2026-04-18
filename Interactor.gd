extends "res://Scripts/Interactor.gd"

var conditionSettings = preload("res://WeaponsAndEquipmentConditions/ConditionSettings.tres")

func _physics_process(_delta):
	super(_delta)

	if Engine.get_physics_frames() % 5 != 0:
		return

	if not conditionSettings.conditionEnabled:
		return

	if not gameData.interaction:
		return

	if target == null or not is_instance_valid(target):
		return

	if not target.is_in_group("Item"):
		return

	var slotData = target.get("slotData")
	if slotData == null or slotData.itemData == null:
		return

	if not _should_show_condition(slotData):
		return

	var suffix := " " + _format_condition(slotData.condition)
	if not str(gameData.tooltip).ends_with(suffix):
		gameData.tooltip = str(gameData.tooltip) + suffix

func _should_show_condition(slotData) -> bool:
	if slotData.itemData.showCondition:
		return true

	if slotData.itemData.type == "Rig" and slotData.nested.size() != 0:
		for nested in slotData.nested:
			if nested.type == "Armor":
				return true

	return false

func _format_condition(value: float) -> String:
	var color := "green"
	if value <= 25:
		color = "red"
	elif value <= 50:
		color = "yellow"

	return "[color=%s](%s%%)[/color]" % [color, str(int(round(value)))]
